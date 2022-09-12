<?php

namespace App\Http\Controllers;

use App\Client;
use App\ClientProduct;
use App\Department;
use App\Product;
use Illuminate\Http\Request;

class ReportController extends Controller
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
    public function product_report($id)
    {
         $data = Product::where('id',$id)->with('item','brand','clientproduct','seller','wd')->first();
        
         $i = 0;
         $a = [];
         foreach($data->clientproduct as $d){
            $c = Client::where('id',$data->clientproduct[$i]->id)->with('department')->first();            
            array_push($a,$c->department);
            $i++;
         }
       
        return response()->json([
            'data' => $data,
            'department'=> $a
        ], 200);
    }

    public function client_report($id)
    {
       return $data = Client::where('id',$id)->with('designation','department','productclient')->first();
    }

    public function client_current_product($id)
    {
       
        if($id){
        //    return Client::where('id',$id)->with('productclient')->first();
        return ClientProduct::where('client_id',$id)->where('activeStatus',1)->with('product')->get();
        }else{
            return 'Fake Id';
        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
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
