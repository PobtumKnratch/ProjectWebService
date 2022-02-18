import 'package:flutter/cupertino.dart';
import 'package:flutter_project_web_supportandservice/Model/user_login.dart';

class UserProvider extends ChangeNotifier {
  Userlogin _userlogin = Userlogin(
    user_id: 'user_id',
    username: 'username',
    password: 'password',
    topic_id: 'topic_id',
    firstname: 'firstname',
    lastname: 'lastname',
    email: 'email',
    // current_login: 'current_login',
    // previous_login: 'previous_login',
    user_status: 'user_status',
    // token: 'token',
  );

  Userlogin get user => _userlogin;

  void setUserlogin(Userlogin userlogin) async {
    _userlogin = userlogin;
    notifyListeners();
  }

  void setUser(Object? data) {}
}
