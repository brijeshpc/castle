<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use Illuminate\Support\Facades\Input;
use Validator, DateTime, DB;
use Carbon\Carbon;
//use L5Redis;
// use Event;
use Illuminate\Support\Facades\Redis;

// use App\Events\NewMessage;

use App\Models\User;
use App\Models\Chat;
use App\Models\Product;
use App\Models\UserBlocked;
use App\Models\UserNotification;

use App\Http\Controllers\Api\HomeController;

class ChatController extends Controller
{
///////////////////////				Chats Home    ////////////////////////////////////////

	public static function chats_home(Request $request)
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

				$request['new_page'] = $request['page']*$request['offset'];


				$selling =Chat::user_chats_selling_listings($request->all());
				$buying =Chat::user_chats_buying_listings($request->all());

				$data = [
					'selling' => $selling,
					'buying' => $buying
						];

				return response(['success'=>1,'statuscode'=>200,'msg'=>trans('messages.Chats Home'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////////		Send Message 		//////////////////////////////////////////////////////

	public static function send_message(Request $request)
		{
		try{
				$rules = [
					'receiver_id' => 'required|exists:users,id,blocked,0,deleted,0',
					'product_id' => 'required|exists:products,id,deleted,0',
					'owner_id' => 'required|exists:users,id,blocked,0,deleted,0',
					'message' => 'required',
					'created_at' => 'required'//|date_format:Y-m-d H:i:s'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$block_check = UserBlocked::where('blocker_id',$request['user_id'])->where('blocked_id',$request['receiver_id'])->where('status','1')->first();
				if($block_check)
					return Response(array('success'=>0,'statuscode'=>200,'msg'=>trans('messages.Sorry, this user is blocked by you')),200);

				$user = \App('user');

				//$request['created_at'] = Carbon::createFromTimestamp($request['created_at']);
				//Carbon::CreateFromFormat('Y-m-d H:i:s',$request['created_at'],'UTC')->format('Y-m-d H:i:s');
				//$request["created_at1"] = date('Y-m-d H:i:s.u', $request["created_at"]);
				//dd($request->all());

				// $timestamp = (int)$request["created_at"];
				// $request['timestamp'] = intval($timestamp / 1000); // convert milliseconds to seconds

				$request['chat_id'] = Chat::insert_new_chat($request->all());

////////////////////////////////////////////
				$socket_data = array(
						'receiver_id'=>$request['receiver_id'],
						'sender_id'=>$user->id,
						'product_id'=>$request['product_id'],
						'type'=>'Message',
						'message'=>$request['message'],
						'sale_id'=>0,
						'chat_id' => $request['chat_id'],
						'data'=>array(
								'chat_id'=>$request['chat_id'],
								'message'=>$request['message'],
								'image'=>isset($request['image']) ? $request['image'] : '',
								'image_url'=> !empty($request['image']) ? env('IMAGE_URL').$request['image'] : '',
								'created_at' => $request['created_at'],
								'sender_name' => $user->first_name.' '.$user->last_name,
								'sender_pic' => $user->profile_pic_url,
								'created_at_app' => $request['created_at']
								// 'video'=>$request['video'],
								// 'video_url'=>env('FILE_URL').$request['video'],
								// 'video_thumb'=>i($request['video_thumb']),
								// 'video_thumb_url'=>env('IMAGE_URL').$request['video_thumb'],
							)
					);

				$redis = \Illuminate\Support\Facades\Redis::connection();
				$redis->publish('message',json_encode($socket_data));
////////////////////////////////////////////

				$request['type'] = 'MESSAGE RECEIVED';
				UserNotification::insert_new_notifications($request->all());

				$ouser = User::get_user_for_push($request['receiver_id']);
				if($ouser->fcm_id != '' && $ouser->push_notifications == '1')
					{
								$push_data = [
											'type' => $request['type'],
											'message' => $request['message'],
											'sender_id' => $user->id,
											'product_id' => $request['product_id'],
											'chat_id' => $request['chat_id'],
											'sale_id' => 0,
											'sale_refund_id' => 0,
											'owner_id' => $request['owner_id']
												];

								$request['fcm_id'] = $ouser->fcm_id;
								$request['badge'] = $ouser->not_count;

						HomeController::send_single_push($request->all(), $push_data);
					}

				return response(['success'=>1,'statuscode'=>200,'msg'=>trans('messages.Message Sent Successfully'), "data"=> $request->all()],200);

			}
		catch(\Illuminate\Data\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

//////////////////////		Single User Chats 		/////////////////////////////////////////////////////

	public static function chats_single(Request $request)
		{
		try{
				$rules = [
					'page' => 'required',
					'offset' => 'required',
					'timezone' => 'required|timezone',
					'ouser_id' => 'required|exists:users,id',
					'product_id' => 'required|exists:products,id',
					'owner_id' => 'required|exists:users,id',
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$request['new_page'] = $request['page']*$request['offset'];

				$product = Product::product_detail($request->all());

				$chats =Chat::user_single_chats($request->all());

				$data = [
					'product' => $product,
					'chats' => $chats
						];

				return response(['success'=>1,'statuscode'=>200,'msg'=>trans('messages.Chats Home'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

/////////////////////////		Unread All Chat 	//////////////////////////////////////////////

	public static function unread_chat(Request $request)
		{
		try{

				$rules = [
					'ouser_id' => 'required|exists:users,id',
					'product_id' => 'required|exists:products,id',
					'owner_id' => 'required|exists:users,id',
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				$chats = Chat::where('receiver_id',$user->id)->where('sender_id',$request['ouser_id'])->where('product_id',$request['product_id'])->where('owner_id',$request['owner_id'])->update([
						'is_read' => '1',
						'updated_at' => new \DateTime
				]);

				return response(['success'=>1,'statuscode'=>200,'msg'=>trans('messages.Unread Successfully')],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

/////////////////////////		User Received Chats After Id 		/////////////////////////////////

	public static function chats_single_last(Request $request)
		{
		try{
				$rules = [
					'timezone' => 'required|timezone',
					'ouser_id' => 'required|exists:users,id',
					'product_id' => 'required|exists:products,id',
					'owner_id' => 'required|exists:users,id',
					'chat_id' => 'required'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$request['new_page'] = $request['page']*$request['offset'];

				$chats =Chat::user_single_chats_last_id($request->all());

				$data = [
					'chats' => $chats
						];

				return response(['success'=>1,'statuscode'=>200,'msg'=>trans('messages.Chats Home'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

/////////////////////////


}
