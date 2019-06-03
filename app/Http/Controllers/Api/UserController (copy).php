<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Input;
use Validator, Hash, DateTime, Mail, DB;
use Carbon\Carbon;
use Laravel\Passport\HasApiTokens;
use Illuminate\Support\Facades\Auth; 
use App\User;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{

	//////// User SignUp   ////////////
	public static function userSignUp(Request $request)
	{
		try{
				$postData = $request->all();
				if(isset($postData) && !empty($postData)){
					if(isset($postData['signup_by']) && !empty($postData['signup_by']))
					{
						if($postData['signup_by'] == "email")
						{
							if(isset($postData['email']) && !empty($postData['email'])){
								$postData['email'] = strtolower($postData['email']);
								$validation = Validator::make($postData, [
									'email' => 'bail|required|unique:users|max:255',
								    'password' =>'bail|min:7|required_without_all:facebook_id,gmail_id',
								]);
								if($validation->fails())
									return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
									], 401);
							}	
						} else if($postData['signup_by'] == "gmail_id"){
							if(isset($postData['gmail_id']) && !empty($postData['gmail_id'])){
								$validation = Validator::make($postData, [
									'gmail_id' => 'bail|required|unique:users|max:255',
								]);

								if($validation->fails())
									return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
								], 401);
							}
						} else if($postData['signup_by'] == "facebook_id"){
								$validation = Validator::make($postData, [
									'facebook_id' => 'bail|required|unique:users|max:255',
								]);
								if($validation->fails())
									return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
								], 401);
						} else {
							return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Required values are not set" 
								], 401);
						} 
						$user = User::createNewUser($postData);
						if(isset($user) && !empty($user)){
							return response()->json(['success' => 1, 'token' => $user['token'], 'statuscode' => 200, 'data' => $user['user']], 200);
						} else {
								return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Registration Failed" 
							], 401);
						} 

					} else {
						return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Required values are not set" 
						], 401);
					}
				} else {
						return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Required values are not set" 
						], 401);
				}
			}catch(\Exception $e){
				return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
		}
	}

	public function details() 
    { 
    	//echo "William Rone"; die;
        $user = Auth::user(); 
        return response()->json(['success' => $user], 200); 
    } 

    /**
     * Login user and create token
     *
     * @param  [string] email
     * @param  [string] password
     * @param  [boolean] remember_me
     * @return [string] access_token
     * @return [string] token_type
     * @return [string] expires_at
     */

    public function userLogin(Request $request) 
    { 
        try{
				$postData = $request->all();

				if(isset($postData) && !empty($postData)){

					if(isset($postData['login_by']) && !empty($postData['login_by']))
					{

						$validation = Validator::make($postData, [
									'email' => 'bail|required|max:255',
								    'password' =>'bail|min:7|required_without_all:facebook_id,gmail_id',
								]);
						if($validation->fails())
							return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
							], 401);

    					if($postData['login_by'] == "email")
						{
							$credentials = [
								'email' => $postData['email'],
								'password' => $postData['password']
							];

							if(auth()->attempt($credentials)) {
	        				    $user = auth()->user();
								$token = auth()->user()->createToken('castle')->accessToken;
							    return response()->json(['success' => 1, 'token' => $token, 'statuscode' => 200, 'data' => $user], 200);
							} else {
								return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Credentials did not match, please try again." 
								], 401);
							}
						} else {
							return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Required values are not set" 
								], 401);
						}
					} else {
						return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Required values are not set" 
								], 401);
					}
				} else{
					return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Required values are not set" 
								], 401);
				}
			}catch(\Exception $e){
				return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
		} 
    } 

    /**
     * Logout user (Revoke the token)
     *
     * @return [string] message
     */
    public function logout(Request $request)
    {
        $request->user()->token()->revoke();
        return response()->json([
            'message' => 'Successfully logged out'
        ]);
    }

    /**
     * Update profile(Revoke the token)
     *
     * @return [string] message
     */
    public function updateProfile(Request $request)
    {
    	$user = Auth::user();

    	if($user){

    		$postData = $request->all();

			if(isset($postData) && !empty($postData)){

				$validation = Validator::make($postData, [
					'first_name' => 'bail|required|max:255',
					'last_name' => 'bail|required|max:255',
					'address' => 'bail|required|max:255',
					'city' => 'bail|required|max:255',
					'country' => 'bail|required|max:255',
					'state' => 'bail|required|max:255',
					'zip' => 'bail|required|max:255'
				]);

				if($validation->fails())
					return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
					], 401);

				$user = User::find($user->id);

				if(isset($postData['avatar'])){

					$validation = Validator::make($postData, [
						'avatar' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
					]);

					if($validation->fails())
						return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
						], 401);

					$avatarName = $user->id.'_avatar'.time().'.'.request()->avatar->getClientOriginalExtension();
					$request->avatar->storeAs('avatars',$avatarName);
					$user->avatar = $avatarName;

				}
	    		
	            $user->first_name = $postData['first_name'];
	            $user->last_name = $postData['last_name'];
	            $user->address = $postData['address'];
	            $user->city = $postData['city'];
	            $user->country = $postData['country'];
	            $user->state = $postData['state'];
	            $user->zip = $postData['zip'];

	            if($user->save()){
	            	$url = env('PUBLIC_URL')."storage/app/public/avatars/".$user->avatar;
	            	echo $url; die;
                	return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $user, 'avatar_url' => $url,200]);

	            } else {
	            	return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Updation failed"
					], 401);
	            }
	    	} else {
	    		return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Required values are not sdfsdfsdfsdfsdf dfgdfgdfg set" 
						], 401);
	    	}
   		}
   	}

    public function tokenExpired(Request $request)
    {
   		return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Token has not been set."], 401);
    }
}
