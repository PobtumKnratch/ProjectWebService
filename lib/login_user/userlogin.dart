import 'package:flutter/material.dart';

class Userlogin extends ChangeNotifier {
  String username = "";
  String password = "";

  void signIn(String username, String password) {
    username = username;
    password = password;
    notifyListeners();
  }
}
