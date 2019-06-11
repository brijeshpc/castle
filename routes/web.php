<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::post('/password/reset/{token}', function () {
    return view('admin.reset-password');
});

Route::get('/password/reset/{token}', 'UserController@resetPassword');

Route::post('/update-password', 'UserController@updatePassword');


//Route::get('', 'ProductController@index');

Route::group(array('middleware' => 'auth'), function() {
		Route::get('/dashboard', 'DashboardController@show');
		Route::get('admin/dashboard', 'HomeController@index')->name('home');
		Route::get('import-export', 'ProductController@importExport');
		Route::get('downloadExcel/{type}', 'ProductController@downloadExcel');
		Route::post('importExcel', 'ProductController@importExcel');
		Route::get('slider', 'SliderController@index');
		Route::get('user', 'UserController@index');
		Route::get('product', 'ProductController@index');
		Route::post('image-gallery', 'SliderController@upload');
		Route::delete('image-gallery/{id}', 'SliderController@destroy');
		Route::post('update-profile', 'UserController@updateProfile');
		Route::get('edit-profile/{id}', 'UserController@editProfile');
		Route::get('delete-profile/{id}', 'UserController@deleteProfile');
		
	});

Route::get('logout', 'Auth\LoginController@logout', function () {
				return abort(404);
    	});



