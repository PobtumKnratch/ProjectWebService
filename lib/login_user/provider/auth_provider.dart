import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/user_login.dart';
import 'package:flutter_project_web_supportandservice/login_user/provider/share_prefernce.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

enum Status { NotLoggedIn, LoggedIn, Authenticating, LoggedOut }

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;

  Status get loggedInStatus => loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  // Future login(String username, String password) async {
  //   final Map<String, String> apiBodyData = {
  //     'username': username,
  //     'password': password,
  //   };
  //   _loggedInStatus = Status.Authenticating;
  //   notifyListeners();

  //   var url =
  //       "http://localhost/flutter_project_web_supportandservice/Backend/server/api_login.php?isAdd=true&username=$username";
  //   return await http
  //       .post(Uri.parse(url),
  //           headers: {
  //             'Content-Type': 'application/json',
  //             'Accept': 'application/json',
  //             // 'Authorization': 'Bearer $token',
  //           },
  //           body: json.encode(apiBodyData))
  //       .then(onValue)
  //       .catchError(onError);
  // }

  // static Future onValue(Response response) async {
  //   var result;

  //   final Map<String, dynamic> responseData = json.decode(response.body);

  //   print(responseData);
  //   if (response.statusCode == 200) {
  //     var userdata = responseData['date'];

  //     Userlogin authUser = Userlogin.fromJson(responseData);

  //     result = {
  //       'status': true,
  //       'message': 'Successfully registered',
  //       'data': authUser
  //     };
  //   } else {
  //     result = {
  //       'status': false,
  //       'message': 'Successfully registered',
  //       'data': responseData
  //     };
  //   }
  //   return result;
  // }

  // static onError(error) {
  //   print('the error is${error.toString()}');
  //   return  {
  //       'status': false,
  //       'message': 'Unsuccessfully Request',
  //       'data': error
  //     };
  // }

  Future<Map<String, dynamic>> login(String username, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    var url =
        "http://localhost/flutter_project_web_supportandservice/Backend/server/api_login.php?isAdd=true&username=$username";

    Response response = await http.post(
      Uri.parse(url),
      body: json.encode(loginData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
        'X-ApiKey': 'ZGlzIzEyMw=='
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      print(responseData);

      var userData = responseData['Content'];

      Userlogin authUser = Userlogin.fromJson(userData);

      // UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;
  }
}
