<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/



Route::group(['prefix'=>'v1','namespace'=>'Api'],function () {

	Route::post('/signup', ['as'=>'signup', 'uses'=>'UserController@userSignUp']);
	Route::post('/login', ['as'=>'user_login', 'uses'=>'UserController@userLogin']);
	Route::get('/token-expired', ['as'=>'token-expired', 'uses'=>'UserController@tokenExpired']);
	Route::get('/update-profile', ['as'=>'details', 'uses'=>'UserController@updateProfile']);

	// api routes for Product Controller
	// Route::get('/list-sections', ['as'=>'list-sections', 'uses'=>'ProductController@listSections']);
	Route::post('/section-categories', ['as'=>'section-categories', 'uses'=>'ProductController@sectionCategories']);
	Route::get('/slider-images', ['as'=>'slider-images', 'uses'=>'ProductController@sliderImages']);

	Route::post('/list-products', ['as'=>'list-products', 'uses'=>'ProductController@listProducts']);
});

Route::group(['prefix'=>'v1','namespace'=>'Api', 'middleware' => ['apiauth:api']],function () {
	// api routes for User Controller
	Route::post('/update-profile', ['as'=>'update-profile', 'uses'=>'UserController@updateProfile']);
	Route::post('/get-profile', ['as'=>'get-profile', 'uses'=>'UserController@getProfile']);
	Route::post('/avatar', ['as'=>'avatar', 'uses'=>'UserController@avatar']);
});

Route::middleware('auth:api')->get('/user', function (Request $request) {
});




