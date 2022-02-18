import 'package:flutter_project_web_supportandservice/Model/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // Future saveUser(Userlogin userlogin) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('user_Id', userlogin.userId);
  //   prefs.setString('username', userlogin.username);
  //   prefs.setString('password', userlogin.password);
  //   prefs.setString('topic_Id', userlogin.topicId);
  //   prefs.setString('firstname', userlogin.firstname);
  //   prefs.setString('lastname', userlogin.lastname);
  //   prefs.setString('email', userlogin.email);
  //   prefs.setString('current_login', userlogin.currentLogin);
  //   prefs.setString('previous_login', userlogin.previousLogin);
  //   prefs.setString('user_status', userlogin.userStatus);
  //   prefs.setString('token', userlogin.token);
  //   return prefs.commit();
  // }

  Future getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_Id = prefs.getString("user_Id");
    String? username = prefs.getString("username");
    String? password = prefs.getString("password");
    String? topic_Id = prefs.getString("topic_Id");
    String? firstname = prefs.getString("firstname");
    String? lastname = prefs.getString("lastname");
    String? email = prefs.getString("email");
    String? current_login = prefs.getString("current_login");
    String? previous_login = prefs.getString("previous_login");
    String? user_status = prefs.getString("user_status");
    String? token = prefs.getString("token");

    // return Userlogin(
    //     user_Id: user_Id,
    //     user_email: user_email,
    //     user_passphase: user_passphase,
    //     topic_Id: topic_Id,
    //     firstname: firstname,
    //     lastname: lastname,
    //     email: email,
    //     current_login: current_login,
    //     previous_login: previous_login,
    //     user_status: user_status
    //     token:token);
  }

  Future getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }
}
