<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Slider;
use App\User;

class UserController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

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
    public function updateProfile(Request $request)
    {
        $postData = $request->all();
        if(isset($postData) && !empty($postData)){
            $userId = $postData['id'];
            $user = User::find($userId);
            $user->first_name = $postData['first_name'];
            $user->last_name =  $postData['last_name'];
            $user->zip =  $postData['zip'];
            $user->city =  $postData['city'];
            $user->state =  $postData['state'];
            $user->save();
        }
        $users = User::get();
        return view('admin/user',compact('users'));
    }



}
