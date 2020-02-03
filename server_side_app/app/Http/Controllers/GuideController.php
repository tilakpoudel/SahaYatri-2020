<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Guides;
use Illuminate\Support\Facades\Validator;
use Auth;

class GuideController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $guides = Guides::get();
        return view('admin.guides.index')->with(compact('guides'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        return view('admin.guides.create');
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
            $file->move('uploads/guides_photos/', $filename);
            }
            // store employee personal detail
            $guides = Guides::create([
                'system_user_id'=>$system_user_id,
                'name'=>$request['name'],
                'address'=>$request['address'],
                'contact_no'=>$request['contact_no'],
                'email'=>$request['email'],
                'national_id_no'=>$request['national_id_no'],
                'national_id_issue_district'=>$request['national_id_issue_district'],
                'image_path'=>$filename,
           ]);
           return redirect()->route('guides.index');

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
