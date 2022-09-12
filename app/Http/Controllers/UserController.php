<?php

namespace App\Http\Controllers;

use App\Role;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return User::where("isActive",1)->with('role')->get();
    }
    public function get_all_role_user()
    {
      
      return Role::all();
    }
   
   
    public function create(Request $request)
    {
        $this->validate($request,[
            "fullName"=>'required',
            "userName"=>'required|unique:users',
            "password"=>'required',
            "role_id"=>'required'
        ]);
        $pass = bcrypt($request->password);
        
        $data = User::create([
            "fullName"=>$request->fullName,
            "userName"=>$request->userName,
            "password"=>$pass,
            "role_id"=>$request->role_id
        ]);
        $role = Role::where('id',$data->role_id)->first();
        $roleName = array(
            "roleName" => $role->roleName
        );
        return response()->json([
            "fullName"=>$request->fullName,          
            "role_id"=>$request->role_id,
            "role"=>$roleName
        ], 201);

    }

    public function update(Request $request)
    {
        $this->validate($request,[
            "id"=>'required',
            "fullName"=>'required',          
            "role_id"=>'required'
        ]);
        return User::where('id',$request->id)->update([
            "fullName"=>$request->fullName,
            "role_id"=>$request->role_id
        ]);
    }

    
    public function destroy(Request $request)
    {
        $this->validate($request,[
            "id"=>'required'
        ]);

       return User::where('id',$request->id)->update([
           "isActive"=>0
       ]);
    }

    public function login_check (Request $request){

        $this->validate($request, [
            'userName' => 'required',
            'password' => 'required'
        ]);
        if (Auth::attempt(['userName' => $request->userName, 'password' => $request->password, 'isActive'=>1] )) {
            // $user = Auth::user();
            // return $user->role->roleName; 
            // return;
            return response()->json([
                'msg' => 'you are logged in'
            ]);
        }elseif(Auth::attempt(['userName' => $request->userName, 'password' => $request->password, 'isActive'=>5] )){} else {
            return response()->json([
                'msg' => 'Incorrect email or password'
            ], 401);
        }
    }

    public function logout()
    {
        return Auth::logout();
        
    }

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
  

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    
}
