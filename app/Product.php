<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = ['productName','seller_id', 'location','item_id', 'brand_id', 'serialNumber', 'attribute', 'warranty', 'warranty_id', 'purcessDate','created_by','updated_by'];

    public function item()
    {
        return $this->belongsTo('App\Item');
    }

    public function brand()
    {
        return $this->belongsTo('App\Brand');
    }

    public function seller()
    {
        return $this->belongsTo('App\Seller');
    }
    public function wd()
    {
        return $this->belongsTo('App\Warranty','warranty_id');
    }

    public function clientproduct()
    {
        return $this->belongsToMany('App\Client','client_products')->withPivot(['startDate','endDate','activeStatus']);
    }
}
