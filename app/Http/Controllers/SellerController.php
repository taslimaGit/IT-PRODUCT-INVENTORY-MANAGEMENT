<?php

namespace App\Http\Controllers;

use App\Product;
use App\Seller;
use Illuminate\Http\Request;

class SellerController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        return Seller::orderBy('id','desc')->paginate($request->total);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $this->validate($request,[
            'sellerName'=>'required|unique:sellers',
        ]);

        return Seller::create([
            'sellerName'=> $request->sellerName,
        ]);
    }

    public function allSeller()
    {
        return Seller::all();
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
        $this->validate($request,[
            'sellerName'=>'required|unique:sellers',
        ]);

        Seller::where('id', $request->id)->update([
            'sellerName' => $request->sellerName
        ]);

        return response()->json([
            'sellerName' => $request->sellerName
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
        
        $count = Product::where('seller_id',$request->id)->count();
        if($count<1){
            return Seller::where('id', $request->id)->delete();
        }else{
            return response()->json([
                'msg' => "Sorry Seller Have Products"
            ], 423);
        }
    }
}
