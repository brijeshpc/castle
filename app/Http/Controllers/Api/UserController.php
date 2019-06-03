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

							$postData['password'] = "asdsduiuwpoocmxnc";							
							if(isset($postData['gmail_id']) && !empty($postData['gmail_id'])){
								$validation = Validator::make($postData, [
									'gmail_id' => 'bail|required|unique:users|max:255',
								]);

								if($validation->fails())
									return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
								], 401);
							}
						} else if($postData['signup_by'] == "facebook_id"){

								$postData['password'] = "asdsduiuwpoocmxnc";	

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
    					if($postData['login_by'] == "email")
						{

							$validation = Validator::make($postData, [
								'email' => 'bail|required|max:255',
								'password' =>'bail|min:7|required_without_all:facebook_id,gmail_id',
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
			            $user->zip = isset($postData['zip']) ? $postData['zip'] : '';

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

    public function avatar1(Request $request) {

    	//echo "avatar"; die;
		$this->validate($request, [
			'avatar' => 'nullable|image|max:' . config('misc.avatar.filesize')
		]);

		//$player = Auth::guard('api')->user();

		// new avatar uploaded
		if ($file = $request->file('avatar')) {

			list($w, $h) = explode('x', config('misc.avatar.resize'));

			$path = storage_path('app/tmp') . DIRECTORY_SEPARATOR . $player->id . '-avatar.' . $file->extension();

			$image = Image::make($file)->fit($w, $h, function ($constraint) {
				$constraint->upsize();
			});
			$image->save($path);

			Storage::put($player->id . '-avatar.jpg', file_get_contents($path));
			Storage::disk('local')->delete('tmp/' . $player->id . '-avatar.' . $file->extension());

			$player->avatar = 1;
		}
		// user wants to remove avatar
		else {
			if ($player->avatar == 1) {
				Storage::delete($player->id . '-avatar.jpg');
			}
			$player->avatar = null;
		}

		$player->save();
		
		// re-create token, because username has to be presented in it
		if (!$token = Auth::guard('api')->claims([
					'id' => $player->id,
					'username' => $player->username,
					'avatar' => $player->avatarUrl,
				])->login($player)) {

			return response()->json(['errors' => [__('api.error-login-failed')]], 422);
		}

		return response()->json(['token' => $token, 'avatar' => $player->avatarUrl]);
	}

	/*public function avatar(Request $request) {
	 	$user = Auth::user();
    	$postData = $request->all();

	 	if ($file = $postData['avatar']) {
			$fileName = "avatar_".$user->id;
			$data = $postData['avatar'];
			$data = base64_decode(preg_replace('#^data:image/\w+;base64,#i', '', $data));
			$upload_success = Storage::disk('public')->put('avatars/' . $fileName, $data);
			return response()->json(['avatar' => "avatar uploaded successfully."]);
		}

	}*/

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
			            $user->avatar = isset($postData['avatar']) ? $imageName : '';
			            if($user->save()){
				            	$url = env('STORAGE_URL')."app/public/avatars/";
			                	return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $user, 'url' => $url], 200);
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
			            return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $user, 'url' => $url], 200);
			        }

	            	return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Updation failed"
					], 401);

		   	}  catch(\Exception $e){
				return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
  		 	}
    	}
    }

}
