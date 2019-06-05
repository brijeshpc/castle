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
use App\Wishlist;
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
					$categoriesFor = Product::where('product_for',"=",$postData['product_for'])
                    ->select('item_type')->groupBy('item_type')->take(3)->get();

					$allCategoriesFor = Product::select('item_type')->groupBy('item_type')->get();
		
					$categoryImages = array();

					if (!$categoriesFor->isEmpty()) { 
						$url = env('STORAGE_URL')."app/public/categories/";
						foreach($categoriesFor as $category){
							$categoryImages[] = array(
													"name" => ucfirst($category->item_type),
													"image" => $category->item_type .".png" );
						}
						return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $categoriesFor, 'url' => $url, 'all_categories' => $allCategoriesFor], 200);
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

	/**
     * list products according to product for and category type
     * @return [json] 
    */
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


	/**
     * get product detail
     * @return [json] 
    */
	public function productDetail(Request $request)
    {
		try{
			$postData = $request->all();

			$products = Product::where('id','=',$postData['product_id'])
			->get();

			if (!$products->isEmpty()) {
				return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $products], 200);
			} else {
				return Response(array('success' => 1, 'statuscode' => 500, 'error' => "No records found"),500);
			}
		} catch(\Exception $e){
			return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
		}
	}

	/**
     * get all categories
     * @return [json] 
    */
	public function categories(Request $request)
    {
 		try{
				$categories = Product::select('item_type')->groupBy('item_type')->get();
				if (!$categories->isEmpty()) { 
					return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $categories], 200);
				} else {
					return Response(array('success' => 1, 'statuscode' => 500, 'error' => "No records found"),500);
				}
			} catch (\Exception $e){
			return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
			}
	}

	/**
     * get all brands
     *
     * @return [json] 
    */
	public function brands(Request $request)
    {
 		try{
				$brands = Product::select('brand_name')
							->groupBy('brand_name')
							->where('product_for','=','exclusive')
							->get();

				if (!$brands->isEmpty()) { 
					return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $brands], 200);
				} else {
					return Response(array('success' => 1, 'statuscode' => 500, 'error' => "No records found"),500);
				}
			} catch (\Exception $e){
			return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
			}
	}

	/**
     * get all products for a category
     *
     * @return [json] 
    */
	public function categoryProducts(Request $request)
    {
 		try{
			$postData = $request->all();
			$brandArray = $postData["category_names"];
			$products = Product::whereIn('brand_name',$brandArray)
			->get();

			if (!$products->isEmpty()) {
				return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $products], 200);
			} else {
				return Response(array('success' => 1, 'statuscode' => 500, 'error' => "No records found"),500);
			}
		} catch(\Exception $e){
			return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
		}
	}

	/**
     * get all products for a brand
     *
     * @return [json] 
    */
	public function brandProducts(Request $request)
    {
 		try{
			$postData = $request->all();
			$brandArray = $postData["brand_names"];
			$products = Product::whereIn('brand_name',$brandArray)
			->get();

			if (!$products->isEmpty()) {
				return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $products], 200);
			} else {
				return Response(array('success' => 1, 'statuscode' => 500, 'error' => "No records found"),500);
			}
		} catch(\Exception $e){
			return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
		}
	}


	/**
     * add products to wishlist
     * @return [json] 
    */
	public function addWishlist(Request $request)
    {
    	$user = Auth::user();
    	if($user){
    		try{
		    		$postData = $request->all();

					if(isset($postData) && !empty($postData)){

						$validation = Validator::make($postData, [
							'product_id' => 'bail|required|max:255',
						]);

						if($validation->fails())
							return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
							], 401);

						$wishList = new Wishlist;

						$wishlistExist = Wishlist::where("product_id","=",$postData['product_id'])->get();


						if ($wishlistExist->isEmpty()) {
							
							$wishList->user_id = $user->id;
							$wishList->product_id = $postData['product_id'];

							 if($wishList->save()){
			                	return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $wishList],200);

				            } else {
				            	return response()->json(['success' => 0,'statuscode'=> 401,'error' => "Not added."
								], 401);
				            }
						} else{
							return response()->json(['success' => 0, 'statuscode' => 200, 'error' => "Already exists."],200);
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


   	/**
     * add products to wishlist
     * @return [json] 
    */
	public function removeWishlist(Request $request)
    {
    	
    	$user = Auth::user();
    	if($user){
    		try{
		    		$postData = $request->all();
		    		$userId = $user->id;

					if(isset($postData) && !empty($postData)){

						$validation = Validator::make($postData, [
							'product_id' => 'bail|required|max:255',
						]);

						if($validation->fails())
							return response()->json(['success' => 0,'statuscode'=> 401,'error' => $validation->errors()
							], 401);

						$deleteWistList = Wishlist::where('user_id','=', $userId)->where('product_id','=',$postData['product_id'])->delete();

						if($deleteWistList){
							return response()->json(['success' => 1, 'statuscode' => 200, 'data' => "Product removed from wishlist."],200);
						} else {
								return response()->json(['success' => 0, 'statuscode' => 200, 'data' => "Product did not get removed from wishlist."],200);
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

   	/**
     * list products according to product for and category type
     * @return [json] 
    */
	public function castleExclusive(Request $request)
    {
		try{
			$products = Product::where('product_for','=',"exclusive")
			->get();

			if (!$products->isEmpty()) {
				return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $products], 200);
			} else {
				return Response(array('success' => 1, 'statuscode' => 500, 'error' => "No records found"),500);
			}
		} catch(\Exception $e){
			return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
		}
	}


	/**
     * list products according to product for and category type
     * @return [json] 
    */
	/*public function exclusiveBrands(Request $request)
    {
		try{
			$products = Product::where('product_for','=',"exclusive")
			->get();

			if (!$products->isEmpty()) {
				return response()->json(['success' => 1, 'statuscode' => 200, 'data' => $products], 200);
			} else {
				return Response(array('success' => 1, 'statuscode' => 500, 'error' => "No records found"),500);
			}
		} catch(\Exception $e){
			return Response(array('success'=>0,'statuscode'=>500,'error'=>$e->getmessage()),500);
		}
	}*/



}



