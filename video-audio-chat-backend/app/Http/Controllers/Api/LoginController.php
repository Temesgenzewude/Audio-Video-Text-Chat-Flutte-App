<?php

namespace App\Http\Controllers\Api;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;


class LoginController extends Controller{
    public function login(Request $request){

        $validator=Validator::make($request->all(), [
            "avatar"=>"required",
            "name"=>"required",
            "email"=>"max:50",
            "type"=>"required",
            "open_id"=>"required",
            "phone"=>"max:30"

        ]);

        if($validator->fails()){
            return response()->json([
                "code"=>1,
                "data"=>"Invalid data",
                "message"=>$validator->errors()->first()
            ]);
        }
    }
}