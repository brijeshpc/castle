<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use Validator, DateTime, DB;
use Carbon\Carbon;

use App\Models\Admin;
use App\Models\Coupon;
use App\Models\User;
use App\Models\Product;
use App\Models\Sale;
use App\Models\UserNotification;
use App\Models\SaleConflict;
use App\Models\ProductReview;

use App\Http\Controllers\Api\HomeController;

class SaleController extends Controller
{

//////////////////////////		Buy Product    ///////////////////////////////
public static function buy_product(Request $request)
	{
	try{

			$user = \App('user');

			$rules = [
						'product_id' => 'required|exists:products,id,deleted,0,blocked,0,product_status,List',
						'buyer_address_id' => 'required|exists:user_address,id,user_id,'.$user->id
					 ];

			$msg =   [
						'product_id.exists' => 'Sorry, this product is no longer available',
						'buyer_address_id.exists' => 'Please add your default address'
					 ];

			$validation = Validator::make($request->all(), $rules, $msg);
			if($validation->fails())
				return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$buyer = User::get_buyer_info($request->all());

			if(!isset($request['stripe_token']))
				{

					if(count($buyer->user_cards) == 0)
						return response(['success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, you need to add a default card for making payment')],200);

					$request['buyer_card_id'] = $buyer->user_cards[0]->id;
					$request['sale_type'] = "Card";

				}
			else
				{

					$request['buyer_card_id'] = 0;
					$request['sale_type'] = "ApplePay";
				}


			$product = Product::get_product_before_sale($request->all());
			if($product->user->stripe_connect_id == '' || count($product->user->user_accounts) == 0 || $product->user->stripe_connect_account_status == 'REJECTED')
				return response(['success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this seller is currently not available')],200);

			if($buyer->id == $product->user_id)
				return response(['success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, you cannot purchase your own product')],200);				

			$admin = Admin::first();

/////////////////////////		payment Amount 		//////////////////////////////////
			$request['seller_id'] = $product->user_id;
			$request['seller_account_id'] = $product->user->user_accounts[0]->id;
			$request['buyer_id'] = $buyer->id;
			

			$request['product_price'] = $product->base_price;	//Product Price
			$request['shipping_price'] = $product->shipping_price;//	Shipping Price

			$request['shipping_paid_by'] = $product->shipping_paid_by;//	Shipping Paid By
			if($request['shipping_paid_by'] == 'Seller')
				{
					$request['admin_charge'] = round((($request['product_price']/100)*$admin->admin_fee),2);
					$request['sub_sub_total_price'] = $request['product_price'];// + $request['admin_charge'];//	Sub Total
					$request['seller_cut'] = round(($request['product_price'] - $request['admin_charge']),2) ;
				}
			else
				{
					$request['admin_charge'] = ((($request['product_price']+$request['shipping_price'])/100)*$admin->admin_fee);//	Admin Charges
					$request['sub_sub_total_price'] = $request['product_price'] + $request['shipping_price'];//	Sub Total
					$request['seller_cut'] = round(($request['sub_sub_total_price'] - $request['admin_charge']),2);
				}

/////////////////////////		payment Amount 		//////////////////////////////////

////////////////////////		Coupon Check 	///////////////////////////////////////
			if(isset($request['coupon_id']) && $request['coupon_id'] != "")
				{
					$coupon = Coupon::where('id',$request['coupon_id'])->where('deleted','0')->where('blocked','0')
						->select('*',
							DB::RAW("(SELECT COUNT(*) FROM sales WHERE coupon_id=coupons.id) as used_count"),
							DB::RAW("(SELECT COUNT(*) FROM sales WHERE coupon_id=coupons.id AND buyer_id='".$user->id."' ) as user_used_count")
						)
						->first();
					if(!$coupon)
						return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this coupon is no longer available')),200);
					elseif($coupon->user_used_count > 0)
						return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this coupon is already been used by you')),200);
					elseif($coupon->used_count >= $coupon->maximum_users)
						return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this coupon has reached its maximum use limit')),200);

					if($request['sub_sub_total_price'] < $coupon->minimum_amount_required)
						return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this coupon can be applied on purchase of minimum $').$coupon->minimum_amount_required),200);

					$coupon->coupon_expiry = Carbon::createFromFormat('Y-m-d H:i:s',$coupon->expires_at,'UTC');
					if($coupon->coupon_expiry->isPast())
						return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this coupon has expired')),200);

					$request['now'] = Carbon::now();
					$coupon->start_atz = Carbon::createFromFormat('Y-m-d H:i:s',$coupon->start_at,'UTC');
					$coupon->expires_atz = Carbon::createFromFormat('Y-m-d H:i:s',$coupon->expires_at,'UTC');

					if(!$request['now']->between($coupon->start_atz, $coupon->expires_atz))
						return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this coupon is currently not available')),200);

					$request['coupon_percentage_value'] = $coupon->percentage_value;
				}
			else
				{
					$request['coupon_id'] = 0;
					$request['coupon_percentage_value'] = 0;
				}
////////////////////////		Coupon Check 	///////////////////////////////////////

					$request['final_admin_cut'] = round(($request['admin_charge'] - ($request['admin_charge']/100)*$request['coupon_percentage_value']),2);
					$request['final_seller_cut'] = $request['seller_cut'];
					//$request['seller_cut'] - ($request['seller_cut']/100)*$request['coupon_percentage_value'];
					$request['final_total_price'] = $request['final_admin_cut'] + $request['final_seller_cut'];

					$request['sale_id'] = Sale::insert_new_sale($request->all());

////////////////////////////		Stripe payment 		//////////////////////////////////////////
				\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));


			if(!isset($request['stripe_token']))
				{

					$charge = \Stripe\Charge::create(array(
					  	"amount" => $request['final_total_price']*100,
					  	"currency" => "usd",
					  	"application_fee" => $request['final_admin_cut']*100,
					  	"capture" => true,
					  	"destination" => array(
					    	"account" => $product->user->stripe_connect_id
					  			),
					  	"transfer_group" => $request['sale_id'],
					  	"customer" => $user->stripe_customer_id,					
						"metadata" => [
							"sale_id" => $request['sale_id'],
							"seller_id" => $request['seller_id'],
							"buyer_id" => $request['buyer_id'],
							"product_id" => $request['product_id']
							  			],
						"description" => env('APP_NAME').' Payment for '.$product->name,
						"statement_descriptor" => env('APP_NAME').' Payment',
						"receipt_email" => $user->email,
						"expand" => ['balance_transaction','application_fee','on_behalf_of','transfer']
							));

				}
			else
				{


					$charge = \Stripe\Charge::create(array(
					  	"amount" => $request['final_total_price']*100,
					  	"currency" => "usd",
					  	"application_fee" => $request['final_admin_cut']*100,
					  	"capture" => true,
					  	"destination" => array(
					    	"account" => $product->user->stripe_connect_id
					  			),
					  	"transfer_group" => $request['sale_id'],
					  	"metadata" => [
							"sale_id" => $request['sale_id'],
							"seller_id" => $request['seller_id'],
							"buyer_id" => $request['buyer_id'],
							"product_id" => $request['product_id']
							  			],
						"description" => env('APP_NAME').' Payment for '.$product->name,
						"statement_descriptor" => env('APP_NAME').' Payment',
						"receipt_email" => $user->email,
						"expand" => ['balance_transaction','application_fee','on_behalf_of','transfer'],
						"source"=> $request['stripe_token']
							));


				}


				// $charge = \Stripe\Charge::create(array(// Create a Charge:
				// 		  "amount" => $request['final_total_price']*100,
				// 		  "currency" => "usd",
				// 		  "capture" => true,
				// 		  "on_behalf_of" =>  $product->user->stripe_connect_id,
				// 		  "customer" => $user->stripe_customer_id,
				// 		  "transfer_group" => $request['sale_id'],
				// 		  "metadata" => [
				// 		  		"sale_id" => $request['sale_id'],
				// 		  		"seller_id" => $request['seller_id'],
				// 		  		"buyer_id" => $request['buyer_id'],
				// 		  		"product_id" => $request['product_id']
				// 		  			],
				// 		  "description" => env('APP_NAME').' Payment for '.$product->name,
				// 		  "statement_descriptor" => env('APP_NAME').' Payment',
				// 		  "receipt_email" => $user->email,
				// 		  "expand" => ['balance_transaction','application_fee', 'on_behalf_of']
				// 		));// Create a Charge:

////////////////////////////		Stripe payment 		//////////////////////////////////////////

			if($charge['status'] == "succeeded")
				{
////////////////////////////		Socket event 		//////////////////////////////
					$socket_data = array(
							'receiver_id'=>$request['seller_id'],
							'sender_id'=>$user->id,
							'product_id'=>$request['product_id'],
							'type'=>'ProductBought',
							'chat_id' => 0,
							'sale_id'=>$request['sale_id']
								);

					$redis = \Illuminate\Support\Facades\Redis::connection();
					$redis->publish('message',json_encode($socket_data));
////////////////////////////		Socket event 		//////////////////////////////

					$request['charge_id'] = $charge['id'];
					// $request['seller_transer_id'] = ''; //$charge['transfer']->id;
					$request['seller_transer_id'] = $charge['transfer']->id;

					$request['stripe_transaction_fee'] =  isset($charge['balance_transaction']->fee) ? ($charge['balance_transaction']->fee/100) : 0;
					$request['product_status'] = 'Sold';

					Sale::update_sale_admin_payment($request->all());
					Product::update_product_status($request->all());

//////////////////////		Push Notifications 		///////////////////////////////////
					$request['receiver_id'] = $request['seller_id'];
					$request['message'] = trans('messages.A item has been purchased');
					$request['type'] = 'ProductPurchase';
					$request['is_action'] = '1';
					UserNotification::insert_new_notifications($request->all());

					$ouser = $product->user;
					if($ouser->fcm_id != '' && $ouser->push_notifications == '1')
						{
									$push_data = [
												'type' => $request['type'],
												'message' => $request['message'],
												'sender_id' => $user->id,
												'product_id' => $request['product_id'],
												'chat_id' => 0,
												'sale_id' => $request['sale_id']
													];

									$request['fcm_id'] = $ouser->fcm_id;
									$request['badge'] = $ouser->not_count+1;

							HomeController::send_single_push($request->all(), $push_data);
						}
//////////////////////		Push Notifications 		///////////////////////////////////
				}
			else
				{
					$request['admin_payment_failure_reason'] = $charge['message'];
					Sale::update_sale_admin_payment_failure($request->all());
				}

///////////////////////		Mail 	//////////////////////
			$osale = Sale::sale_complete_details($request->all());

			$mail = \Mail::send('Emails.Api.Sale.productPurchase', array('osale'=>$osale, 'sender'=>$admin, 'msg' => 'Item is purchased'),
				function($message) use ($osale)
					{
	    				$message->to($osale->seller->email, $osale->seller->first_name)->subject($osale->product->name.' is purchased');
	        		});
///////////////////////		Mail 	//////////////////////

				$data = [
							//'charge' => $charge,
							'charge' => $charge,
							'sale' => $osale
						];

			return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.Item purchased successfully'), 'data' => $data ),200);

		}
	catch(\Exception $e)
		{

			if(isset($request['sale_id']))
				{
					$request['admin_payment_failure_reason'] = $e->getMessage();
					Sale::update_sale_admin_payment_failure($request->all());

				}

			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

///////////////////////////			New Shipped The Item 		.///////////////////////////////////////////

public static function product_shipped(Request $request)
	{
	try{

			$rules = [
						'sale_id' => 'required|exists:sales,id'
					 ];

			$msg =   [
						'sale_id.exists' => 'Sorry, this sale is no longer available'
					 ];

			$validation = Validator::make($request->all(), $rules, $msg);
			if($validation->fails())
				return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$user = \App('user');

			$sale = Sale::sale_details_seller_get($request->all());
			if($sale->seller_id != $user->id)
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale do not belong to you')),200);
			elseif($sale->shipment_status != 'SellerPending')
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale shipment is not pending')),200);
			elseif($sale->sale_status != 'AdminPaymentDone')
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale is no longer available for shipment')),200);

			$request['type'] = $request['shipment_status'] = 'SellerShipped';
			$request['product_id'] = $sale->product_id;
			$request['receiver_id'] = $sale->buyer_id;
			$request['sender_id'] = $user->id;

			Sale::seller_update_shipment_status($request->all());

////////////////////////////		Socket event 		//////////////////////////////
			$socket_data = array(
				'receiver_id'=> $request['receiver_id'],
				'sender_id'=> $request['sender_id'],
				'product_id'=> $request['product_id'],
				'sale_id'=> $request['sale_id'],
				'chat_id' => 0,
				'type'=> $request['shipment_status']
					);

					$redis = \Illuminate\Support\Facades\Redis::connection();
					$redis->publish('message',json_encode($socket_data));
////////////////////////////		Socket event 		//////////////////////////////

//////////////////////		Push Notifications 		///////////////////////////////////
					$request['message'] = $user->first_name.trans('messages. has shipped your purchased item.');
					$request['is_action'] = '1';
					UserNotification::insert_new_notifications($request->all());

					$ouser = $sale->buyer;
					if($ouser->fcm_id != '' && $ouser->push_notifications == '1')
						{
							$push_data = [
									'type' => $request['type'],
									'message' => $request['message'],
									'sender_id' => $request['sender_id'],
									'product_id' => $request['product_id'],
									'chat_id' => 0,
									'sale_id' => $request['sale_id']
										];

									$request['fcm_id'] = $ouser->fcm_id;
									$request['badge'] = $ouser->not_count+1;

							HomeController::send_single_push($request->all(), $push_data);
						}
//////////////////////		Push Notifications 		///////////////////////////////////

///////////////////////		Mail 	//////////////////////
			$osale = Sale::sale_complete_details($request->all());
			$admin = Admin::first();

			$mail = \Mail::send('Emails.Api.Sale.productPurchase', array('osale'=>$osale, 'sender'=>$admin, 'msg' => 'Item is shipped'),
				function($message) use ($osale)
					{
	    				$message->to($osale->buyer->email, $osale->buyer->first_name)->subject($osale->product->name.' is shipped');
	        		});
///////////////////////		Mail 	//////////////////////

			return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.Item shipped successfully')),200);

		}
	catch(\Exception $e)
		{
			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

///////////////////////////				Seller Cancels Sale 		///////////////////////////////////////////////

public static function sale_cancel(Request $request)
	{
	try{

			$rules = [
						'sale_id' => 'required|exists:sales,id',
						'cancelled_reason' => 'required'
					 ];

			$msg =   [
						'sale_id.exists' => 'Sorry, this sale is no longer available'
					 ];

			$validation = Validator::make($request->all(), $rules, $msg);
			if($validation->fails())
				return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$user = \App('user');

			$sale = Sale::sale_details_seller_get($request->all());
			if($sale->seller_id != $user->id)
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale do not belong to you')),200);
			elseif($sale->sale_status != 'AdminPaymentDone' || $sale->shipment_status == 'SellerShipped')
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale can no longer be cancelled')),200);

			$request['sale_status'] = $request['type'] = $request['shipment_status'] = 'SellerCancelled';
			$request['refund_status'] = $request['admin_payment_status'] = $request['seller_payment_status'] = 'FullRefund';
			$request['product_id'] = $sale->product_id;
			$request['receiver_id'] = $sale->buyer_id;
			$request['sender_id'] = $user->id;

			\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

			$refund = \Stripe\Refund::create(array(
					  	"charge" => $sale->charge_id,
					  	"metadata" => [
								"sale_id" => $request['sale_id'],
						  		"seller_id" => $request['seller_id'],
						  		"buyer_id" => $request['buyer_id'],
						  		"product_id" => $request['product_id'],
						  		"type" => $request['sale_status']
					  					]
					));

			if($refund['status'] != 'succeeded')
				{
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Something went wrong. Please try again')),200);
				}

			$request['refund_id'] = $refund['id'];
			$request['product_status'] = 'List';

			Sale::sale_cancel_order_common($request->all());
			Product::update_product_status($request->all());

			SaleConflict::where('created_by','Seller')
			->where('sale_id',$request['sale_id'])->where('status', 'Raised')
			->update([
				'admin_read' => '1',
				'status' => 'SellerCancelled',
				'conflict_action' => 'SellerCancelled',
				'updated_at' => new \DateTime
					]);

////////////////////////////		Socket event 		//////////////////////////////
					$socket_data = array(
							'receiver_id'=> $request['receiver_id'],
							'sender_id'=> $request['sender_id'],
							'product_id'=> $request['product_id'],
							'sale_id'=> $request['sale_id'],
							'chat_id'=> 0,
							'type'=> $request['type'],
								);

					$redis = \Illuminate\Support\Facades\Redis::connection();
					$redis->publish('message',json_encode($socket_data));
////////////////////////////		Socket event 		//////////////////////////////

//////////////////////		Push Notifications 		///////////////////////////////////
					$request['message'] = trans('messages.Your order was cancelled by seller');
					$request['is_action'] = '1';
					UserNotification::insert_new_notifications($request->all());

					$ouser = $sale->buyer;
					if($ouser->fcm_id != '' && $ouser->push_notifications == '1')
						{
							$push_data = [
									'type' => $request['type'],
									'message' => $request['message'],
									'sender_id' => $request['sender_id'],
									'product_id' => $request['product_id'],
									'chat_id' => 0,
									'sale_id' => $request['sale_id']
										];

									$request['fcm_id'] = $ouser->fcm_id;
									$request['badge'] = $ouser->not_count+1;

							HomeController::send_single_push($request->all(), $push_data);
						}
//////////////////////		Push Notifications 		///////////////////////////////////

///////////////////////		Mail 	//////////////////////
			$osale = Sale::sale_complete_details($request->all());
			$admin = Admin::first();

			$mail = \Mail::send('Emails.Api.Sale.productPurchase', array('osale'=>$osale, 'sender'=>$admin, 'msg' => 'Item sale is cancelled'),
				function($message) use ($osale)
					{
	    				$message->to($osale->buyer->email, $osale->buyer->first_name)->subject($osale->product->name.' sale is cancelled');
	        		});
///////////////////////		Mail 	//////////////////////

			return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.Sale Cancelled successfully')),200);

		}
	catch(\Exception $e)
		{
			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

///////////////////////////		New Buyer Product Received 		///////////////////////////////////////////////////

	public static function new_product_received(Request $request)
		{
		try{

				$rules = [
							'sale_id' => 'required|exists:sales,id'
						 ];

				$msg =   [
							'sale_id.exists' => 'Sorry, this sale is no longer available'
						 ];

				$validation = Validator::make($request->all(), $rules, $msg);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$sale = Sale::sale_details_buyer_get($request->all());
				if($sale->buyer_id != $user->id)
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale do not belong to you')),200);
				elseif($sale->sale_status != 'AdminPaymentDone')
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale is currently not available')),200);

				$request["type"] = $request['sale_status'] = $request['shipment_status'] = 'BuyerConfirmed';
				$request['refund_status'] = 'NotRequired';
				$request['product_id'] = $sale->product_id;
				$request['receiver_id'] = $sale->seller_id;
				$request['sender_id'] = $user->id;
				$request['seller_payment_status'] = 'WeekEndWait';

				Sale::new_buyer_confirm_order($request->all());

				SaleConflict::where('created_by','Buyer')
					->where('sale_id',$request['sale_id'])->where('status', 'Raised')
						->update([
							'admin_read' => '1',
							'status' => 'BuyerConfirmed',
							'conflict_action' => 'BuyerConfirmed',
							'updated_at' => new \DateTime
								]);

	////////////////////////////		Socket event 		//////////////////////////////
				$socket_data = array(
								'receiver_id'=> $request['receiver_id'],
								'sender_id'=> $request['sender_id'],
								'product_id'=> $request['product_id'],
								'sale_id'=> $request['sale_id'],
								'chat_id'=> 0,
								'type'=> $request["type"]
									);

				$redis = \Illuminate\Support\Facades\Redis::connection();
				$redis->publish('message',json_encode($socket_data));
	////////////////////////////		Socket event 		//////////////////////////////

	//////////////////////		Push Notifications 		///////////////////////////////////

		////////////	To Seller 		///////////////////////////
				$request['message'] = $user->first_name.trans('messages. has received your item.');
				$request['is_action'] = '1';
				UserNotification::insert_new_notifications($request->all());

				$ouser = $sale->seller;
				if($ouser->fcm_id != '' && $ouser->push_notifications == '1')
					{
						$push_data = [
								'type' => $request['type'],
								'message' => $request['message'],
								'sender_id' => $request['sender_id'],
								'product_id' => $request['product_id'],
								'chat_id' => 0,
								'sale_id' => $request['sale_id']
									];

						$request['fcm_id'] = $ouser->fcm_id;
						$request['badge'] = $ouser->not_count+2;

						HomeController::send_single_push($request->all(), $push_data);
					}
		////////////	To Seller 		///////////////////////////


		////////////	Review Notification 		//////////////////////
				$request['receiver_id'] = $sale->buyer_id;
				$request['sender_id'] = $sale->seller_id;
				$request['message'] = trans('messages.Please rate your seller!');
				$request['type'] = 'ReviewSale';
				$request['is_action'] = '1';
				UserNotification::insert_new_notifications($request->all());
		////////////	To Buyer 		///////////////////////////

		//////////////////////		Push Notifications 		///////////////////////////////////
				$data = [
							'sale' => $sale
						];
///////////////////////		Mail 	//////////////////////
			$osale = Sale::sale_complete_details($request->all());
			$admin = Admin::first();

			$mail = \Mail::send('Emails.Api.Sale.productPurchase', array('osale'=>$osale, 'sender'=>$admin, 'msg' => 'Item received successfully'),
				function($message) use ($osale)
					{
	    				$message->to($osale->seller->email, $osale->seller->first_name)->subject($osale->product->name.' received successfully');
	        		});
///////////////////////		Mail 	//////////////////////

				return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.Item received successfully'), 'data' => $data),200);



			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////////////				Buyer Product Received 		///////////////////////////////////////////////

	public static function product_received(Request $request)
		{
		try{
				$rules = [
							'sale_id' => 'required|exists:sales,id'
						 ];

				$msg =   [
							'sale_id.exists' => 'Sorry, this sale is no longer available'
						 ];

				$validation = Validator::make($request->all(), $rules, $msg);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$sale = Sale::sale_details_buyer_get($request->all());
				if($sale->buyer_id != $user->id)
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale do not belong to you')),200);
				elseif($sale->sale_status != 'AdminPaymentDone')
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale is currently not available')),200);

				$request["type"] = $request['sale_status'] = $request['shipment_status'] = 'BuyerConfirmed';
				$request['refund_status'] = 'NotRequired';
				$request['product_id'] = $sale->product_id;
				$request['receiver_id'] = $sale->seller_id;
				$request['sender_id'] = $user->id;
				$request['seller_payment_status'] = 'Success';
				$request['seller_account_id'] = $sale->seller->user_accounts[0]->id;

				\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

				// Create a Transfer to a connected account (later):
				// $transfer = \Stripe\Transfer::create(array(
				// 	"amount" => $sale->final_seller_cut*100,
				// 	"currency" => "usd",
				// 	"destination" => $sale->seller->stripe_connect_id,
				// 	"transfer_group" => $request['sale_id'],
				// 	"metadata" => [
				// 				  	"sale_id" => $request['sale_id'],
				// 				  	"seller_id" =>$sale->seller_id,
				// 				  	"buyer_id" => $sale->buyer_id,
				// 				  	"product_id" => $sale->product_id,
				// 				  	"type" => $request["type"]
				// 				  ]							  	
				// ));

				$payout = \Stripe\Payout::create(array(
				    "amount" => $sale->final_seller_cut*100,
				    "currency" => "usd",
					"description" => env('APP_NAME').' Payment for '.$sale->product->name,
					"statement_descriptor" => env('APP_NAME').' Payment',
				    //"source_type" => "bank_account",
				    "method" => "standard",
					"metadata" => [
									  	"sale_id" => $request['sale_id'],
									  	"seller_id" =>$sale->seller_id,
									  	"buyer_id" => $sale->buyer_id,
									  	"product_id" => $sale->product_id,
									  	"type" => $request["type"]
								]	
				), array("stripe_account" => $sale->seller->stripe_connect_id));

				$request['seller_transaction_id'] = $payout['id'];

				Sale::buyer_confirm_order($request->all());

				SaleConflict::where('created_by','Buyer')
					->where('sale_id',$request['sale_id'])->where('status', 'Raised')
						->update([
							'admin_read' => '1',
							'status' => 'BuyerConfirmed',
							'conflict_action' => 'BuyerConfirmed',
							'updated_at' => new \DateTime
								]);

	////////////////////////////		Socket event 		//////////////////////////////
				$socket_data = array(
								'receiver_id'=> $request['receiver_id'],
								'sender_id'=> $request['sender_id'],
								'product_id'=> $request['product_id'],
								'sale_id'=> $request['sale_id'],
								'chat_id'=> 0,
								'type'=> $request["type"]
									);

				$redis = \Illuminate\Support\Facades\Redis::connection();
				$redis->publish('message',json_encode($socket_data));
	////////////////////////////		Socket event 		//////////////////////////////

	//////////////////////		Push Notifications 		///////////////////////////////////

		////////////	To Seller 		///////////////////////////
				$request['message'] = $user->first_name.trans('messages. has received your item.');
				$request['is_action'] = '1';
				UserNotification::insert_new_notifications($request->all());

				$ouser = $sale->seller;
				if($ouser->fcm_id != '' && $ouser->push_notifications == '1')
					{
						$push_data = [
								'type' => $request['type'],
								'message' => $request['message'],
								'sender_id' => $request['sender_id'],
								'product_id' => $request['product_id'],
								'chat_id' => 0,
								'sale_id' => $request['sale_id']
									];

						$request['fcm_id'] = $ouser->fcm_id;
						$request['badge'] = $ouser->not_count+2;

						HomeController::send_single_push($request->all(), $push_data);
					}
		////////////	To Seller 		///////////////////////////


		////////////	Review Notification 		//////////////////////
				$request['receiver_id'] = $sale->buyer_id;
				$request['sender_id'] = $sale->seller_id;
				$request['message'] = trans('messages.Please rate your seller!');
				$request['type'] = 'ReviewSale';
				$request['is_action'] = '1';
				UserNotification::insert_new_notifications($request->all());
		////////////	To Buyer 		///////////////////////////


		//////////////////////		Push Notifications 		///////////////////////////////////

				$data = [
							'sale' => $sale,
							'payout' => $payout
						];


///////////////////////		Mail 	//////////////////////
			$osale = Sale::sale_complete_details($request->all());
			$admin = Admin::first();

			$mail = \Mail::send('Emails.Api.Sale.productPurchase', array('osale'=>$osale, 'sender'=>$admin, 'msg' => 'Item received successfully'),
				function($message) use ($osale)
					{
	    				$message->to($osale->seller->email, $osale->seller->first_name)->subject($osale->product->name.' received successfully');
	        		});
///////////////////////		Mail 	//////////////////////

				return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.Item received successfully'), 'data' => $data),200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////////////		Sale Review 		/////////////////////////////////////////////////

	public static function sale_review(Request $request)
		{
		try{

				$rules = [
							'sale_id' => 'required|exists:sales,id',
							'ratings' => 'required'
						 ];

				$msg =   [
							'sale_id.exists' => 'Sorry, this sale is no longer available'
						 ];

				$validation = Validator::make($request->all(), $rules, $msg);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$sale = Sale::sale_details_buyer_get($request->all());
				if($sale->buyer_id != $user->id)
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale do not belong to you')),200);
				elseif(!in_array($sale->shipment_status, ["BuyerConfirmed","BuyerReceived"]))  //$sale->shipment_status != 'BuyerConfirmed')
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, you have not confirmed receiving this item'), 'sale' => $sale),200);

	////////////////////////////		Previous Review 		//////////////////////////
				$review_check = ProductReview::where('sale_id',$request['sale_id'])->count();
				if($review_check != 0)
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, you have already reviewed this item')),200);
	////////////////////////////		Previous Review 		//////////////////////////
				$request['product_id'] = $sale->product_id;
				$request['owner_id'] = $sale->seller_id;
				$request['receiver_id'] = $sale->seller_id;
				$request['sender_id'] = $user->id;
				$request['type'] = 'ProductReviewed';

				$request['review_id'] = ProductReview::add_new_review($request->all());

	////////////////////////////		Socket event 		//////////////////////////////
				$socket_data = array(
								'receiver_id'=> $request['owner_id'],
								'sender_id'=> $request['sender_id'],
								'product_id'=> $request['product_id'],
								'sale_id'=> $request['sale_id'],
								'chat_id'=> 0,
								'type'=> $request['type']
									);

				$redis = \Illuminate\Support\Facades\Redis::connection();
				$redis->publish('message',json_encode($socket_data));
	////////////////////////////		Socket event 		//////////////////////////////

	//////////////////////		Push Notifications 		///////////////////////////////////

		////////////	To Seller 		///////////////////////////
				$request['message'] = $user->first_name.trans('messages. has reviewed your item');
				$request['is_action'] = '0';
				$request['notification_id'] = UserNotification::insert_new_notifications($request->all());

				$ouser = $sale->seller;
				if($ouser->fcm_id != '' && $ouser->push_notifications == '1')
					{
						$push_data = [
								'type' => $request['type'],
								'message' => $request['message'],
								'sender_id' => $request['sender_id'],
								'product_id' => $request['product_id'],
								'chat_id' => 0,
								'sale_id' => $request['sale_id']
									];

						$request['fcm_id'] = $ouser->fcm_id;
						$request['badge'] = $ouser->not_count+1;

						HomeController::send_single_push($request->all(), $push_data);
					}
		////////////	To Seller 		///////////////////////////

				return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.Review added successfully')),200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

//////////////////////////			Sale Details 		///////////////////////////////////////////////

public static function sale_details(Request $request)
	{
	try{

			$rules = [
						'sale_id' => 'required|exists:sales,id',
						'timezone' => 'required|timezone'
					 ];

			$msg =   [
						'sale_id.exists' => 'Sorry, this sale is no longer available'
					 ];

			$validation = Validator::make($request->all(), $rules, $msg);
			if($validation->fails())
				return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$user = \App('user');

			$sale = Sale::sale_complete_details($request->all());

			if($sale->seller_id != $user->id && $sale->buyer_id != $user->id)
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale do not belong to you')),200);

			$data = [
						'sale' => $sale
					];

			return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.Sale Details'), 'data' => $data ),200);

		}
	catch(\Exception $e)
		{
			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

///////////////////////////		Sale Return 	///////////////////////////////////////////////////////////////////

public static function buyer_return(Request $request)
	{
	try{
			$rules = [
						'sale_id' => 'required|exists:sales,id',
						'message' => 'required'
				 	];

			$msg =   [
						'sale_id.exists' => 'Sorry, this sale is no longer available'
					 ];

			$validation = Validator::make($request->all(), $rules, $msg);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$user = \App('user');

			$sale = Sale::sale_details_buyer_get($request->all());
			if($sale->buyer_id != $user->id)
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale do not belong to you')),200);
			elseif($sale->sale_status == 'BuyerConfirmed')
			 	return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale had already been confirmed')),200);
			elseif($sale->sale_status == 'BuyerReturnRequested')
			 	return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, you have already requested for the return')),200);
			elseif($sale->sale_status != 'AdminPaymentDone')
			 	return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale is currently not available')),200);

			$request['sale_status'] = 'BuyerReturnRequested';
			$request['shipment_status'] = 'BuyerReceived';
			$request['refund_status'] = 'NotRequired';
			$request['admin_payment_status'] = 'Success';
			$request['seller_payment_status'] = 'OnHold';

			Sale::sale_status_update_common($request->all());

			$request['sale_id'] = SaleConflict::insertgetId([
						'created_by' => 'Buyer',
						'sale_id' => $sale->id,
						'seller_id' => $sale->seller_id,
						'buyer_id' => $sale->buyer_id,
						'product_id' => $sale->product_id,
						'title' => 'Item Return Request from Buyer',
						'message' => $request['message'],
						'admin_read' => '0',
						'admin_message' => '',
						'status' => 'Raised',
						'conflict_type' => 'SaleReturn',
						'created_at' => new \DateTime,
						'updated_at' => new \DateTime,
						'admin_replied_at' => null
							]);

			return Response(array('success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Admin, will reach out to you soon')),200);

		}
	catch(\Exception $e)
		{
			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

///////////////////////////				Buyer Product Sent 		///////////////////////////////////////////////

	public static function buyer_shipped(Request $request)
		{
		try{
				$rules = [
							'sale_id' => 'required|exists:sales,id'
						 ];

				$msg =   [
							'sale_id.exists' => 'Sorry, this sale is no longer available'
						 ];

				$validation = Validator::make($request->all(), $rules, $msg);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$sale = Sale::sale_details_buyer_get($request->all());
				if($sale->buyer_id != $user->id)
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale do not belong to you')),200);
				elseif($sale->sale_status != 'BuyerReturnAccepted')
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale return is not confirmed by admin yet')),200);
				elseif($sale->shipment_status == 'BuyerShipped')
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, you have already confirmed shipping this item')),200);

				$request["type"] = $request['shipment_status'] = 'BuyerShipped';
				$request['sale_status'] = 'BuyerReturnAccepted';
				$request['refund_status'] = 'NotRequired';
				$request['admin_payment_status'] = 'Success';
				$request['seller_payment_status'] = 'OnHold';
				$request['product_id'] = $sale->product_id;
				$request['receiver_id'] = $sale->seller_id;
				$request['sender_id'] = $user->id;
				$request['seller_payment_status'] = 'OnHold';
				$request['message'] = $sale->returned_reason;

				Sale::sale_status_update_common($request->all());

	////////////////////////////		Socket event 		//////////////////////////////
				$socket_data = array(
								'receiver_id'=> $request['receiver_id'],
								'sender_id'=> $request['sender_id'],
								'product_id'=> $request['product_id'],
								'sale_id'=> $request['sale_id'],
								'chat_id'=> 0,
								'type'=> $request["type"]
									);

				$redis = \Illuminate\Support\Facades\Redis::connection();
				$redis->publish('message',json_encode($socket_data));
	////////////////////////////		Socket event 		//////////////////////////////

	//////////////////////		Push Notifications 		///////////////////////////////////

		////////////	To Seller 		///////////////////////////
				$request['message'] = $user->first_name.trans('messages. has shipped your item');
				$request['is_action'] = '1';
				UserNotification::insert_new_notifications($request->all());

				$ouser = $sale->seller;
				if($ouser->fcm_id != '' && $ouser->push_notifications == '1')
					{
						$push_data = [
								'type' => $request['type'],
								'message' => $request['message'],
								'sender_id' => $request['sender_id'],
								'product_id' => $request['product_id'],
								'chat_id' => 0,
								'sale_id' => $request['sale_id']
									];

						$request['fcm_id'] = $ouser->fcm_id;
						$request['badge'] = $ouser->not_count+1;

						HomeController::send_single_push($request->all(), $push_data);
					}
		////////////	To Seller 		///////////////////////////

		//////////////////////		Push Notifications 		///////////////////////////////////

				$data = [
							'sale' => $sale
						];

///////////////////////		Mail 	//////////////////////
			$osale = Sale::sale_complete_details($request->all());
			$admin = Admin::first();

			$mail = \Mail::send('Emails.Api.Sale.productPurchase', array('osale'=>$osale, 'sender'=>$admin, 'msg' => 'Item is shipped by buyer for return'),
				function($message) use ($osale)
					{
	    				$message->to($osale->buyer->email, $osale->buyer->first_name)->subject($osale->product->name.' item is shipped by buyer for return');
	        		});
///////////////////////		Mail 	//////////////////////

				return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.Item shipped successfully'), 'data' => $data),200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////////////			Seller Received product 	//////////////////////////////////////

	public static function seller_received(Request $request)
		{
		try{

				$rules = [
							'sale_id' => 'required|exists:sales,id'
						 ];

				$msg =   [
							'sale_id.exists' => 'Sorry, this sale is no longer available'
						 ];

				$validation = Validator::make($request->all(), $rules, $msg);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$user = \App('user');

			$sale = Sale::sale_details_seller_get($request->all());
			if($sale->seller_id != $user->id)
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale do not belong to you')),200);
			elseif($sale->sale_status != 'BuyerReturnAccepted')
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this return is currently not approved by admin')),200);

			$request['sale_status'] = $request['type'] = $request['shipment_status'] = 'SellerConfirmed';
			$request['refund_status'] = $request['admin_payment_status'] = $request['seller_payment_status'] = 'FullRefund';
			$request['product_id'] = $sale->product_id;
			$request['receiver_id'] = $sale->buyer_id;
			$request['sender_id'] = $user->id;
			$request['cancelled_reason'] = $sale->cancelled_reasons;

			\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

			$refund = \Stripe\Refund::create(array(
					  	"charge" => $sale->charge_id,
					  	"metadata" => [
								"sale_id" => $request['sale_id'],
						  		"seller_id" => $request['seller_id'],
						  		"buyer_id" => $request['buyer_id'],
						  		"product_id" => $request['product_id'],
						  		"type" => $request['sale_status']
					  					]
					));

			if($refund['status'] != 'succeeded')
				{
					return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Something went wrong. Please try again')),200);
				}

			$request['refund_id'] = $refund['id'];
			$request['product_status'] = 'List';

			Sale::sale_cancel_order_common($request->all());
			Product::update_product_status($request->all());

////////////////////////////		Socket event 		//////////////////////////////
					$socket_data = array(
							'receiver_id'=> $request['receiver_id'],
							'sender_id'=> $request['sender_id'],
							'product_id'=> $request['product_id'],
							'sale_id'=> $request['sale_id'],
							'chat_id'=> 0,
							'type'=> $request['type'],
								);

					$redis = \Illuminate\Support\Facades\Redis::connection();
					$redis->publish('message',json_encode($socket_data));
////////////////////////////		Socket event 		//////////////////////////////

//////////////////////		Push Notifications 		///////////////////////////////////
					$request['message'] = trans('messages.Item successfully received by supplier');
					$request['is_action'] = '1';
					UserNotification::insert_new_notifications($request->all());

					$ouser = $sale->buyer;
					if($ouser->fcm_id != '' && $ouser->push_notifications == '1')
						{
							$push_data = [
									'type' => $request['type'],
									'message' => $request['message'],
									'sender_id' => $request['sender_id'],
									'product_id' => $request['product_id'],
									'chat_id' => 0,
									'sale_id' => $request['sale_id']
										];

									$request['fcm_id'] = $ouser->fcm_id;
									$request['badge'] = $ouser->not_count+1;

							HomeController::send_single_push($request->all(), $push_data);
						}
//////////////////////		Push Notifications 		///////////////////////////////////

///////////////////////		Mail 	//////////////////////
			$osale = Sale::sale_complete_details($request->all());
			$admin = Admin::first();

			$mail = \Mail::send('Emails.Api.Sale.productPurchase', array('osale'=>$osale, 'sender'=>$admin, 'msg' => 'Item is received by seller'),
				function($message) use ($osale)
					{
	    				$message->to($osale->buyer->email, $osale->buyer->first_name)->subject($osale->product->name.' item is received by seller');
	        		});
///////////////////////		Mail 	//////////////////////

				return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.Item received successfully')),200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////////////			Seller Conflict 		//////////////////////////////////////////

	public static function add_conflict(Request $request)
		{
		try{

				$rules = [
							'sale_id' => 'required|exists:sales,id',
							'title' => 'required',
							'message' => 'required'
						 ];

				$msg =   [
							'sale_id.exists' => 'Sorry, this sale is no longer available'
						 ];

				$validation = Validator::make($request->all(), $rules, $msg);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$sale = Sale::where('id',$request['sale_id'])->first();

				if($sale->seller_id == $user->id)
					{
						// if(!in_array($sale->sale_status, ['InProgress', 'Raised']))
						// 	return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale do not belong to you')),200);
							//return Redirect::back()->withErrors('Sorry, this conflict is already been processed');

						$request['created_by'] = 'Seller';

						if($sale->seller_delivered_at == null)
							{
								Sale::where('id',$request['sale_id'])->update([
										'seller_delivered_at' => new \DateTime,
										'updated_at' => new \DateTime
								]);
							}

					}
				elseif($sale->buyer_id == $user->id)
					{
						$request['created_by'] = 'Buyer';

						if($sale->buyer_confirmed_at == null)
							{
								Sale::where('id',$request['sale_id'])->update([
										'buyer_confirmed_at' => new \DateTime,
										'updated_at' => new \DateTime
								]);
							}

					}
				else
					{
						return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this sale do not belong to you')),200);
					}

				$request['conflict_type'] = $request['created_by'].'Conflict';

///////////////////////////////
	$sale_conflict = SaleConflict::where('created_by',$request['created_by'])->where('sale_id',$request['sale_id'])->where('status', 'Raised')->first();
	if($sale_conflict)
		return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, you already have a conflict in progress for this sale')),200);
///////////////////////////////

				$request['buyer_id'] = $sale->buyer_id;
				$request['seller_id'] = $sale->seller_id;
				$request['buyer_id'] = $sale->buyer_id;
				$request['product_id'] = $sale->product_id;

				$request['conflict_id'] = SaleConflict::add_new_conflict($request->all());

				$conflict = SaleConflict::single_conflict_details($request->all());

				$data = [
							'conflict' => $conflict
						];

				return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.Conflict added successfully'), 'data'=> $data),200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////////////////		My Purchases 	//////////////////////////////////////////////

	public static function my_purchases(Request $request)
		{
		try{
				$rules = [
							'page' => 'required',
							'offset' => 'required',
							'timezone' => 'required|timezone'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$request['sale_status'] = ['BuyerConfirmed','BuyerReturnRejected', 'SellerCancelled', 'BuyerCancelled', 'AdminCancelled', 'SystemCancelled'];
				$completed_sales = Sale::user_get_purchases($request->all());

				$request['sale_status'] = ['AdminPaymentDone', 'SellerShipped', 'BuyerReturnRequested'];
				$inprogress_sales = Sale::user_get_purchases($request->all());

					$data = [
								'completed_sales' => $completed_sales,
								'inprogress_sales' => $inprogress_sales
							];

				return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.My Purchases'), 'data'=> $data),200);


			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////////////////		My Purchases 	//////////////////////////////////////////////

	public static function my_sales(Request $request)
		{
		try{
				$rules = [
							'page' => 'required',
							'offset' => 'required',
							'timezone' => 'required|timezone'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$request['sale_status'] = ['Initiated'];
				$sales = Sale::user_get_sales($request->all());

					$data = [
								'sales' => $sales
							];

				return \Response(array('success'=>1, 'statuscode'=>200,'msg' => trans('messages.My Sales'), 'data'=> $data),200);


			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}



///////////////////////////////

}
