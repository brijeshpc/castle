<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Slider;
use App\User;
use App\PasswordReset;
use Illuminate\Support\Facades\Validator;
use Session;
use Hash;
use Illuminate\Support\Facades\Redirect;


class UserController extends Controller
{

    /**
     * Create a new controller instance.
     *
     * @return void
     */
   /* public function __construct()
    {
        $this->middleware('auth');
    }*/

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {

        $users = User::get();
        return view('admin/user',compact('users'));
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function editProfile(Request $request, $userId = null)
    {
        $user = User::where('id','=',$userId)->get();
        $user = User::find($userId);
        return view('admin/updateprofile',compact('user'));
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function deleteProfile(Request $request, $userId = null)
    {
        $user = User::find($userId)->delete();
        $users = User::get();
        return view('admin/user',compact('users'));
    }



    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function updateProfile(Request $request)
    {

        $this->validate($request, [
            'first_name'  => 'required|alpha',
            'last_name' => 'required|alpha',
            'zip'  => 'required|numeric',
            'city' => 'required|alpha',
            'state'  => 'required|alpha',
            'gender' => 'required|alpha'
        ]);

        $postData = $request->all();
        if(isset($postData) && !empty($postData)){
            $userId = $postData['id'];
            $user = User::find($userId);
            $user->first_name = $postData['first_name'];
            $user->last_name =  $postData['last_name'];
            $user->zip =  $postData['zip'];
            $user->city =  $postData['city'];
            $user->state =  $postData['state'];
            $user->gender =  $postData['gender'];
            $user->save();
        }
        $users = User::get();
        return view('admin/user',compact('users'));
    }



    public function resetPassword(Request $request, $token)
    {

        return view('admin/reset-password')->with('token', $token);

        /*$player = PasswordReset::where('email',$request['email'])
                    ->where('token',$request['token'])
                    ->first();
        if($player) {
            return view('emails.password.reset',['data' => $data]);
        } else {
            return view('emails.password.linkexpired');
        } */          
    }


    public function updatePassword(Request $request)
    {
       $validator = Validator::make($request->all(), [
            'password' => 'required|same:confirm_password'
       ]);
        
       if ($validator->fails()) {
            return Redirect::to('/password/reset/lIJDEokos2')->withErrors($validator);
       }  else {
            $passwordReset = PasswordReset::where('token',$request['token_value'])
                    ->get();
            if (!$passwordReset->isEmpty()) { 
                    $getuser = User::where('email', $passwordReset[0]->email)->first();
                    // update the password
                    $updateUser = User::find($getuser->id);
                    $updateUser->password = Hash::make($request['password']);
                    $updateUser->save();
                    $deletedRows = PasswordReset::where('token', $request['token_value'])->delete();
                    return view('admin.password-changed');
            } else {
                 return view('admin.password-link-expired');
            }
       }
      
    }


}
