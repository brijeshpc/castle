<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use Validator, DB;
use Carbon\Carbon;

use App\Models\User;
use App\Models\UserAddress;
use App\Models\UserFollowing;
use App\Models\UserBlocked;
use App\Models\UserNotification;
use App\Models\UserSearch;
use App\Models\UserContactUs;
use App\Models\Product;

use App\Http\Controllers\Api\HomeController;

class UserOtherController extends Controller
{
//////////////////////////////////		Add Address    //////////////////////////////////

	public static function add_address(Request $request)
		{
		try{

				$rules = [
							'first_name' => 'required',
							'last_name' => 'required',
							'line1' => 'required',
							'zipcode' => 'required',
							'city' => 'required',
							'state' => 'required',
							'country' => 'required',
							'latitude' => 'required',
							'longitude' => 'required'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				UserAddress::where('user_id',$request['user_id'])->where('deleted','0')->update([
						'is_default' => '0',
						'updated_at' => new \DateTime
					]);

				UserAddress::add_new_address($request->all());

				$addresses = UserAddress::get_user_addresses($request->all());

				$data = [
							'addresses' => $addresses
						];

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Address Added Successfully'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

//////////////////////////////////		All Address    //////////////////////////////////

	public static function list_address(Request $request)
		{
		try{

				$addresses = UserAddress::get_user_addresses($request->all());

				$data = [
							'addresses' => $addresses
						];

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.User Address Listings'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

//////////////////////////////			Delete Address 		////////////////////////////////////////

	public static function delete_address(Request $request)
		{
		try{
				$rules = [
							'id' => 'required|exists:user_address,id,deleted,0,user_id,'.$request['user_id']
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$address =	UserAddress::get_single_address($request->all());

				UserAddress::delete_user_address($request->all());

				if($address->is_default == '1')
					{
						UserAddress::where('user_id',$request['user_id'])->where('deleted','0')->orderby('updated_at','DESC')->limit(1)->update([
							'is_default' => '1',
							'updated_at' => new \DateTime
								]);
					}

				$addresses = UserAddress::get_user_addresses($request->all());

				$data = [
							'addresses' => $addresses
						];

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Address Deleted Successfully'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

//////////////////////////////////		Add Address    //////////////////////////////////

	public static function update_address(Request $request)
		{
		try{

				$rules = [
							'id' => 'required|exists:user_address,id,deleted,0,user_id,'.$request['user_id'],
							'first_name' => 'required',
							'last_name' => 'required',
							'line1' => 'required',
							'zipcode' => 'required',
							'city' => 'required',
							'state' => 'required',
							'country' => 'required',
							'latitude' => 'required',
							'longitude' => 'required'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$address =	UserAddress::get_single_address($request->all());

				UserAddress::update_user_address($request->all(), $address);
				$addresses = UserAddress::get_user_addresses($request->all());

				$data = [
							'addresses' => $addresses
						];

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Address Updated Successfully'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

//////////////////////////////////		Default Address    //////////////////////////////////

	public static function default_address(Request $request)
		{
		try{

				$rules = [
							'id' => 'required|exists:user_address,id,deleted,0,user_id,'.$request['user_id']
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				UserAddress::where('user_id',$request['user_id'])->where('id','!=',$request['id'])->update([
						'is_default' => '0',
						'updated_at' => new \DateTime
					]);

				UserAddress::where('id','=',$request['id'])->update([
						'is_default' => '1',
						'updated_at' => new \DateTime
					]);

				$addresses = UserAddress::get_user_addresses($request->all());

				$data = [
							'addresses' => $addresses
						];

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Default Address Updated Successfully'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}


////////////////////		Follow Unfollow Other User 		///////////////////////////////////////

	public static function follow_user(Request $request)
		{
		try{

				$rules = [
							'status' => 'required|in:0,1',
							'following_id' => 'required|exists:users,id,deleted,0,blocked,0'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$follow = UserFollowing::where('follower_id',$request['user_id'])->where('following_id',$request['following_id'])->first();
							if($request['status'] == 1)
								{

				$block_check = UserBlocked::where('blocker_id',$request['following_id'])->where('blocked_id',$request['user_id'])->where('status','1')->first();
				if($block_check && !$follow)
					return Response(array('success'=>0,'statuscode'=>200,'msg'=>trans('messages.Sorry, this user is blocked by you')),200);

						if(!$follow)
							{
								UserFollowing::insert_new_following($request->all());

								$request['receiver_id'] = $request['following_id'];
								$request['message'] = $user->first_name.trans('messages. has started following you');
								$request['type'] = 'UserFollowing';
								UserNotification::insert_new_notifications($request->all());

								$ouser = User::get_user_for_push($request['following_id']);
								if($ouser->fcm_id != '' && $ouser->push_notifications == '1')
									{
												$push_data = [
															'type' => $request['type'],
															'message' => $request['message'],
															'sender_id' => $user->id,
															'product_id' => 0,
															'chat_id' => 0,
															'sale_id' => 0
																];

												$request['fcm_id'] = $ouser->fcm_id;
												$request['badge'] = $ouser->not_count;

										HomeController::send_single_push($request->all(), $push_data);
									}

							}
						else
							{

								if($request['status'] == 1 && $follow->status == '1')
									return Response(array('success'=>0,'statuscode'=>200,'msg'=>trans('messages.Sorry, this user is already being followed by you')),200);
								elseif($request['status'] == 0 && $follow->status == '0')
									return Response(array('success'=>0,'statuscode'=>200,'msg'=>trans('messages.Sorry, this user is not followed by you')),200);

								$request['id'] = $follow->id;
								UserFollowing::update_following($request->all());

							}

						$msg = trans('messages.User followed successfully');
					}
				else
					{

						if(!$follow)
							return Response(array('success'=>0,'statuscode'=>200,'msg'=>trans('messages.Sorry, this user is not follwed by you')),200);

						$request['id'] = $follow->id;
						UserFollowing::update_following($request->all());

						$msg = trans('messages.User unfollowed successfully');
					}

				return Response(array('success'=>1,'statuscode'=>200,'msg'=>$msg),200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

////////////////////		Follow List 		///////////////////////////////////////////////////

	public static function following_list(Request $request)
		{
		try{

				$rules = [
							//'type' => 'required|in:Followers,Following',
							'page' => 'required',
							'offset' => 'required'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$following_me = User::following_me_users($request->all());
				$followed_by_me = User::followed_users_by_me($request->all());

				$data = [
							'following_me' => $following_me,
							'followed_by_me' => $followed_by_me
						];

				return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.User listings'), 'data'=>$data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////			User Recent Searches 		///////////////////////////////////////////////

	public static function recent_searches(Request $request)
		{
		try{

				$rules = [	//'type' => 'required|in:Followers,Following',
								'page' => 'required',
								'offset' => 'required'
						 ];

					$validation = Validator::make($request->all(),$rules);
						if($validation->fails())
							return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

					$user = \App('user');

					$searches = UserSearch::get_user_searches($request->all());
					$trending_searches = UserSearch::get_trending_searches($request->all());

		$data = [
			'searches' => $searches,
			'trending_searches' => $trending_searches
				];

				return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Recent Searches'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

/////////////////////////////		Top Sellers 		/////////////////////////////////////////////////

	public static function old_top_sellers(Request $request)
		{
		try{

				$rules = [
							'page' => 'required',
							'offset' => 'required'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$top_sellers = User::get_top_sellers($request->all());

				$data = [
					'top_sellers' => $top_sellers
						];

				return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Top Sellers'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

//////////////////////////////		Contact Us 	///////////////////////////////////////////////////////

	public static function user_contact_us(Request $request)
		{
		try{

				$rules = [
							'title' => 'required',
							'description' => 'required'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				UserContactUs::add_new_insert_contactus($request->all());

				return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Admin will contach you soon')],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

//////////////////////////////			Get Other User Products 		///////////////////////////////

	public static function get_ouser_products(Request $request)
		{
		try{
				$rules = [
							'ouser_id' => 'required|exists:users,id,deleted,0,blocked,0',
							'page' => 'required',
							'offset' => 'required'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$products = Product::get_single_user_products($request->all());

				$data = [
					'products' => $products
				];

				return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.User Items'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

/////////////////////////////			User notification 	/////////////////////////////////////////////////////////

public static function notifications(Request $request)
	{
	try{
				$rules = [
							'page' => 'required',
							'offset' => 'required'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$normal_notification_count = UserNotification::get_user_normal_notification_count($request->all());
				$action_notification_count = UserNotification::get_user_action_notification_count($request->all());
				$normal_notifications = UserNotification::get_user_normal_notification($request->all());
				$action_notifications = UserNotification::get_user_action_notification($request->all());

			$data = [
						'normal_notification_count' => $normal_notification_count,
						'action_notification_count' => $action_notification_count,
						'normal_notifications' => $normal_notifications,
						'action_notifications' => $action_notifications
					];

			return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.User Notifications'), 'data' => $data],200);

		}
	catch(\Exception $e)
		{
			return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

////////////////////////////		Unread Notification 		///////////////////////////////////////////////////

public static function unread_notification(Request $request)
	{
	try{

				$rules = [
							'type' => 'required|in:Normal,Action'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);


			UserNotification::unread_user_notifications($request->all());

			return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Notification updated successfully')],200);

		}
	catch(\Exception $e)
		{
			return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

////////////////////////////		Top Sellers 		///////////////////////////////////////////////////

public static function top_sellers(Request $request)
	{
	try{

			$rules = [
						'page' => 'required',
						'offset' => 'required'
					];

			$validation = Validator::make($request->all(),$rules);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);


			$top_sellers = User::top_sellers($request->all());

			$data = [
				'top_sellers' => $top_sellers
			];

			return response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Top Sellers'), 'data'=>$data],200);

		}
	catch(\Exception $e)
		{
			return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}
////////////////////////////



}
