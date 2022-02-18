<?php

class Response{
    //default parameter
    public static function msg($success,$status,$message,$extra =[]){
        return array_merge([
            'success' => $success,
            'status' => $status,
            'message' => $message
        ],$extra);
    }



}

?>