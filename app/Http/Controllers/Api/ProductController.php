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
use App\Product;
use Illuminate\Support\Facades\Storage;


/*use App\Models\Admin;
use App\Models\Category;
use App\Models\User;
use App\Models\UserAddress;
use App\Models\UserNotification;
use App\Models\Product;
use App\Models\ProductView;
use App\Models\ProductLike;
use App\Models\ProductImage;
use App\Models\ProductFilterValue;*/

class ProductController extends Controller
{
	////////////////////////  List Product    ///////////////////////////

	/**
     * get all sections on home page
     *
     * @return [json] 
    */
    public function listSections(Request $request)
    {
		/*echo "Sections For";
		die;*/
		$user = Auth::user();
		
		if($user){	
			try{
				$sections = Product::distinct()->get(['product_for']);
				$allSections = array();
				if (!$sections->isEmpty()) {
					foreach($sections as $value){
						$allSections[] = $value->product_for;
					}
					return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $allSections], 200);
				} else {
					return response()->json(['success' => 1, 'statuscode' => 200, 'data' => "No records found"], 200);
				}
			} catch(\Exception $e){
				return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
			}
		}
	}

	/**
     * get all sections on home page
     *
     * @return [json] 
    */
    public function sliderImages(Request $request)
    {
		try{
			$sliderImages = array(
								"slide_1.jpg",
								"slide_2.jpg",
								"slide_3.jpg",
							);
			if (!empty($sliderImages)) {
				$url = env('STORAGE_URL')."app/public/slides/";
				return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $sliderImages, 'url' => $url], 200);
			} else {
				return Response(array('success' => 1, 'statuscode' => 500, 'error' => "No records found"),500);
			}
		} catch(\Exception $e){
			return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
		}
	}



	/**
     * get all section categories on home page
     *
     * @return [json] 
    */
	public function sectionCategories(Request $request)
    {
 		try{
				$postData = $request->all();

	 			if (isset($postData) && !empty($postData)) {

	 				$validation = Validator::make($postData, [
						'product_for' => 'required'
					]);

					if($validation->fails())
						return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
						], 401);
					//$categoriesFor = Product::where('product_for',$postData['product_for'])
									//->distinct('item_type')->get();
					$categoriesFor = Product::where('product_for',"=",$postData['product_for'])
                    ->select('item_type')->groupBy('item_type')->get();

                    $allCategoriesFor = Product::where('product_for',"=",$postData['product_for'])
                    ->select('item_type')->groupBy('item_type')->get();
				
					$categoryImages = array();

					if (!$categoriesFor->isEmpty()) { 
						$url = env('STORAGE_URL')."app/public/categories/";
						foreach($categoriesFor as $category){
							$categoryImages[] = array(
													"name" => ucfirst($category->item_type),
													"image" => $category->item_type .".png" );
						}
						return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $categoriesFor, 'url' => $url], 200);
					} else {
						return Response(array('success' => 1, 'statuscode' => 500, 'error' => "No records found"),500);
					}
	 			} else {
	 				return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Required values are not set" 
						], 401);
	 			}

		} catch (\Exception $e){
			return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
		}
	}


	public function listProducts(Request $request)
    {
		try{
			$postData = $request->all();
			$products = Product::where('product_for','=',$postData['product_for'])
			->where('item_type','=',$postData['item_type'])
			->get();

			if (!$products->isEmpty()) {
				/*foreach($sections as $value){
					$allSections[] = $value->product_for;
				}*/
				return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $products], 200);
			} else {
				return Response(array('success' => 1, 'statuscode' => 500, 'error' => "No records found"),500);
			}
		} catch(\Exception $e){
			return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
		}
	}


}



