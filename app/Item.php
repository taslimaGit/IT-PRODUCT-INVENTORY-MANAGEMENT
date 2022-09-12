<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Item extends Model
{
    protected $fillable = ['itemName'];

    // public function product()
    // {
    //    return $this->belongsTo('App\Product','id','item_id'); 
    // }
}
