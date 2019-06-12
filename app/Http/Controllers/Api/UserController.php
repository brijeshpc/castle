<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Input;
use Validator, Hash, DateTime, DB;
use Carbon\Carbon;
use Laravel\Passport\HasApiTokens;
use Illuminate\Support\Facades\Auth; 
use App\User;
use App\PasswordReset;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Mail;
use App\Mail\ForgotPasswordMail;

class UserController extends Controller
{

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

							$postData['password'] = "asdsduiuwpoocmxnc";							
							if(isset($postData['gmail_id']) && !empty($postData['gmail_id'])){
								$validation = Validator::make($postData, [
									'gmail_id' => 'bail|required|unique:users|max:255',
									'email' => 'bail|required|unique:users|max:255',
								]);

								if($validation->fails())
									return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
								], 401);
							}
						} else if($postData['signup_by'] == "facebook_id"){

								$postData['password'] = "asdsduiuwpoocmxnc";	

								$validation = Validator::make($postData, [
									'facebook_id' => 'bail|required|unique:users|max:255',
									'email' => 'bail|required|unique:users|max:255',
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
    					if($postData['login_by'] == "email")
						{

							$validation = Validator::make($postData, [
								'email' => 'bail|required|max:255',
								'password' =>'bail|required',
							]);
							if($validation->fails())
								return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
								], 401);

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
						} else if($postData['login_by'] == "gmail_id") {

								$validation = Validator::make($postData, [
										'email' => 'bail|required|max:255',
										'gmail_id' =>'bail|required_without_all:gmail_id'
									]);

								if($validation->fails())
									return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
								], 401);

								$userGmail = User::where("email", $postData['email'])
											->where("gmail_id", $postData['gmail_id'])
											->get();

			   				    if (!$userGmail->isEmpty()) { 

			   				    	$credentials = [
										'email' => $postData['email'],
										'password' => "asdsduiuwpoocmxnc"
									];

									if(auth()->attempt($credentials)) {
										$user = auth()->user();
										$token = auth()->user()->createToken('castle')->accessToken;
										return response()->json(['success' => 1, 'token' => $token, 'statuscode' => 200, 'data' => $user], 200);
									} else {
										//echo "Rone"; die;
										return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Credentials did not match, please try again." 
										], 401);
									}

								}	
								return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Credentials did not match, please try again." 
										], 401);
							} else {

								if($postData['login_by'] == "facebook_id") {

									$validation = Validator::make($postData, [
										'email' => 'bail|required|max:255',
										'facebook_id' => 'bail|required_without_all:gmail_id'
									]);

									if($validation->fails())
										return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
									], 401);

									$userFacebook = User::where("email", $postData['email'])
												->where("facebook_id", $postData['facebook_id'])
												->get();

				   				    if (!$userFacebook->isEmpty()) { 

				   				    	$credentials = [
											'email' => $postData['email'],
											'password' => "asdsduiuwpoocmxnc"
										];

										if(auth()->attempt($credentials)) {
											$user = auth()->user();
											$token = auth()->user()->createToken('castle')->accessToken;
											return response()->json(['success' => 1, 'token' => $token, 'statuscode' => 200, 'data' => $user], 200);
										} else {
											//echo "Rone"; die;
											return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Credentials did not match, please try again." 
											], 401);
										}

									}	
									return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Credentials did not match, please try again." 
											], 401);
								}
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

    		try{
		    		$postData = $request->all();

					if(isset($postData) && !empty($postData)){

						$validation = Validator::make($postData, [
							'first_name' => 'bail|required|max:255',
							'gender' => 'bail|required|max:255',
							'city' => 'bail|required|max:255',
							'state' => 'bail|required|max:255'
						]);

						if($validation->fails())
							return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
							], 401);

						$user = User::find($user->id);

						$user->first_name = isset($postData['first_name']) ? $postData['first_name'] : '';
			            $user->last_name = isset($postData['last_name']) ? $postData['last_name'] : '';
			            $user->gender = isset($postData['gender']) ? $postData['gender'] : '';
			            $user->address = isset($postData['address']) ? $postData['address'] : '';
			            $user->city = isset($postData['city']) ? $postData['city'] : '';
			            $user->country = isset($postData['country']) ? $postData['country'] : '';
			            $user->state = isset($postData['state']) ? $postData['state'] : '';
			            

			            if($user->save()){
			            	//$url = env('PUBLIC_URL')."storage/app/public/avatars/".$user->avatar;
		                	return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $user],200);

			            } else {
			            	return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Updation failed"
							], 401);
			            }
			    	} else {
			    		return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Required values are not set" 
								], 401);
			    	}

		   		} catch(\Exception $e){
				return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
			}
		}
   	}

    public function tokenExpired(Request $request)
    {
   		return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Token has not been set."], 401);
    }

    
	public function avatar(Request $request) {

	 	$user = Auth::user();

	 	if($user){
 			try{

 				$postData = $request->all();

	 			if (isset($postData['avatar']) && !empty($postData['avatar'])) {

					$validation = Validator::make($postData, [
						'avatar' => 'required'
					]);

					if($validation->fails())
						return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
						], 401);

					$imageName = "avatar_".$user->id.".png";
					$data = $postData['avatar'];
					$data = base64_decode(preg_replace('#^data:image/\w+;base64,#i', '', $data));
					//$upload_success = Storage::disk('public')->put('avatars/' . $fileName, $data);

    				if(Storage::disk('public')->put('avatars/' . $imageName, $data)){
						$user = User::find($user->id);
			            $getAvatar = isset($postData['avatar']) ? $imageName : '';
			            $finalImageUrl = env('STORAGE_URL')."app/public/avatars/".$getAvatar;
			            $user->avatar = $finalImageUrl;
			            if($user->save()){
				            	$url = env('STORAGE_URL')."app/public/avatars/";
			                	return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $user, 'url' => $finalImageUrl], 200);
				        }
					} else {
						return response()->json(['success' => 0, 'statuscode' => 200, 'error' => "Avatar upload failed."],200);
					}
				} else {
					return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Required values are not set" 
						], 401);
				}
			} catch (\Exception $e){
				return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
			}
		}
	}


	/**
     * Update profile(Revoke the token)
     *
     * @return [string] message
     */
    public function getProfile(Request $request)
    {
    	$user = Auth::user();
    	if($user){
    		try{
					$user = User::find($user->id);

					if($user){
						$url = env('STORAGE_URL')."app/public/avatars/";
			            return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $user, 'url' => $url, 'google_facebook'], 200);
			        }

	            	return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Updation failed"
					], 401);

		   	}  catch(\Exception $e){
				return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
  		 	}
    	}
    }

    /*
		** for the forgot password
	*/
	public function forgotPassword(Request $request) {

		/*echo "William";  
		die;*/

		$postData = $request->all();

		$validation = Validator::make($postData, [
			'email' => 'required'
		]);

		if($validation->fails())
			return response()->json(['success' => 0,'error' => $validation->errors()
		]);

		// check for registered user
		$user = User::where('email',$postData['email'])->first();

		if($user){
			
			// generate random string
			$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
			$length = 10;
			$charactersLength = strlen($characters);
			$randomString = '';
			for ($i = 0; $i < $length; $i++) {
				$randomString .= $characters[rand(0, $charactersLength - 1)];
			}
			$randomToken = $randomString;

			// save data in the password_resets
			$passwordReset = new PasswordReset;
			$passwordReset->email = $user->email;
			$passwordReset->token = $randomToken;
			$passwordReset->save();


			$resetPasswordLink = 'http://202.164.42.26:8282/castlesetup/password/reset'.'/'.$randomToken;

			// set data that has to be sent in the eamil
			/*$data = array(
				'email' => $player->channel_id,
				'token' => $randomToken,
				'link'  => $resetPasswordLink,
				'name'  => $player->username
			);*/

			// send mail //
			/*Mail::send('emails.password.email', ['data' => $data], function ($m) use($data) {
	            $m->from('raju@code-brew.com', 'Quiz');

	        $passwordMail = Mail::to($user->email)->send(new RegisterMail($user->name,$request->get('user_type'),'')); */

	        $email = "hello@gmail.com";

	        Mail::to($email)->send(new ForgotPasswordMail($resetPasswordLink,$user->name));
	        return response()->json(['success' => 1,'statuscode'=> 200,'data' => "Email sent successfully"
			]);
		} else {

			return response()->json(['success' => 0,'statuscode'=> 401,'error' => "User not found"
			]);
		}
	}



	/*
		** for the forgot password
	*/
	/*public function resetPassword(Request $request, $email, $token) {

		$data = array(
				'email' => $email,
				'token' => $token
			);
		// check in the password reset table
		$player = PasswordReset::where('email',$request['email'])
					->where('token',$request['token'])
					->first();
		if($player) {
			return view('emails.password.reset',['data' => $data]);
		} else {
			return view('emails.password.linkexpired');
		}			
	}
*/
	/*public function updatePassword(Request $request) {

		// check in the password reset table
		$player = PasswordReset::where('email',$request['email'])
					->where('token',$request['token'])
					->first();
		if($player){

			$getPlayer = Player::where('channel_id', $request['email'])->first();
			
			// update the password
			$updatePlayer = Player::find($getPlayer->id);
			$updatePlayer->password = Hash::make($request['password']);
			$updatePlayer->save();

			$deletedRows = PasswordReset::where('email', $request['email'])->delete();

			//echo "Your password has been changed successfully.";
			return view('emails.password.success');

		}else{
			return view('emails.password.linkexpired');
		}
		die;
		// check for the required entry in the pasword reset table 
	}*/

}
