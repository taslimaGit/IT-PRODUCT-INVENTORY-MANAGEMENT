<?php

namespace App\Http\Controllers;

use App\Client;
use App\ClientProduct;
use App\Department;
use App\Designation;
use Illuminate\Validation\Rule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ClientController extends Controller
{

    public function index(Request $request)
    {
        return Client::where('deletionStatus', 0)->orderBy('id', 'desc')->with('department', 'designation')
            ->select('id', 'clientName', 'department_id', 'designation_id', 'phoneNo', 'activeStatus')
            ->paginate($request->total);
    }

    public function get_all_department_client()
    {
        return  Department::all();
    }

    public function get_all_designation_client()
    {
        return Designation::all();
    }

    public function allClient()
    {        
        return Client::where('deletionStatus', 0)->with('department', 'designation')
            ->select('id', 'clientName', 'department_id', 'designation_id', 'phoneNo', 'activeStatus')
            ->get();
    }

    public function create(Request $request)
    {
       
        $this->validate($request, [
            'clientName' => 'required',
            'department_id' => 'required',
            'designation_id' => 'required',
            'phoneNo' => 'required|min:11|max:11|unique:clients'
        ]);

        

        DB::beginTransaction();
        try {
            $data =  Client::create([
                'clientName' => $request->clientName,
                'department_id' => $request->department_id,
                'designation_id' => $request->designation_id,
                'phoneNo' => $request->phoneNo
            ]);
            $raw_id = 10000;
            $raw_id += $data->id;
            $client_id = 'Txf' . $raw_id;
            Client::where('id', $data->id)->update([
                'client_id' => $client_id
            ]);
            $department = array(
                "departmentName" => $data->department->departmentName
            );
            $designation = array(
                "designationName" => $data->designation->designationName
            );
            DB::commit();
            return response()->json([
                'id' => $data->id,
                'clientName' => $request->clientName,
                'department_id' => $request->department_id,
                'department' => $department,
                'designation_id' => $request->designation_id,
                'designation' => $designation,
                'phoneNo' => $request->phoneNo,
                'activeStatus'=>1
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['msg' => 'not done'], 401);
        }
    }

    public function update(Request $request)
    {
        
        $this->validate($request, [
            'id' => 'required',
            'clientName' => 'required',
            'department_id' => 'required',
            'designation_id' => 'required',
            'phoneNo' => 'required|min:11|max:11'
            // [
            //     'required', 'min:11', 'max:11',
            //     Rule::unique('clients')->ignore($request->id),
            // ]
        ]);

        Client::where('id', $request->id)->update([
            'clientName' => $request->clientName,
            'department_id' => $request->department_id,
            'designation_id' => $request->designation_id,
            'phoneNo' => $request->phoneNo
        ]);

        return response()->json([
            'id' => $request->id,
            'clientName' => $request->clientName,
            'department_id' => $request->department_id,
            'designation_id' => $request->designation_id,
            'phoneNo' => $request->phoneNo
        ], 200);
    }

    public function active_status_change_client(Request $request)
    {
        $this->validate($request, [
            'id' => 'required',
        ]);
        $status = $request->activeStatus;

        if ($status == 1) {
            $status = 0;
        } else {
            $status = 1;
        }
        Client::where('id', $request->id)->update([
            'activeStatus' => $status
        ]);
        return response()->json([
            'id' => $request->id,
            'activeStatus' => $status
        ], 200);
    }

    public function destroy(Request $request)
    {
        $this->validate($request, [
            'id' => 'required',
        ]);

      $res =  ClientProduct::where('client_id',$request->id)->where('activeStatus',1)->get();
      if(count($res)<1){
        Client::where('id', $request->id)->update([
            'deletionStatus' => 1
        ]);
        return response()->json([
            'id' => $request->id
        ], 200);
      }else{
        return response()->json([
            'msg' => "Sorry Client Have Product"
        ], 423);
      }

       
       
    }

    public function store(Request $request)
    {
    }

    
}
