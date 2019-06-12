<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Slider;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Redirect;

class SliderController extends Controller
{
    /**
     * Listing Of images gallery
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $images = Slider::get();
        //echo "<pre>"; print_r($images); die;
        return view('admin/slider',compact('images'));
    }

    /**
     * Listing Of images gallery
     *
     * @return \Illuminate\Http\Response
     */
    public function defaultGallery()
    {
        $images = Slider::get();
        return view('view-gallery',compact('images'));
    }




    /**
     * Upload image function
     *
     * @return \Illuminate\Http\Response
     */
    public function upload(Request $request)
    {
        
        $this->validate($request, [
            'page'  => 'required',
            'title' => 'required',
            //'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048|dimensions:min_width=650,min_height=360',
        ]);

        $input['image'] = time().'.'.$request->image->getClientOriginalExtension();
        $request->image->move(public_path('images'), $input['image']);

        $input['title'] = $request->title;
        $input['page'] = $request->page;

        Slider::create($input);
        return back()
            ->with('success','Image Uploaded successfully.');
    }

    /**
     * Upload image function
     *
     * @return \Illuminate\Http\Response
     */
    public function viewGallery(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'select_page'  => 'required',
        ]);

        if ($validator->fails()) {
            return Redirect::to('/slider')->withErrors($validator);
        } 

        $postData = $request->all();

        $images = Slider::where('page','=',$postData['select_page'])->get();
        //echo "<pre>"; print_r($images); die;
        return view('admin/slider',compact('images'));

        $input['image'] = time().'.'.$request->image->getClientOriginalExtension();
        $request->image->move(public_path('images'), $input['image']);

        $input['title'] = $request->title;
        $input['page'] = $request->page;

        Slider::create($input);
        return back()
            ->with('success','Image Uploaded successfully.');
    }


    /**
     * Remove Image function
     *
     * @return \Illuminate\Http\Response
    */
    public function destroy($id)
    {
        Slider::find($id)->delete();
        return back()
            ->with('success','Image removed successfully.');    
    }

}
