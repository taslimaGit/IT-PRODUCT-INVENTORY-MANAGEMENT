<?php

namespace App\Http\Controllers;

use App\Client;
use App\ClientProduct;
use App\Product;
use Illuminate\Auth\Events\Validated;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ClientProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    public function get_product_assign()
    {
      return Product::where('assignStatus',0)->where('deletionStatus',0)->where('productStatus',1)->get();
    }
public function get_client_assign()
{
    return Client::where('activeStatus',1)->where('deletionStatus',0)->get();
}
  
    public function create(Request $request)
    {
       $this->validate($request,[
           'client_id'=>'required',
           'product_id'=>'required'
       ]);
       date_default_timezone_set('Asia/Dhaka');
       $date = date('d/m/Y h:i a', time());

       $client = $request->client_id;
       $products = $request->product_id;
       $clientProduct = [];
       DB::beginTransaction();
       try{
           foreach($products as $product)
           {
               array_push($clientProduct,['client_id'=>$client, 'product_id'=>$product, 'startDate'=>$date]);
           }
           ClientProduct::insert($clientProduct);
           Product::whereIn('id',$products)->update([
               'assignStatus'=>1
           ]);
        DB::commit();
        return response()->json(['msg' => 'Done'], 201);
       }catch(\Exception $e){
        DB::rollback();
        return response()->json(['msg' => 'not done'], 401);
       }
    }

    public function client_product_dassign(Request $request)
    {
        date_default_timezone_set('Asia/Dhaka');
       $date = date('d/m/Y h:i a', time());

       DB::beginTransaction();
        try{
            ClientProduct::where('id',$request->clientProductId)->update([
                "endDate"=>$date,
                "activeStatus"=>0
            ]);
     
            Product::where('id',$request->productID)->update([
                "assignStatus"=>0
            ]);
            DB::commit();
            return response()->json(['msg' => 'Done'], 201);
        }catch(\Exception $e){
            DB::rollback();
            return response()->json(['msg' => 'not done'], 401);
        }
      

    }

   
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
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
