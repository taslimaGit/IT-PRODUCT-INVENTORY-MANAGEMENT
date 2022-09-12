<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Client extends Model
{
    protected $fillable = ['clientName','department_id','designation_id','phoneNo'];
    public function designation()
    {
        return $this->belongsTo('App\Designation')->select('id','designationName');
    }
    public function department()
    {
        return $this->belongsTo('App\Department')->select('id','departmentName');
    }
    public function productclient()
    {
        return $this->belongsToMany('App\Product','client_products')->withPivot(['startDate','endDate','activeStatus']);
    }
}
