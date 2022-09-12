<?php

namespace App\Http\Controllers;

use App\Client;
use App\Department;
use Illuminate\Http\Request;

class DepartmentController extends Controller
{

    public function index(Request $request)
    {
        return Department::orderBy('id', 'desc')->paginate($request->total);
    }
    public function allDepartment()
    {
        return Department::all();
    }

    public function create(Request $request)
    {
        $this->validate($request, [
            'departmentName' => 'required|unique:departments'
        ]);
        return Department::create([
            'departmentName' => $request->departmentName
        ]);
    }

    public function update(Request $request)
    {
        $this->validate($request, [
            'departmentName' => 'required|unique:departments'
        ]);
        Department::where('id', $request->id)->update([
            'departmentName' => $request->departmentName
        ]);

        return response()->json([
            'departmentName' => $request->departmentName
        ]);
    }

    public function destroy(Request $request)
    {
        $this->validate($request, [
            'id' => 'required'
        ]);
        $count = Client::where('department_id',$request->id)->count();
        if($count<1){
            return Department::where('id', $request->id)->delete();
        }else{
            return response()->json([
                'msg' => "Sorry Department Have Client"
            ], 423);
        }
        
    }


    

}
