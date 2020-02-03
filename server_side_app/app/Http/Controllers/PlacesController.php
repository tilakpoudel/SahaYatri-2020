<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
// use Validator;
use Illuminate\Support\Facades\Validator;
use App\Places;
use App\Category;

use Auth;

class PlacesController extends Controller
{
    public function __construct__(){
        return $this->middleware('auth');
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $places = Places::get();
        return view('admin.places.index')->with(compact('places'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        $categories = Category::get();
        return view('admin.places.create')->with(compact('categories'));
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
        // dd($request->all());
            $rules= [
            'name'=>'required',
            'address'=>'required',
            'category'=>'required',
            'description'=>'required',
        ];
        $validator = Validator::make($request->all(),$rules);
          $system_user_id = Auth::user()->id;
             // checkif the form has file as image
             $filename='';
            if($request->hasfile('image_path'))
            {
            $file = $request->file('image_path');
            $extension = $file->getClientOriginalExtension(); // getting image extension
            $filename =time().'.'.$extension;
            $file->move('uploads/places_photos/', $filename);
            }
            // store employee personal detail
            $palces = Places::create([
                'system_user_id'=>$system_user_id,
                'name'=>$request['name'],
                'address'=>$request['address'],
                'category'=>$request['category'],
                'description'=>$request['description'],
                'image_path'=>$filename,
           ]);
           return redirect()->route('places.index');
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
}
