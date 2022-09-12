<?php

namespace App\Http\Controllers;

use App\Client;
use App\Designation;
use Illuminate\Http\Request;

class DesignationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
       return Designation::orderBy('id', 'desc')->paginate($request->total);
    }

    public function allDesignation()
    {
        return Designation::all();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $this->validate($request, [
            'designationName'=> 'required|unique:designations'
        ]);

        return Designation::create([
            'designationName'=> $request->designationName
        ]);
    }

  
    public function update(Request $request)
    {
        $this->validate($request,[
            'designationName'=> 'required|unique:designations'
        ]);
         Designation::where('id',$request->id)->update([
            'designationName'=>$request->designationName
        ]);
        return response()->json([
            'designationName'=>$request->designationName
        ]);
    }

   
    public function destroy(Request $request)
    {
        $this->validate($request,[
            'id'=> 'required'
        ]);

        $count = Client::where('designation_id',$request->id)->count();
        if($count<1){
            return Designation::where('id',$request->id)->delete();
        }else{
            return response()->json([
                'msg' => "Sorry Designation Have Client"
            ], 423);
        }
        
        
    }
}
