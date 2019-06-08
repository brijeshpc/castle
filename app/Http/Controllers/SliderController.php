<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Slider;
use Maatwebsite\Excel\Facades\Excel;

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
     * Upload image function
     *
     * @return \Illuminate\Http\Response
     */
    public function upload(Request $request)
    {
        
        $this->validate($request, [
            'page'  => 'required',
            'title' => 'required',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
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
