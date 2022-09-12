<?php

namespace App\Http\Controllers;

use App\ProductAttribute;
use Illuminate\Http\Request;

class ProductAttributeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        return ProductAttribute::orderBy('id','desc')->paginate($request->total);
        
    }
    public function allAttribute()
    {
       return ProductAttribute::all();
    }

    
    public function create(Request $request)
    {
        $this->validate($request, [
            'attributeName' => 'required|unique:product_attributes'
        ]);
        return ProductAttribute::create([
            'attributeName' => $request->attributeName
        ]);
    }
    public function update(Request $request)
    {
        $this->validate($request, [
            'attributeName' => 'required|unique:product_attributes'
        ]);
        ProductAttribute::where('id', $request->id)->update([
            'attributeName' => $request->attributeName
        ]);

        return response()->json([
            'attributeName' => $request->attributeName
        ]);
    }

    public function destroy(Request $request)
    {
        $this->validate($request, [
            'id' => 'required'
        ]);
        return ProductAttribute::where('id', $request->id)->delete();
    }

    
    public function store(Request $request)
    {
        //
    }

    
    public function show($id)
    {
        //
    }

    
    public function edit($id)
    {
        //
    }

    


    
  
}
