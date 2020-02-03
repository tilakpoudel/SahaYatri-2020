<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Places extends Model
{
    //
    // protected $fillable =[];
    protected $guarded = [];

    public function categories(){
        return $this->hasMany('App\Category','id','category');
    }
}
