<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use Validator, DateTime, DB, Mail;
use Carbon\Carbon;

// use Closure;
// use Monolog\Logger;
// use Monolog\Handler\StreamHandler;
// use Illuminate\Support\Facades\Log;

use App\Models\Admin;
use App\Models\User;
use App\Models\Category;
use App\Models\Coupon;
use App\Models\Banner;
use App\Models\Product;
use App\Models\Sale;
use App\Models\Page;
use App\Models\StripeWebhook;
use App\Models\UserNotification;

class OtherController extends Controller
{

////////////////

	public static function test_api(Request $request)
		{
			$data = [
				'sale_id' => 1,
				'timezone' => 'Asia/Kolkata',
				'timezonez' => '+05:30'
			];

			UserNotification::insert([
				'receiver_id' => 1,
				'sender_id' => 33,
				'product_id' => 18,
				'chat_id' => 0,
				'sale_id' => 19,
				'text' => 'Test Observors',
				'type' => 'No Type',
				'is_action' => '1',
				'is_read' => '0',
				'created_at' => new \DateTime,
				'updated_at' => new \DateTime
			]);

			dd('1');

			// $sale = Sale::sale_complete_details($data);
			// $admin = Admin::first();
			// $user = [];

			// $mail = \Mail::send('Emails.Api.Sale.productPurchase', array('sale'=>$sale, 'sender'=>$admin, 'msg' => 'Item is purchased'),
			// 	function($message) use ($user)
			// 		{
	  //   				$message->to('rohitdalal@code-brew.com', 'Rohit Dalal')->subject('Item is purchased');
	  //       		});

			// dd($mail);

		}

/////////////////////////////////			Other Data    //////////////////////////////////////////////////

	public static function other_data(Request $request)
		{
		try{

				$normal_categories = Category::user_get_categories($request->all());
				$banners = Banner::user_get_banners($request->all());
				$admin = Admin::select('id','admin_fee')->first();
				$pages = Page::get_pages_all($request->all());

				$data = [
					'normal_categories' => $normal_categories,
					'banners' => $banners,
					'admin' => $admin,
					'pages' => $pages
						];

				return response(['success'=>1,'statuscode'=>200,'msg'=>trans('messages.Other Data'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

/////////////////////////////////////////		Get Coupons 		///////////////////////////////////////

	public static function get_coupons(Request $request)
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

				$coupons = Coupon::get_user_coupons($request->all());

				$data = [
					'coupons' => $coupons
						];

				return response(['success'=>1,'statuscode'=>200,'msg'=>trans('messages.User Coupons'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

/////////////////////////////		Check Coupon 		///////////////////////////////////////////////

	public static function check_coupons(Request $request)
	{
	try{

			$rules = [
						'product_id' => 'required|exists:products,id,deleted,0,blocked,0,product_status,List',
						'coupon_code' => 'required|exists:coupons,title,deleted,0,blocked,0',
						//'timezone' => 'required|timezone'
					 ];

			$validation = Validator::make($request->all(),$rules);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$user = \App('user');

//		['Initiated','SellerShipping','BuyerConfirmed', 'SellerConfirmed']
//		['SellerCancelled','BuyerCancelled','AdminCancelled','SystemCancelled']

			$coupon = Coupon::where('title',$request['coupon_code'])->first();
			$coupon->coupon_expiry = Carbon::createFromFormat('Y-m-d H:i:s',$coupon->expires_at,'UTC');
			if($coupon->coupon_expiry->isPast())
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this coupon has expired')),200);

			$coupon_check = Sale::where('buyer_id',$user->id)->whereNotIn('sale_status',['SellerCancelled','BuyerCancelled','AdminCancelled','SystemCancelled'])->where('coupon_id',$coupon->id)->count();
						if($coupon_check)
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this coupon is already been used by you')),200);

			$admin = Admin::first();
			$product = Product::where('id',$request['product_id'])->first();


			$request['product_price'] = $product->base_price;
			$request['shipping_price'] =  ($product->shipping_paid_by == 'Buyer') ? $product->shipping_price : 0;
			$request['sub_total'] = $request['product_price'] + $request['shipping_price'];
			$request['admin_fee'] = (($request['sub_total']/100)*$admin->admin_fee);
			$request['total'] = $request['sub_total'] + $request['admin_fee'];

			if($request['total'] < $coupon->minimum_amount_required)
				return Response(array('success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Sorry, this coupon can be applied on purchase of minimum $').$coupon->minimum_amount_required),200);


			$data = [
				'coupon' => $coupon,
				'data' => $request->all()
					];


			return Response(array('success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Coupon Validated Successfully'), 'data' => $data),200);

		}
	catch(\Exception $e)
		{
			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

/////////////////////	Get Page View 		//////////////////////////////////////////////////////////////////////

	public static function get_page(Request $request)
		{
		try{

				$rules = array(
							'page_id'=>'required|exists:pages,id'
							);

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>'0','statuscode'=>'400','msg'=>$validation->getMessageBag()->first()),200);

				$page = Page::where('id',$request['page_id'])->select('id','type','name','context')->first();

				return \View::make('Api.Other.page')->with('page',$page);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>'0','statuscode'=>'500','msg'=>$e->getMessage()),500);
			}
		}


/////////////////////////////		Stripe Webhook 		///////////////////////////////////////////////

	public static function stripe_webhook(Request $request)
		{
//			$data = $request->all();

			\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

			// Retrieve the request's body and parse it as JSON
			$input = @file_get_contents("php://input");
			$request['event_json'] = json_decode($input);

			// Do something with $event_json

			//http_response_code(200); // PHP 5.4 or greater


	        // $view_log = new Logger('API Logs');
	        // $view_log->pushHandler(new StreamHandler('Logs/StripeApi.logs', Logger::INFO));        

	        // $view_log->addInfo(json_encode(['Remote_address'=>$_SERVER['REMOTE_ADDR'],'Request_api'=>$_SERVER['REQUEST_URI'],'Data' => $data]));

			// Retrieve the request's body and parse it as JSON
			// $input = @file_get_contents("php://input");
			// $event_json = json_decode($input);

			$request['weebhook_id'] = StripeWebhook::insert_new_webhook($request->all());

			return Response(array('success'=>1, 'statuscode'=>200, 'data' => $request->all()),200);

	        //return $request->all();


		}

/////////////////////////////

}
