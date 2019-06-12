<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Passport\HasApiTokens;
use Hash, DateTime, DB;
use Illuminate\Database\Eloquent\SoftDeletes;

class User extends Authenticatable
{
    use Notifiable;
    use SoftDeletes;
    use HasApiTokens, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password','access_token',
        'password',
        'facebook_id',
        'gmail_id',
        'timezone'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];


    public static function createNewUser($data)
    {       
            //echo "<pre>"; print_r($data); die;

            $user = new User();
            $user->email = isset($data['email']) ? $data['email'] : ''; 
            $user->password = isset($data['password']) ? Hash::make($data['password']) : '';
            $user->facebook_id = isset($data['facebook_id']) ? $data['facebook_id'] : '';
            $user->gmail_id = isset($data['gmail_id']) ? $data['gmail_id'] : '';
            $user->timezone = new \DateTime;
            $user->type = 2;
            $user->avatar = isset($data['photo']) ? $data['photo'] : ''; 
            $user->first_name = isset($data['name']) ? $data['name'] : ''; 
            $user->created_at = new \DateTime;
            $user->updated_at = new \DateTime;

            $userData = array();

            if($user->save()){

                $accessToken =  $user->createToken('MyApp')->accessToken; 
                $userData = array('token' => $accessToken, 'user' => $user);
            }
            return $userData;
    }

    public function updatePassword(Request $request) {

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
            //return view('emails.password.success');

        }else{
            //return view('emails.password.linkexpired');
        }
        die;
        // check for the required entry in the pasword reset table 
    }

}
