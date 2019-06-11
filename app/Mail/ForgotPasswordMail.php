<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class ForgotPasswordMail extends Mailable
{
    use Queueable, SerializesModels;
    public $url;
    public $user_name;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($url,$user_name)
    {
        $this->url = $url;
        $this->user_name = $user_name;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $data['url'] = $this->url;
        $data['user_name'] = "William";


        return $this->subject('Password Recovery request on Castle')->view('email.forgot_password',$data);
    }
}
