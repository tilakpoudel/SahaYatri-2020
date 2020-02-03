<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Location;
use Response;
use App\RatingReview;
use App\Places;
use App\Guides;
use App\Category;
use Validator;
use App\Booking;
use DB;
use Transaction;

class ApiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function get_all_locations(){
        return Response::json(Location::get(),200);
    }

    public function view_location_info($id){
        $location_info = Location::find($id);
        if(is_null($location_info)){
            return Response::json(["message"=>":( oops NO data found!!!"],404);
        }
        return Response::json([$location_info],200);
    }

    
    public function get_all_places(){
        return Response::json(Places::get(),200);
    }

    public function view_place_info($id){
        $place_info = Places::find($id);
        if(is_null($place_info)){
            return Response::json(["message"=>":( oops NO data found!!!"],404);
        }
        return Response::json([$place_info],200);
    }

    public function sort_by_popular_places(){
        $palces = Places::orderBy('visits','desc')->limit(10)->get();
        return Response::json($palces,201);
    }

    public function get_all_guides(){
        return Response::json(Guides::get(),200);
    }

    public function view_guides_info($id){
        $guide_info = Guides::find($id);
        if(is_null($guide_info)){
            return Response::json(["message"=>":( oops NO data found1111!!!"],404);
        }
        return Response::json([$guide_info],200);
    }

    public function popular_guides(){
        $popular_guides = Guides::orderBy('booked_number','desc')->limit(3)->get();
        // dd($popular_guides);
        return Response::json($popular_guides,201);
    }

    public function get_guides_by_address($address){
        $guides_by_address = Guides::where('address', 'like', '%' . $address . '%')
                            // ->where('status','free')
                            ->orderBy('rating','desc')->get();
        // dd($guides_by_address);
        return Response::json($guides_by_address,201);
    }

    public function get_all_categories(){
        return Response::json(Category::get(),200);
    }

    public function get_places_by_category($category_id){
        $places= Places::where('category',$category_id)->orderBy('visits','desc')->limit(10)->get();
        if(is_null($places)){
            return Response::json(["message"=>":( oops Records not found!!!"],404);
        }
        return Response::json($places, 200);
        // return Response::json(Category::get(),200);
    }

      public function store_booking(Request $request)
    {
        //
        // $rules= [
        //     'tourist_name'=>'required',
        //     'travel_guide_id'=>'required',
        //     'start_location'=>'required',
        //     'destination_location'=>'required',
        //     'start_day'=>'required',
        //     'end_day'=>'required'
        // ];
        // $validator = Validator::make($request->all(),$rules);
        // if($validator->fails()){
        //     return Response::json($validator->errors(),400);
        // }
        // $bookings = Booking::create($request->all());


        DB::transaction(function() use ($request){
            // dd($request->all());
            // return Response::json("No data",201);

            $bookings = Booking::create($request->all());

            $guide_id = $request->travel_guide_id;
            Guides::where('id', $guide_id)
                    ->update([
                        // 'system_user_id'=>$system_user_id,
                        // 'booked_number' => $updated_booked_number,
                        'status' => 'booked',
                    ]);

            // Places::where('id', $place_id)
            // ->update([
            //     // 'system_user_id'=>$system_user_id,
            //     'visits' => $updated_visit_number,
            // ]);
        });
    }

}
