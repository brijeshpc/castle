<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use Validator, DateTime, DB;
use Carbon\Carbon;

use App\Models\User;
use App\Models\UserAccounts;
use App\Models\UserAddress;
use App\Models\Sale;

class UserConnectController extends Controller
{
//////////////////////////		Latest Add Bank Account 	/////////////////////////////////////

	public static function latest_add_account(Request $request)
	{
	try{

			$rules = [
						'first_name' => 'required',
						'last_name' => 'required',
						'line1' => 'required',
						'city' => 'required',
						'state' => 'required',
						//'country' => 'required',
						'zipcode' => 'required',
						'dob' => 'required',
						'ssn' => 'required',
						'account_number'=>'required',
						'routing_number' => 'required'
					 ];

			$validation = Validator::make($request->all(),$rules);
			if($validation->fails())
				return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$user = \App('user');
			$user->dob_exploded = explode('-', $request['dob']);

			\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

			if($user->stripe_connect_id == '')
				{/////////////////		Creating Stripe Connect ID 		/////////////////////////////

					$user_connect_account =	\Stripe\Account::create(array(
							"type" => "custom",
							"country" => "US",
							"email" => $user->email,
							//"display_name" => $request['first_name'].' '.$request['last_name'],
							"support_email" => $user->email,
							"default_currency" => 'USD',
							"business_name" => $request['first_name'].' '.$request['last_name'],
							"debit_negative_balances" => true,
							"payout_schedule" => [
								"interval" => "manual",
								//"delay_days" => 30
									],
							"metadata" => [
								'user_id' => $user->id
									],
							"external_account" => [
								"object" => "bank_account",
								"account_number" => $request['account_number'],
								"routing_number" => $request['routing_number'],
								"country" => "US",
								"currency" => "USD",
								"account_holder_name" => $request['first_name'].' '.$request['last_name'],
								"account_holder_type" => "individual",
								"default_for_currency" => true,
								"metadata" => [
										"user_id" => $user->id
											]
									],
							"payout_statement_descriptor" => env('APP_NAME'),
							"statement_descriptor" => env('APP_NAME'),
							"legal_entity" => [
										"business_name" => $request['first_name'].' '.$request['last_name'],
										"first_name" => $request['first_name'],
										"last_name" => $request['last_name'],
										"type" => "individual",
										"address" => [
											"line1" => $request['line1'],
											"city" => $request['city'],
											"state" => $request['state'],
											"country" => "US",
											"postal_code" => $request['zipcode']
												],
										"personal_address" => [
											"line1" => $request['line1'],
											"city" => $request['city'],
											"state" => $request['state'],
											"country" => "US",
											"postal_code" => $request['zipcode']
												],
										"dob" => [
											"day" => $user->dob_exploded[2],
											"month" => $user->dob_exploded[1],
											"year" => $user->dob_exploded[0]
												],
										"personal_id_number" => $request['ssn'],
										"ssn_last_4" => substr($request['ssn'], -4)
									],
								"tos_acceptance" => [
										"date" => time(),
										"ip" => $_SERVER['REMOTE_ADDR'],
										"user_agent" => "IOSApp"
									]
								));

						if(!isset($user_connect_account['id']))
							return Response(['success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Something went wrong please try again')],200);

						$user->stripe_connect_id = $user_connect_account['id'];

						$bank_account = $user_connect_account['external_accounts']->data[0];

					}/////////////////		Creating Stripe Connect ID 		/////////////////////////////
				else
					{/////////////////		Creating Stripe Connect ID 		/////////////////////////////

						$user_connect_account = \Stripe\Account::retrieve($user->stripe_connect_id);

						//$user_connect_account->support_phone = "555-867-5309";

						$user_connect_account->business_name = $request['first_name'].' '.$request['last_name'];
						$user_connect_account->legal_entity['first_name'] = $request['first_name'];
						$user_connect_account->legal_entity['last_name'] = $request['last_name'];

						//$user_connect_account->display_name = $request['first_name'].' '.$request['last_name'];

						$user_connect_account->legal_entity['address']['line1'] = $request['line1'];
						$user_connect_account->legal_entity['address']['city'] = $request['city'];
						$user_connect_account->legal_entity['address']['state'] = $request['state'];
						$user_connect_account->legal_entity['address']['postal_code'] = $request['zipcode'];

						$user_connect_account->legal_entity['personal_address']['line1'] = $request['line1'];
						$user_connect_account->legal_entity['personal_address']['city'] = $request['city'];
						$user_connect_account->legal_entity['personal_address']['state'] = $request['state'];
						$user_connect_account->legal_entity['personal_address']['postal_code'] = $request['zipcode'];

						$user_connect_account->legal_entity['dob']['day'] = $user->dob_exploded[2];
						$user_connect_account->legal_entity['dob']['month'] = $user->dob_exploded[1];
						$user_connect_account->legal_entity['dob']['year'] = $user->dob_exploded[0];

						$user_connect_account->legal_entity['personal_id_number'] = $request['ssn'];
						$user_connect_account->legal_entity['ssn_last_4'] = substr($request['ssn'], -4);
						$user_connect_account->legal_entity['business_name'] = $request['first_name'].' '.$request['last_name'];

						//dd($user_connect_account);

						$user_connect_account->save();
					
						$bank_account = $user_connect_account->external_accounts->create(array("external_account" => [
										"object" => "bank_account",
										"account_number" => $request['account_number'],
										"routing_number" => $request['routing_number'],
										"country" => "US",
										"currency" => "USD",
										"account_holder_name" => $request['first_name'].' '.$request['last_name'],
										"account_holder_type" => "individual",
										"default_for_currency" => true,
										"metadata" => [
												"user_id" => $user->id
													]
											]));

					}/////////////////		Creating Stripe Connect ID 		/////////////////////////////

					$request['fingerprint'] = $bank_account['fingerprint'];

					User::where('id',$user->id)->update([
									'stripe_connect_id' => $user->stripe_connect_id,
									'first_name' => $request['first_name'],
									'last_name' => $request['first_name'],
									'dob' => $request['dob'],
									'ssn_last_4'=> $request['ssn'],
									'stripe_connect_account_status' => '1',
									'updated_at' => new \DateTime
										]);



					UserAccounts::where('user_id',$request['user_id'])->update([
							'is_default' => '0',
							'updated_at' => new \DateTime
								]);

					$request['account_id'] = $bank_account['id'];
					$request['account_holder_type'] = $bank_account['account_holder_type'];
					$request['account_holder_name'] = $bank_account['account_holder_name'];
					$request['bank_name'] = $bank_account['bank_name'];
					$request['last4'] = $bank_account['last4'];
					$request['routing_number'] = $bank_account['routing_number'];
					$request['status'] = $bank_account['status'];

				$old_account_check = UserAccounts::where('user_id',$user->id)->where('fingerprint',$request['fingerprint'])->first();
				if($old_account_check)
					{
						$user_connect_account->external_accounts->retrieve($old_account_check->account_id)->delete();

						$request['id'] = $old_account_check->id;
						UserAccounts::update_old_account($request->all(), $old_account_check);
					}
				else
					{
						UserAccounts::add_user_account($request->all());
					}

//				$accounts = UserAccounts::get_user_accounts($request->all());

				// $data = [
				// 			'user' => $user,
				// 			'user_connect_account' => $user_connect_account,
				// 			'bank_account' => $bank_account,
				// 			'accounts' => $accounts
				// 		];

			return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Account Added Successfully')/*, 'data' => $data*/],200);

		}
	catch(\Exception $e)
		{
			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

///////////////////////////////			User Balance Amount 	/////////////////////////////////

	public static function balance_amount(Request $request)
		{
		try{

				$user = \App('user');

				$request['now'] = Carbon::now();
				$request['startOfWeek'] = $request['now']->startOfWeek()->format('Y-m-d H:i:s');
				$request['endOfWeek'] = $request['now']->endOfWeek()->format('Y-m-d H:i:s');

				$balance = Sale::get_user_balance($request->all());

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Balance Amount'), 'data' => ['balance' => $balance]
				],200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////////////////			Update Bank Account 	///////////////////////////////

	public static function update_account(Request $request)
		{
		try{

				$rules = [
							'first_name' => 'required',
							'last_name' => 'required',
							'line1' => 'required',
							'city' => 'required',
							'state' => 'required',
							//'country' => 'required',
							'zipcode' => 'required',
							'dob' => 'required',
							'ssn' => 'required'
						];

				$validation = Validator::make($request->all(),$rules);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$user = \App('user');
				$user->dob_exploded = explode('-', $request['dob']);

				\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

				$user_connect_account = \Stripe\Account::retrieve($user->stripe_connect_id);

				$user_connect_account->business_name = $request['first_name'].' '.$request['last_name'];
				$user_connect_account->legal_entity['first_name'] = $request['first_name'];
				$user_connect_account->legal_entity['last_name'] = $request['last_name'];

				$user_connect_account->legal_entity['address']['line1'] = $request['line1'];
				$user_connect_account->legal_entity['address']['city'] = $request['city'];
				$user_connect_account->legal_entity['address']['state'] = $request['state'];
				$user_connect_account->legal_entity['address']['postal_code'] = $request['zipcode'];

				$user_connect_account->legal_entity['personal_address']['line1'] = $request['line1'];
				$user_connect_account->legal_entity['personal_address']['city'] = $request['city'];
				$user_connect_account->legal_entity['personal_address']['state'] = $request['state'];
				$user_connect_account->legal_entity['personal_address']['postal_code'] = $request['zipcode'];

				$user_connect_account->legal_entity['dob']['day'] = $user->dob_exploded[2];
				$user_connect_account->legal_entity['dob']['month'] = $user->dob_exploded[1];
				$user_connect_account->legal_entity['dob']['year'] = $user->dob_exploded[0];

				$user_connect_account->legal_entity['personal_id_number'] = $request['ssn'];
				$user_connect_account->legal_entity['ssn_last_4'] = substr($request['ssn'], -4);
				$user_connect_account->legal_entity['business_name'] = $request['first_name'].' '.$request['last_name'];

				$user_connect_account->save();

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Account Updated Successfully')],200);

			}
		catch(Illuminate\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}



///////////////////////////////////	New Add Account 		/////////////////////////////////////
public static function new_add_account(Request $request)
	{
	try{

			$rules = [
						'account_holder_name' => 'required',
						'account_number'=>'required',
						'routing_number' => 'required'
					 ];

			$validation = Validator::make($request->all(),$rules);
			if($validation->fails())
				return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$user = \App('user');
			if($user->dob == null)
				return Response(['success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Please update your DOB first')],200);

			$user->default_address = UserAddress::where('deleted','0')->where('is_default','1')->where('user_id',$user->id)->first();
			if(!$user->default_address)
				return Response(['success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Please add your default address')],200);

			$user->dob_exploded = explode('-', $user->dob);

			\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

			if($user->stripe_connect_id == '')
				{/////////////////		Creating Stripe Connect ID 		/////////////////////////////

				$user_connect_account =	\Stripe\Account::create(array(
							"type" => "custom",
							"country" => "US",
							"email" => $user->email,
							"default_currency" => 'USD',
							"business_name" => $user->first_name.' '.$user->last_name,
							"payout_schedule" => [
								"interval" => "manual",
								//"delay_days" => 30
									],
							"metadata" => [
								'user_id' => $user->id
									],
							"external_account" => [
								"object" => "bank_account",
								"account_number" => $request['account_number'],
								"routing_number" => $request['routing_number'],
								"country" => "US",
								"currency" => "USD",
								"account_holder_name" => $request['account_holder_name'],
								"account_holder_type" => "individual",
								"default_for_currency" => true,
								"metadata" => [
										"user_id" => $user->id
											]
									],
								"legal_entity" => [
										"first_name" => $user->first_name,
										"last_name" => $user->last_name,
										"type" => "individual",
										"address" => [
											"line1" => $user->default_address->line1,
											"city" => $user->default_address->city,
											"state" => $user->default_address->state,
											"country" => $user->default_address->country,
											"postal_code" => $user->default_address->zipcode
										],
										"personal_address" => [
											"line1" => $user->default_address->line1,
											"city" => $user->default_address->city,
											"state" => $user->default_address->state,
											"country" => $user->default_address->country,
											"postal_code" => $user->default_address->zipcode
										],
										"dob" => [
											"day" => $user->dob_exploded[2],
											"month" => $user->dob_exploded[1],
											"year" => $user->dob_exploded[0]
										],
										"ssn_last_4" => substr($user->ssn_last_4, -4)//$user->ssn_last_4
									],
								"tos_acceptance" => [
										"date" => time(),
										"ip" => $_SERVER['REMOTE_ADDR'],
										"user_agent" => "IOSApp"
									]
								));

						if(!isset($user_connect_account['id']))
							return Response(['success'=>0, 'statuscode'=>200, 'msg'=>trans('messages.Something went wrong please try again')],200);

						User::where('id',$user->id)->update([
									'stripe_connect_id' => $user_connect_account['id'],
									'stripe_connect_account_status' => 'VERIFICATION_PENDING',
									'updated_at' => new \DateTime
										]);

						$bank_account = $user_connect_account['external_accounts']->data[0];

					}/////////////////		Creating Stripe Connect ID 		/////////////////////////////
				else
					{/////////////////		Creating Stripe Connect ID 		/////////////////////////////

						$user_connect_account = \Stripe\Account::retrieve($user->stripe_connect_id);
					
						$bank_account = $user_connect_account->external_accounts->create(array("external_account" => [
										"object" => "bank_account",
										"account_number" => $request['account_number'],
										"routing_number" => $request['routing_number'],
										"country" => "US",
										"currency" => "USD",
										"account_holder_name" => $request['account_holder_name'],
										"account_holder_type" => "individual",
										"default_for_currency" => true,
										"metadata" => [
												"user_id" => $user->id
													]
											]));

					}/////////////////		Creating Stripe Connect ID 		/////////////////////////////

					$request['fingerprint'] = $bank_account['fingerprint'];

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

							$user_connect_account->external_accounts->retrieve($old_account_check->account_id)->delete();

							$request['id'] = $old_account_check->id;
							UserAccounts::update_old_account($request->all(), $old_account_check);
						}
					else
						{
							UserAccounts::add_user_account($request->all());
						}

				$accounts = UserAccounts::get_user_accounts($request->all());

				$data = [
							'user_connect_account' => $user_connect_account,
							'bank_account' => $bank_account,
							'accounts' => $accounts
						];			

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Account Added Successfully'), 'data' => $data],200);


		}
	catch(\Exception $e)
		{
			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

////////////////////////////		User Account Lists 		/////////////////////////////////////////////////

	public static function list_accounts(Request $request)
		{
		try{

				$user = \App('user');

				$accounts = UserAccounts::get_user_accounts($request->all());

				$data = [
							'accounts' => $accounts
						];

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.User Accounts Listings'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

////////////////////////////		Delete User Account 		/////////////////////////////////////////////////

	public static function delete_account(Request $request)
		{
		try{

				$user = \App('user');

				$rules = [
							'id' => 'required|exists:user_accounts,id,deleted,0,user_id,'.$user->id
						 ];

				$validation = Validator::make($request->all(),$rules);
					if($validation->fails())
						return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

				$useraccount = UserAccounts::get_one_account($request->all());
				if($useraccount->is_default == '1')
					return response(["success"=>0,'msg'=>trans('messages.Sorry, this account is your default account. Please add another default account first')],200);

////////////////////		Stripe 	//
				\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

				$account = \Stripe\Account::retrieve($user->stripe_connect_id);
				$account->external_accounts->retrieve($useraccount->account_id)->delete();
////////////////////		Stripe 	//
	
				if($useraccount->is_default == '1')
					{
						UserAccounts::where('user_id',$request['user_id'])->where('deleted','0')->where('id','!=',$request['id'])->orderby('id','DESC')->limit(1)->update([
									'is_default' => '1',
									'updated_at' => new \DateTime
										]);
					}

				UserAccounts::delete_user_account($request->all());

				$accounts = UserAccounts::get_user_accounts($request->all());

				$data = [
							'accounts' => $accounts
						];

				return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.User Accounts Deleted Successfully'), 'data' => $data],200);

			}
		catch(\Exception $e)
			{
				return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
			}
		}

///////////////////////			Make Account Default 		////////////////////////////////////////////////

public static function default_account(Request $request)
	{
	try{

			$user = \App('user');
	
			$rules = [
						'id' => 'required|exists:user_accounts,id,deleted,0,user_id,'.$user->id
					 ];

			$validation = Validator::make($request->all(),$rules);
				if($validation->fails())
					return Response(array('success'=>0, 'statuscode'=>400, 'msg'=>$validation->getMessageBag()->first()),400);

			$useraccount = UserAccounts::get_one_account($request->all());
			if($useraccount->is_default == '1')
				return response(["success"=>0,'msg'=>trans('messages.Sorry, this account is already your default account')],200);

///////////////		Stripe 		///////
			\Stripe\Stripe::setApiKey(env('STRIPE_SECRET_KEY'));

			$account = \Stripe\Account::retrieve($user->stripe_connect_id);
			$bank_account = $account->external_accounts->retrieve($useraccount->account_id);
			$bank_account->default_for_currency = true;
			$bank_account->save();
///////////////		Stripe 		///////

			UserAccounts::where('user_id',$request['user_id'])->where('deleted','0')->where('id','!=',$request['id'])->update([
								'is_default' => '0',
								'updated_at' => new \DateTime
									]);


			UserAccounts::where('id','=',$request['id'])->update([
								'is_default' => '1',
								'updated_at' => new \DateTime
									]);

			$accounts = UserAccounts::get_user_accounts($request->all());

			$data = [
						'accounts' => $accounts
					];

			return Response(['success'=>1, 'statuscode'=>200, 'msg'=>trans('messages.Default Account Updated Successfully'), 'data' => $data],200);

			}
	catch(\Exception $e)
		{
			return \Response(array('success'=>0,'statuscode'=>500,'msg'=>$e->getMessage()),500);
		}
	}

}
