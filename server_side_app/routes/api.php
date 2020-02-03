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

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

//api route for places
Route::get('places','ApiController@get_all_places');
Route::get('place/{id}','ApiController@view_place_info');
Route::get('places/popular','ApiController@sort_by_popular_places');

//api route for guides
Route::get('guides','ApiController@get_all_guides');
Route::get('guide/{id}','ApiController@view_guides_info');
// Route::get('guides/popular','ApiController@popular_guides');
Route::get('guides/{address}','ApiController@get_guides_by_address');


//api routes for categories
Route::get('categories','ApiController@get_all_categories');
Route::get('places/{category_id}','ApiController@get_places_by_category');

Route::post('bookings/store','ApiController@store_booking');


Route::get('all_locations','ApiController@get_all_locations');
Route::get('location/{id}','ApiController@view_location_info');

    // protected $fillable = ['tourist_id','travel_guide_id','local_guide_id','start_location','destination_location','start_day','end_day'];
