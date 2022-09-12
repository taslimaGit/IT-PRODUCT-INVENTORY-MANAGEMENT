<?php

namespace App\Http\Controllers;

use App\Item;
use App\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ItemController extends Controller
{
    
  
    public function index(Request $request)
    {
       return Item::orderBy('id','desc')->paginate($request->total);
    }
    public function allItem(){
        return Item::all();
    }

   
    public function create(Request $request)
    {
        $this->validate($request,[
            'itemName'=>'required|unique:items'
        ]);
      return Item::create([
           'itemName'=>$request->itemName
       ]);
    }

    public function update(Request $request)
    {
        $this->validate($request, [
            'itemName' => 'required|unique:items'
        ]);
        Item::where('id', $request->id)->update([
            'itemName' => $request->itemName
        ]);

        return response()->json([
            'itemName' => $request->itemName
        ]);
    }

 

    public function destroy(Request $request)
    {
        $this->validate($request, [
            'id' => 'required'
        ]);

        $count = Product::where('item_id',$request->id)->count();
        if($count<1){
            return Item::where('id', $request->id)->delete();
        }else{
            return response()->json([
                'msg' => "Sorry Item Have Products"
            ], 423);
        }



        
    }
}
