<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
    //
    protected $fillable = ['tourist_id','tourist_name','email','phone_number',
        'country','travel_guide_id',
        'start_location','destination_location','start_day','end_day'];

    public function guide(){
        return $this->hasMany('App\Guides','id','travel_guide_id');
    }

    
    public function visit_area(){
        return $this->hasMany('App\Places','id','destination_location');
    }
}
