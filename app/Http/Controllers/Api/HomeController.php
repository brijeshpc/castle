<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use Validator, DB, AWS;
use Carbon\Carbon;

use LaravelFCM\Message\OptionsBuilder;
use LaravelFCM\Message\PayloadDataBuilder;
use LaravelFCM\Message\PayloadNotificationBuilder;
use FCM;

use App\Models\Admin;
use App\Models\Category;
use App\Models\Product;
use App\Models\User;
use App\Models\UserSearch;
use App\Models\Sale;
use App\Models\UserNotification;

class HomeController extends Controller
{

///////////////////////////		Api Versionng Function 		//////////////////////////////////////////////////

	public static function versioning_api(Request $request)
		{
		try{
				$rules = [
							'version'=> 'required'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$versioning = HomeController::check_versioning($request->all());

				return Response(array('success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Versioning complete'), 'versioning'=> $versioning),200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

/////////////////////////////			Api Versioning 	/////////////////////////////////////////////////////

	public static function check_versioning($data)
		{

			$admin = Admin::select('*')->first();

			if((!empty($admin->ios_force_version))  && ($data['version'] < $admin->ios_force_version))
				{
					return 5;
				}
			elseif((!empty($admin->ios_normal_version))  && ($data['version'] < $admin->ios_normal_version))
				{
					return 4;
				}
			else
				{
					return 1;
				}

		}

/////////////////////			Filter Products 		/////////////////////////////////////////////////////

public static function filter_products(Request $request)
	{
	try{

			$rules = [
						'category_sub_sub_id'=> 'sometimes|exists:category_sub_subs,id',
						'page'=> 'required',
						'offset'=> 'required'
					];

			$validation = Validator::make($request->all(),$rules);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$user = \App('user');
////////////////////////////		Categories 	/////////////////////////////////////////////////
			if(!isset($request['categories']))
				$request['categories'] = [];
			else
				$request['categories'] = json_decode($request['categories'],true);
////////////////////////////		Categories 	/////////////////////////////////////////////////

////////////////////////////		Shipping Filter 	/////////////////////////////////////////
			// if(!isset($request['shipping_paid_by']) || $request['shipping_paid_by'] == 0)
			// 	$request['shipping_paid_by'] = ['Seller', 'Buyer'];
			// elseif($request['shipping_paid_by'] == 1)
			// 	$request['shipping_paid_by'] = ['Seller'];
			// else
			// 	$request['shipping_paid_by'] = ['Buyer'];
////////////////////////////		Shipping Filter 	/////////////////////////////////////////

////////////////////////////		Product Condition 	/////////////////////////////////////////
			if(!isset($request['pcondition']))
				$request['pcondition'] = [];
			else
				$request['pcondition'] = json_decode($request['pcondition'],true);
////////////////////////////		Product Condition 	/////////////////////////////////////////

////////////////////////////		Filters 	/////////////////////////////////////////////////
			if(!isset($request['filters']))
				$request['filters'] = [];
			else
				$request['filters'] = json_decode($request['filters'],true);

			$request['filters'] = HomeController::filter_where_creator($request->all());
////////////////////////////		Filters 	/////////////////////////////////////////////////


			if(!isset($request['min_price']))
				$request['min_price'] = 0;

			if(!isset($request['max_price']))
				$request['max_price'] = 99999999999;
// -Best match
// -Newest
// -Lowest Price
// -Highest Price
// -Most views
////////////////////////////////////			Sorting 			/////////////////////////////
			if(!isset($request['sort_by']) || $request['sort_by'] == 0 || $request['sort_by'] == 1)
				{//////////			Best Match 		///////////////
					$request['sort_column'] = 'id';
					$request['sort_order'] = 'DESC';
				}//////////			Best Match 		///////////////
			elseif($request['sort_by'] == 2)
				{//////////			Lowest Price First 		///////
					$request['sort_column'] = 'base_price';
					$request['sort_order'] = 'ASC';
				}//////////			Lowest Price First 		///////
			elseif($request['sort_by'] == 3)
				{//////////			Highest Price First 		///
					$request['sort_column'] = 'base_price';
					$request['sort_order'] = 'DESC';
				}//////////			Highest Price First 		///
			else
				{//////////			Most Views 				///////
					$request['sort_column'] = 'product_views';
					$request['sort_order'] = 'DESC';
				}//////////			Most Views 				///////
////////////////////////////////////			Sorting 			/////////////////////////////

			$products = Product::filter_product_listings($request->all());

			if(isset($request['search']) && $request['search'] != '')
				UserSearch::insert_new_search($request->all());

			$data = [
				'products'=> $products
					];

			return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Filtered items'), 'data'=>$data,'request'=>$request->all()],200);

		}
	catch(\Exception $e)
		{
			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

/////////////////////			Filter Creator 		/////////////////////////////////////////
public static function filter_where_creator($data)
	{
		$where = array();

		foreach($data['filters'] as $filter)
			{
				if( isset($filter['type']) && isset($filter['category_filter_id']) )
					{

					if($filter['type'] == 'List' && isset($filter['ids']))
						{//////////	List Type 	/////////////////

						$filter['ids'] = json_decode($filter['ids'], true);
							if(!empty($filter['ids']))
								{

									$where[] = '( (SELECT category_filter_values_id FROM product_filter_values as val WHERE val.product_id = products.id AND val.deleted="0" AND val.category_filter_id = "'.$filter['category_filter_id'].'" LIMIT 0,1) IN ("'.implode(',',$filter['ids']).'")  )';

								}

						}//////////	List Type 	/////////////////
					elseif( $filter['type'] == 'MinMax' && isset($filter['min_value']) && $filter['min_value'] != '' && isset($filter['max_value']) && $filter['max_value'] != '' )
						{//////////	MinMax 	/////////////////////

							$where[] = '( (SELECT value FROM product_filter_values as val WHERE val.product_id = products.id AND val.deleted="0" AND val.category_filter_id = "'.$filter['category_filter_id'].'" LIMIT 0,1) BETWEEN "'.($filter['min_value'] - 1).'" AND "'.($filter['max_value'] + 1).'" )';

						}//////////	MinMax 	/////////////////////
					elseif( $filter['type'] == "Value" && $filter['value'] != '' )
						{

	$where[] = '( (SELECT value FROM product_filter_values as val WHERE val.product_id = products.id AND val.deleted="0" AND val.category_filter_id = "'.$filter['category_filter_id'].'" LIMIT 0,1) LIKE "%'.$filter['value'].'%" )';

						}

					}
			}

		if(empty($where))
			return 'products.name != ""';
		else
			return '( '.implode(' OR ', $where).' )';

	}

/////////////////////			Home Page Products Listings 		/////////////////////////////////////////

public static function home_products(Request $request)
	{
	try{
			$user = \App('user');

			$rules = [
						'page'=> 'required',
						'offset'=> 'required'
					 ];

			$validation = Validator::make($request->all(),$rules);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$request['categories'] = [];
			$request['pcondition'] = [];

			$request['min_price'] = 0;
			$request['max_price'] = 99999999999;
			//$request['shipping_paid_by'] = ['Seller', 'Buyer'];
////////////////////////////////////			Sorting 			////////////////////////////////////
			$request['sort_column'] = 'id';
			$request['sort_order'] = 'DESC';
////////////////////////////////////			Sorting 			////////////////////////////////////

			$products = Product::home_page_product_listings($request->all());

			$data = [
						'user' => $user,
						'products'=> $products
					];

			return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Home items'), 'data'=>$data],200);

		}
	catch(\Exception $e)
		{
			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

/////////////////////			Send Push 		///////////////////////////////////////////////////////////

	public static function send_single_push($alldata, $push_data)
		{

			$optionBuilder = new OptionsBuilder();
			$optionBuilder->setTimeToLive(60*20);

			$notificationBuilder = new PayloadNotificationBuilder(env('APP_NAME'));
			$notificationBuilder->setBody($push_data['message'])
							    ->setSound('default')
							    ->setBadge($alldata['badge']);

			$dataBuilder = new PayloadDataBuilder();
			$dataBuilder->addData($push_data);

			$option = $optionBuilder->build();
			$notification = $notificationBuilder->build();
			$data = $dataBuilder->build();

			$downstreamResponse = FCM::sendTo($alldata['fcm_id'], $option, $notification, $data);

			// $downstreamResponse->numberSuccess();
			// $downstreamResponse->numberFailure();
			// $downstreamResponse->numberModification();

			// //return Array - you must remove all this tokens in your database
			// $downstreamResponse->tokensToDelete();

			// //return Array (key : oldToken, value : new token - you must change the token in your database )
			// $downstreamResponse->tokensToModify();

			// //return Array - you should try to resend the message to the tokens in the array
			// $downstreamResponse->tokensToRetry();

		}

///////////////////
//////////////////////		Sales Cron 		////////////////////////////
///////////////////

	public static function new_sales_cron(Request $request)
		{
		try{

				$request['now'] = Carbon::now();
				$request['startOfWeek'] = $request['now']->startOfWeek()->format('Y-m-d H:i:s');
				$request['endOfWeek'] = $request['now']->endOfWeek()->format('Y-m-d H:i:s');
				
				$sales = Sale::new_cron_get_sales($request->all());

				$released_payments = [];
				$canceled_sales = [];


				return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Home items'), 'sales'=>$sales],200);

			}
		catch(\Exception $e)
			{
				if(isset($request['sale_id']))
					Sale::cron_update_sale_time_status($request->all());

				$data = [
							'stripe_request'=> isset($stripe_request) ? $stripe_request : new \stdClass(),
							'sale'=> isset($sale) ? $sale : new \stdClass() 
						];

				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage(), 'data'=> $data),500);
			}
		}

///////////////////////////////////////////////////	
///////////////////				Sales Cron
///////////////////////////////////////////////////

	public static function sales_cron(Request $request)
	{
	try{
			$sales = Sale::cron_get_sales($request->all());

			$released_payments = [];
			$canceled_sales = [];
			
			\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

			foreach($sales as $sale)
				{////////////		For Each Sales 	////////////////////////////
//////////////////////////////////////////////////////

					if(COUNT($sale->sale_conflict) > 0)
						{
							$sale->is_conflicted = '1';
							continue;
						}

					$sale->is_conflicted = '0';
					$request['sale_id'] = $sale->id;
					$request['seller_id'] = $sale->seller_id;
					$request['buyer_id'] = $sale->buyer_id;
					$request['product_id'] = $sale->product_id;
					$request['is_action'] = '1';

					if($sale->sale_status == 'AdminPaymentDone' && $sale->shipment_status != 'SellerShipped')
						{////////////////////////		Cancel Sale 		/////////////////
////////////////////////////////////////////							
							$request['type'] = $request['sale_status'] = $request['shipment_status'] = 'SystemCancelled';
							$request['refund_status'] = $request['admin_payment_status'] = $request['seller_payment_status'] = 'FullRefund';
							$request['cancelled_reason'] = 'SellerNoResponse';

/////////////////////////////	Stripe 	///////////////////////////////////////////
							$refund = \Stripe\Refund::create(array(
								  	"charge"=> $sale->charge_id,
								  	"refund_application_fee"=> true,
								  	"reverse_transfer" => true,
								  	"metadata"=> [
											"sale_id"=> $request['sale_id'],
									  		"seller_id"=> $request['seller_id'],
									  		"buyer_id"=> $request['buyer_id'],
									  		"product_id"=> $request['product_id'],
									  		"type"=> $request['sale_status'],
									  		"reason"=> $request['cancelled_reason']
								  				]
								));

							$request['refund_id'] = $refund['id'];
/////////////////////////////	Stripe 	//////////////////////////////////////////
							$request['product_status'] = 'List';

							Sale::cron_cancel_sale_status($request->all());
							Product::update_product_status($request->all());

/////////////////////////////////////////////////
///////////////		Seller Notification 		////////////////////////////
							$request['receiver_id'] = $request['seller_id'];
							$request['sender_id'] = $request['user_id'] = $request['buyer_id'];
////////////////////////////		Socket event 		///////////////////////
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
							$request['message'] = trans('messages.Your sale was cancelled by system');
							UserNotification::insert_new_notifications($request->all());

							$seller = $sale->seller;
							if($seller->fcm_id != '' && $seller->push_notifications == '1')
								{
									$push_data = [
											'type'=> $request['type'],
											'message'=> $request['message'],
											'sender_id'=> $request['sender_id'],
											'product_id'=> $request['product_id'],
											'chat_id'=> 0,
											'sale_id'=> $request['sale_id']
												];

											$request['fcm_id'] = $seller->fcm_id;
											$request['badge'] = $seller->not_count+1;

									HomeController::send_single_push($request->all(), $push_data);
								}
//////////////////////		Push Notifications 		///////////////////////////////////

///////////////		Seller Notification 		////////////////////////////
///////////////////////////////////////

///////////////////////////////////////
///////////////		Buyer Notification 		////////////////////////////
			$request['receiver_id'] = $request['buyer_id'];
			$request['sender_id'] = $request['user_id'] = $request['seller_id'];
////////////////////////////		Socket event 		///////////////////////
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
					$request['message'] = trans('messages.Your sale was cancelled by system');
					UserNotification::insert_new_notifications($request->all());

					$buyer = $sale->buyer;
					if($buyer->fcm_id != '' && $buyer->push_notifications == '1')
						{
							$push_data = [
									'type'=> $request['type'],
									'message'=> $request['message'],
									'sender_id'=> $request['sender_id'],
									'product_id'=> $request['product_id'],
									'chat_id'=> 0,
									'sale_id'=> $request['sale_id']
										];

									$request['fcm_id'] = $buyer->fcm_id;
									$request['badge'] = $buyer->not_count+1;

							HomeController::send_single_push($request->all(), $push_data);
						}
//////////////////////		Push Notifications 		///////////////////////////////////

///////////////		Buyer Notification 		////////////////////////////
/////////////////////////////////////////////

							array_push($canceled_sales,$sale);

/////////////////////////////////////////////
						}////////////////////////		Cancel Sale 		/////////////////
					elseif($sale->sale_status == 'AdminPaymentDone' && $sale->shipment_status == 'SellerShipped')
						{////////////////////////		Release Funds 		/////////////////

							$request['refund_status'] = 'NotRequired';
							$request['admin_payment_status'] = $request['seller_payment_status'] = 'Success';
							$request['sale_status'] = $request['type'] = 'SystemPaymentReleased';
							$request['conflict_status'] = 'Resolved';

/////////////////////		Stripe 	///////////////////////////////////
							$payout = \Stripe\Payout::create(array(
								    "amount" => $sale->final_seller_cut*100,
								    "currency" => "usd",
									"description" => env('APP_NAME').' Payment for '.$sale->product->name,
									"statement_descriptor" => env('APP_NAME').' Payment',
								    //"source_type" => "bank_account",
								    "method" => "standard",
									"metadata" => [
													  	"sale_id"=> $request['sale_id'],
													  	"seller_id"=> $request['seller_id'],
													  	"buyer_id"=> $request['buyer_id'],
													  	"product_id"=> $request['product_id'],
													  	'type'=> $request['type'],
												]	
								), array("stripe_account" => $sale->seller->stripe_connect_id));

								$request['seller_transaction_id'] = $payout['id'];
/////////////////////		Stripe 	///////////////////////////////////

							Sale::admin_release_sale_payment($request->all());

							$request['product_status'] = 'Sold';
							Product::update_product_status($request->all());

/////////////////////////////////////////////////
///////////////		Seller Notification 		////////////////////////////
					$request['receiver_id'] = $request['seller_id'];
					$request['sender_id'] = $request['user_id'] = $request['buyer_id'];
////////////////////////////		Socket event 		///////////////////////
					$socket_data = array(
							'receiver_id'=> $request['receiver_id'],
							'sender_id'=> $request['sender_id'],
							'product_id'=> $request['product_id'],
							'sale_id'=> $request['sale_id'],
							'chat_id' => 0,
							'type'=> $request['type']
								);

					$redis = \Illuminate\Support\Facades\Redis::connection();
					$redis->publish('message',json_encode($socket_data));
////////////////////////////		Socket event 		//////////////////////////////

//////////////////////		Push Notifications 		///////////////////////////////////
					$request['message'] = trans('messages.Your sale payment was released');
					$request['is_action'] = '1';

					UserNotification::insert_new_notifications($request->all());

					$seller = $sale->seller;
					if($seller->fcm_id != '' && $seller->push_notifications == '1')
						{
							$push_data = [
									'type'=> $request['type'],
									'message'=> $request['message'],
									'sender_id'=> $request['sender_id'],
									'product_id'=> $request['product_id'],
									'chat_id'=> 0,
									'sale_id'=> $request['sale_id']
										];

							$request['fcm_id'] = $seller->fcm_id;
							$request['badge'] = $seller->not_count+1;

							HomeController::send_single_push($request->all(), $push_data);
						}
//////////////////////		Push Notifications 		///////////////////////////////////

///////////////		Seller Notification 		////////////////////////////
///////////////////////////////////////

///////////////////////////////////////
///////////////		Buyer Notification 		////////////////////////////
					$request['receiver_id'] = $request['buyer_id'];
					$request['sender_id'] = $request['user_id'] = $request['seller_id'];
////////////////////////////		Socket event 		///////////////////////
					$socket_data = array(
							'receiver_id'=> $request['receiver_id'],
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
					$request['message'] = trans('messages.Your sale payment was released');
					$request['is_action'] = '1';
					UserNotification::insert_new_notifications($request->all());

			////////////	To Buyer 		///////////////////////////
					$request['message'] = trans('messages.Please review your purchased item');
					$request['type'] = 'ReviewSale';
					$request['is_action'] = '1';
					UserNotification::insert_new_notifications($request->all());
			////////////	To Buyer 		///////////////////////////


					$buyer = $sale->buyer;
					if($buyer->fcm_id != '' && $buyer->push_notifications == '1')
						{
							$push_data = [
									'type' => $request['type'],
									'message' => $request['message'],
									'sender_id' => $request['sender_id'],
									'product_id' => $request['product_id'],
									'chat_id' => 0,
									'sale_id' => $request['sale_id']
										];

									$request['fcm_id'] = $buyer->fcm_id;
									$request['badge'] = $buyer->not_count+2;

							HomeController::send_single_push($request->all(), $push_data);
						}

//////////////////////		Push Notifications 		///////////////////////////////////

///////////////		Buyer Notification 		////////////////////////////
/////////////////////////////////////////////

							array_push($released_payments,$sale);

						}////////////////////////		Release Funds 		/////////////////
						
						

				}////////////		For Each Sales 	////////////////////////////
/////////////////////////////////////////////////////
				

			$data = [
						'request'=> $request->all(),
						'sales'=> $sales,
						'released_payments'=> $released_payments,
						'canceled_sales'=> $canceled_sales
					];


			return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Home items'), 'data'=>$data],200);

		}
	catch(\Exception $e)
		{
			if(isset($request['sale_id']))
				Sale::cron_update_sale_time_status($request->all());

			$data = [
						'stripe_request'=> isset($stripe_request) ? $stripe_request : new \stdClass(),
						'sale'=> isset($sale) ? $sale : new \stdClass() 
					];

			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage(), 'data'=> $data),500);
		}
	}

///////////////////

}
