<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use Validator, DateTime, DB;
use Carbon\Carbon;

use App\Models\User;
use App\Models\UserAccounts;
use App\Models\UserCard;

class CardsController extends Controller
{
///////////////////////////////////////			Add Card Api    //////////////////////////////////

	public static function add_card(Request $request)
		{
		try{

				$user = \App('user');

				$rules = [
							'number'=>'required',
							'exp_month' => 'required',
							'exp_year' => 'required',
							'cvc' => 'required'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

				$token = \Stripe\Token::create(array(
							  "card" => array(
							    "number" => $request['number'],
							    "exp_month" => $request['exp_month'],
							    "exp_year" => $request['exp_year'],
							    "cvc" => $request['cvc'],
							    "name" => $user->username
							  )
							));

				$request['fingerprint'] = $token['card']->fingerprint;

///////////////////////////		FingerPrint Check 		//////////////////////////////////////////////////////////

	$user_cards = UserCard::where('deleted','0')->where('fingerprint',$request['fingerprint'])->where('user_id',$request['user_id'])->count();
	if($user_cards)
		return response(['success'=>0, 'statuscode'=>200, 'msg'=>'Sorry, this card is already added by you'],200);

///////////////////////////		FingerPrint Check 		//////////////////////////////////////////////////////////

				UserCard::where('user_id',$request['user_id'])->update([
						'is_default' => '0',
						'updated_at' => new \DateTime
					]);

				$request['card_token'] = $token['id'];
				$request['card_id'] = $token['card']->id;
				$request['last4'] = $token['card']->last4;
				$request['brand'] = $token['card']->brand;

				$customer = \Stripe\Customer::retrieve($user->stripe_customer_id);

				$card = $customer->sources->create(array("source" => $request['card_token']));

				UserCard::add_user_card($request->all());

				$cards = UserCard::get_user_cards($request->all());

				$data = [
							'cards' => $cards
						];
				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Card Added Successfully'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

////////////////////////////		User Card Lists 		//////////////////////

	public static function list_cards(Request $request)
		{
		try{

				$user = \App('user');

				$cards = UserCard::get_user_cards($request->all());

				$data = [
							'cards' => $cards
						];

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.User Cards Listings'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

//////////////////////////			Delete Card 		/////////////////////////////

	public static function delete_card(Request $request)
		{
		try{

				$user = \App('user');

				$rules = [
							'id' => 'required|exists:user_cards,id,deleted,0,user_id,'.$user->id
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$usercard = UserCard::get_one_card($request->all());
				if($usercard->is_default == '1')
					{
						UserCard::where('user_id',$request['user_id'])->where('deleted','0')->where('id','!=',$request['id'])->orderby('id','DESC')->limit(1)->update([
									'is_default' => '1',
									'updated_at' => new \DateTime
										]);
					}

				\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

				$customer = \Stripe\Customer::retrieve($user->stripe_customer_id);
				$customer->sources->retrieve($usercard->card_id)->delete();

				UserCard::delete_user_card($request->all());

				$cards = UserCard::get_user_cards($request->all());

				$data = [
							'cards' => $cards
						];

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Card Deleted Successfully'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////////			Update Cards 		////////////////////////////////////////////////

	public static function update_card(Request $request)
		{
		try{

				$user = \App('user');

				$rules = [
							'id' => 'required|exists:user_cards,id,deleted,0,user_id,'.$user->id
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$usercard = UserCard::get_one_card($request->all());

				\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

				$customer = \Stripe\Customer::retrieve($user->stripe_customer_id);
				$card = $customer->sources->retrieve($usercard->card_id);
				
				$card->name = $user->username;

				if(isset($request['exp_month']))
					$card->exp_month = $request['exp_month'];

				if(isset($request['exp_year']))
					$card->exp_year = $request['exp_year'];

				// if(isset($request['cvc']))
				// 	$card->cvc = $request['cvc'];

				$card->save();

				$cards = UserCard::get_user_cards($request->all());

				$data = [
							'cards' => $cards
						];

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Card Updated Successfully'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////////			Make Card Default 		////////////////////////////////////////////////
	public static function default_card(Request $request)
		{
		try{

				$user = \App('user');

				$rules = [
							'id' => 'required|exists:user_cards,id,deleted,0,user_id,'.$user->id
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$usercard = UserCard::get_one_card($request->all());
				if($usercard->is_default == '1')
					return response(["success"=>0,'msg'=>trans('messages.Sorry, this card is already your default card')],200);

				\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

				$customer = \Stripe\Customer::retrieve($user->stripe_customer_id);

				$customer->default_source=$usercard->card_id;
				$customer->save();

				UserCard::where('user_id',$request['user_id'])->where('deleted','0')->where('id','!=',$request['id'])->update([
									'is_default' => '0',
									'updated_at' => new \DateTime
										]);


				UserCard::where('id','=',$request['id'])->update([
									'is_default' => '1',
									'updated_at' => new \DateTime
										]);

				$cards = UserCard::get_user_cards($request->all());

				$data = [
							'cards' => $cards
						];

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Default Card Updated Successfully'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}


///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////			Connect Stripe Account
///////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////		Sending Email 		////////////////////////////////////////////

	public static function connect_account(Request $request)
		{
		try{
				$user = \App('user');

				$request['stripe_connect_token'] = str_random(90);
				$request['user_id'] = $user->id;

				User::stripe_connect_request($request->all());

				$sender = DB::Table('admin')->first();

//https://dashboard.stripe.com/oauth/authorize?response_type=code&client_id=ca_C3SJiZg7RdLHuoNTBvvI3frBaZeZIsIt&scope=read_write

	$request['link'] = 'https://dashboard.stripe.com/oauth/authorize?response_type=code&client_id='.env('STRIPE_CONNECT_DCLIENT_ID').'&scope=read_write&state='.$request['stripe_connect_token'];

		$mail = \Mail::send('Emails.Api.stripe_connect_mail', array('receiver'=>$user,'sender'=>$sender,'data'=>$request->all()),
			function($message) use ($user)
				{
    $message->to($user->email, $user->first_name.' '.$user->last_name)->subject(env('APP_NAME').' - '.trans('messages.Stripe Connect Email'));
        		});

	return Response(['success'=>1,'statuscode'=>200,'msg' => trans('messages.Please check your email for Stripe Connect email')],200);


			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

////////////////////////////		Stripe Redirection 	//////////////////////////////////////////////////

	public static function connect_account_get(Request $request)
		{
		try{
//		http://192.168.100.69:9096/Api/V1/connect_account
//	https://dashboard.stripe.com/oauth/authorize?response_type=code&client_id=ca_C3SJiZg7RdLHuoNTBvvI3frBaZeZIsIt&scope=read_write&state=BYDYyOMsHzptP6QEl6astkZ15cWAbcT6KUzdMI0Mjro2pzIW87dHpqLmBs92KLxPvnPuRpLUgmuyqzJO8mPd4CpN9e

				$rules = array('state'=>'required|exists:users,stripe_connect_token');
				$msg = [
					'state.exists' => 'Sorry, this link has expired'
						];

			$validator = Validator::make($request->all(),$rules, $msg);
				if($validator->fails())
					{
						return \View::make('errors.404')->with('error',$validator->getMessageBag()->first());
					}

			if(isset($request['error']))
				return \View::make('errors.404')->with('error',$request['error_description']);

				$user = DB::table('users')->where('stripe_connect_token',$request['state'])->first();

	$xdata = array('client_secret'=>env('STRIPE_SECRET_KEY'),'code'=>$request['code'],'grant_type'=>'authorization_code');
	$url1 = 'https://connect.stripe.com/oauth/token';

				$ch = curl_init($url1);
				curl_setopt($ch, CURLOPT_POST, 1);
				curl_setopt($ch, CURLOPT_POSTFIELDS, $xdata);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

				$response = curl_exec($ch);
				$response = json_decode($response,true);
				curl_close($ch);

				$admin = DB::table('admin')->first();

				if(isset($response['refresh_token']))
					{

						$request['user_id'] = $user->id;
						$request['stripe_connect_id'] = $response['stripe_user_id'];

						User::add_user_stripe_connect($request->all());

						return \View('welcome')->with('status',trans('messages.Account Linked Successfully'));

					}
				else
					{

						if(isset($response['error_description']))
							{
								return \View::make('errors.404')->with('error',$response['error_description']);
							}
						else
							{
								return \View::make('errors.404')->with('error',trans('messages.Sorry, this link has expired'));
							}
						
					}

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

////////////////////////////		Adding Account Number 		//////////////////////////////////////////

	public static function add_account(Request $request)
		{
		try{
				$rules = [
							'account_holder_name' => 'required',
							'account_number'=>'required',
							'routing_number' => 'required',
							'country' => 'required',
							'currency' => 'required',
							'type' => 'required|in:individual,company'
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');

				\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

					if($user->stripe_connect_id == '')
						{/////////////////		Creating Stripe Connect ID 		/////////////////////////////

							$stripe_connect_user =	\Stripe\Account::create(array(
														"type" => "custom",
														"country" => $request['country'],
														"email" => $user->email,
														"default_currency" => $request['currency'],
														"business_name" => $user->username,
														"payout_schedule" => [
																	"interval" => "manual",
																	"delay_days" => 30
																],
														"metadata" => [
																	'user_id' => $user->id
																]
															));

							$request['stripe_connect_id'] = $stripe_connect_user['id'];

							User::where('id',$user->id)->update([
									'stripe_connect_id' => $request['stripe_connect_id'],
									'updated_at' => new \DateTime
										]);

						}/////////////////		Creating Stripe Connect ID 		/////////////////////////////
					else
						{
							$request['stripe_connect_id'] = $user->stripe_connect_id;
						}
					
				$user_connect_account = \Stripe\Account::retrieve($request['stripe_connect_id']);
					
				$bank_account = $user_connect_account->external_accounts->create(array("external_account" => [
										"object" => "bank_account",
										"account_number" => $request['account_number'],
										"routing_number" => $request['routing_number'],
										"country" => $request['country'],
										"currency" => $request['currency'],
										"account_holder_name" => $request['account_holder_name'],
										"account_holder_type" => $request['type'],
										"default_for_currency" => true,
										"metadata" => [
												"user_id" => $user->id
											]
									]));

				$request['fingerprint'] = $bank_account['fingerprint'];

	///////////////////////////		FingerPrint Check 		//////////////////////////////////////////////////////////
				// $user_account = UserAccounts::where('deleted','0')->where('fingerprint',$request['fingerprint'])->where('user_id',$request['user_id'])->count();
				// if($user_account)
				// 	{

				// 		$user_connect_account->external_accounts->retrieve($bank_account['id'])->delete();

				// 		return response(['success'=>0, 'statuscode'=>200, 'msg'=>'Sorry, this account is already added by you'],200);
				// 	}
	///////////////////////////		FingerPrint Check 		//////////////////////////////////////////////////////////

					UserAccounts::where('user_id',$request['user_id'])->update([
						'is_default' => '0',
						'updated_at' => new \DateTime
							]);

					$request['account_id'] = $bank_account['id'];
					$request['account_holder_type'] = $bank_account['account_holder_type'];
					$request['bank_name'] = $bank_account['bank_name'];
					$request['last4'] = $bank_account['last4'];
					$request['routing_number'] = $bank_account['routing_number'];
					$request['status'] = $bank_account['status'];

					$old_account_check = UserAccounts::where('user_id',$user->id)->where('fingerprint',$request['fingerprint'])->first();
					if($old_account_check)
						{
							$request['id'] = $old_account_check->id;
							UserAccounts::update_old_account($request->all(), $old_account_check);
						}
					else
						{
							UserAccounts::add_user_account($request->all());
						}

				$accounts = UserAccounts::get_user_accounts($request->all());

				$data = [
							'accounts' => $accounts
						];			

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Account Added Successfully'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

//////////////////////////////

}
