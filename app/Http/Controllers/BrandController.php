<?php

namespace App\Http\Controllers;

use App\Brand;
use App\Product;
use Illuminate\Http\Request;

class BrandController extends Controller
{
    public function index(Request $request)
    {
        return Brand::orderBy('id', 'desc')->paginate($request->total);
    }
    public function allBrand()
    {
        return Brand::all();
    }

    public function create(Request $request)
    {
        $this->validate($request, [
            'brandName' => 'required|unique:brands'
        ]);
        return Brand::create([
            'brandName' => $request->brandName
        ]);
    }

    public function update(Request $request)
    {
        $this->validate($request, [
            'brandName' => 'required|unique:brands'
        ]);
        Brand::where('id', $request->id)->update([
            'brandName' => $request->brandName
        ]);

        return response()->json([
            'brandName' => $request->brandName
        ]);
    }

    public function destroy(Request $request)
    {
        $this->validate($request, [
            'id' => 'required'
        ]);

        $count = Product::where('brand_id',$request->id)->count();
        if($count<1){
            return Brand::where('id', $request->id)->delete();
        }else{
            return response()->json([
                'msg' => "Sorry Brand Have Products"
            ], 423);
        }
        
    }



}
