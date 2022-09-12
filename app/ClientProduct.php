<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ClientProduct extends Model
{
    protected $fillable = ['client_id','product_id'];

    public function product()
    {
        return $this->belongsTo('App\Product','product_id','id');
    }
}
