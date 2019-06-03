<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Slider;

class HomeController extends Controller
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
        //echo "Will"; die;
        //echo url("/posts/"); die;
        //$images = Slider::get();
        //echo "<pre>"; print_r($images); die;
        //$images = Slider::get();
        //return view('slider',compact('images'));
        return view('home');
    }
}
