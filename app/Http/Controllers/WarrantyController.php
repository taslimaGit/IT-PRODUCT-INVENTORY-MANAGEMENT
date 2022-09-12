<?php

namespace App\Http\Controllers;

use App\Product;
use App\Warranty;
use Illuminate\Http\Request;

class WarrantyController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        return Warranty::orderBy('id','desc')->paginate($request->total);
    }
    public function allPeriod(){
        return Warranty::all();
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
       $this->validate($request,[
           'periodTime' => 'required|unique:warranties'
       ]);
      return Warranty::create([
          'periodTime'=>$request->periodTime
       ]);
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
    public function update(Request $request)
    {
        $this->validate($request, [
            'periodTime' => 'required|unique:warranties'
        ]);
        Warranty::where('id', $request->id)->update([
            'periodTime' => $request->periodTime
        ]);

        return response()->json([
            'periodTime' => $request->periodTime
        ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request)
    {
        $this->validate($request, [
            'id' => 'required'
        ]);
        
        $count = Product::where('warranty_id',$request->id)->count();
        if($count<1){
            return Warranty::where('id', $request->id)->delete();
        }else{
            return response()->json([
                'msg' => "Sorry Warranty Have Products"
            ], 423);
        }

    }
}
