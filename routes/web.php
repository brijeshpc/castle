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

Route::get('/home', 'HomeController@index')->name('home');

Route::get('import-export', 'ProductController@importExport');
Route::get('downloadExcel/{type}', 'ProductController@downloadExcel');
Route::post('importExcel', 'ProductController@importExcel');

Route::get('slider', 'SliderController@index');
Route::post('image-gallery', 'SliderController@upload');
Route::delete('image-gallery/{id}', 'SliderController@destroy');


