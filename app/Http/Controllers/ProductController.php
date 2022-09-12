<?php

namespace App\Http\Controllers;

use App\Brand;
use App\Item;
use App\Product;
use App\ProductAttribute;
use App\Seller;
use App\Warranty;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        return Product::where('productStatus',1)->where('deletionStatus',0)->orderBy('id','desc')->with('item','brand')->paginate($request->total);
    }
    public function get_all_attribute_product()
    {
       return ProductAttribute::all();
    }

    public function get_all_seller_product()
    {        
       return Seller::select('id','sellerName')->get();
    }

    public function get_all_item_product()
    {        
       return Item::all();
    }

    public function get_all_brand_product()
    {
       return Brand::all();
    }

    public function get_all_period_product()
    {
        return Warranty::all();
    }

    public function allProduct()
    {
      return Product::where('productStatus',1)->where('deletionStatus',0)->orderBy('id','desc')->with('item','brand')->get();
    }
    public function create(Request $request)
    {

       $this->validate($request,[
           'productName' => 'required',
           'seller_id' => 'required',
           'item_id' => 'required',
           'brand_id' => 'required',
           'purcessDate' => 'required',
       ]);
        if(!$request->warranty){
            $request->warranty = 0;
        }else{
            $request->warranty = 1;
        }
        $user = Auth::user();

        
        
       DB::beginTransaction();
        try {
           
$data = Product::create([
        'productName' => $request->productName,
        'seller_id' => $request->seller_id,
        'location' => $request->location,
        'item_id' => $request->item_id,
        'brand_id' => $request->brand_id,
        'attribute' => $request->attribute,
        'serialNumber' => $request->serialNumber,
        'purcessDate' => $request->purcessDate,
        'warranty' => $request->warranty,
        'warranty_id' => $request->warranty_id,
        'created_by'=>$user->fullName
       ]);

       $raw_id = 1000000;
       $raw_id += $data->id;
       $product_id = 'Txf' . $raw_id;
       Product::where('id', $data->id)->update([
           'product_id' => $product_id
       ]);

       $item = $data->item;
       $brand = $data->brand;
       $seller = $data->seller;
       DB::commit();
       return response()->json([
        'id' => $data->id,
        'product_id'=>$product_id,
        'productName' => $request->productName,
        'location' => $request->location,
        'seller' => $seller,
        'item' => $item,
        'brand' => $brand,
        'attribute' => $request->attribute,
        'serialNumber' => $request->serialNumber,
        'purcessDate' => $request->purcessDate,
        'warranty' => $request->warranty,
        'warranty_id' => $request->warranty_id,
        'assignStatus' => $data->assignStatus
    ], 201);
        }catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['msg' => 'not done'], 401);
        }
    }

    public function update(Request $request)
    {
        $this->validate($request,[
            'id'=>'required',
            'seller_id' => 'required',
            'location' => 'required',
            'item_id' => 'required',
            'brand_id' => 'required',
            'purcessDate' => 'required',
        ]);

        if(!$request->warranty){
            $request->warranty = 0;
        }else{
            $request->warranty = 1;
        }
       
        $user = Auth::user();
         Product::where('id',$request->id)->update([
            'productName' => $request->productName,
            'seller_id'=> $request->seller_id,
            'location'=> $request->location,
            'item_id' => $request->item_id,
            'brand_id' => $request->brand_id,
            'attribute' => $request->attribute,
            'serialNumber' => $request->serialNumber,
            'purcessDate' => $request->purcessDate,
            'warranty' => $request->warranty,
            'warranty_id' => $request->warranty_id,
            'updated_by'=>$user->fullName
           ]);

           return response()->json([
            'id' => $request->id,
            'productName' => $request->productName,
            'seller_id'=>$request->seller_id,
            'location' => $request->location,
            'item_id' => $request->item_id,
            'brand_id' => $request->brand_id,
            'attribute' => $request->attribute,
            'serialNumber' => $request->serialNumber,
            'purcessDate' => $request->purcessDate,
            'warranty' => $request->warranty,
            'warranty_id' => $request->warranty_id,
        ], 200);
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

   
    public function destroy(Request $request)
    {
        $this->validate($request, [
            'id' => 'required',
        ]);
        $result = product::where('id', $request->id)->where('assignStatus',0)->update([
            'deletionStatus' => 1
        ]);
        if($result == 1){
            return response()->json([
            'id' => $request->id
        ], 200);
        }else{
            return response()->json([
                'msg' => "Sorry Product Have Client"
            ], 423);
        }
        
    }
}
