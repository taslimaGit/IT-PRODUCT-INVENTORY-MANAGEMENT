<?php

namespace App\Http\Controllers;

use App\Role;
use Illuminate\Http\Request;

class RoleController extends Controller
{

    public function index()
    {
        return Role::all();
    }


    public function create(Request $request)
    {

        $this->validate($request, [
            "roleName" => 'required|unique:roles'
        ]);
        return Role::create([
            "roleName" => $request->roleName
        ]);
    }
    public function update(Request $request)
    {
        $this->validate($request, [
            "id" => 'required',
            "roleName" => 'required|unique:roles'
        ]);

        return Role::where('id', $request->id)->update([
            "roleName" => $request->roleName
        ]);
    }
    public function destroy(Request $request)
    {
        $this->validate($request, [
            "id" => 'required'
        ]);

        return Role::where('id', $request->id)->delete();
    }
}
