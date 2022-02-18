import 'dart:convert';

List<Userlogin> FromJson(String str) =>
    List<Userlogin>.from(json.decode(str).map((x) => Userlogin.fromJson(x)));

String UserloginToJson(List<Userlogin> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Userlogin {
  Userlogin({
    this.user_id,
    this.username,
    this.password,
    this.topic_id,
    this.firstname,
    this.lastname,
    this.email,
    // this.current_login,
    // this.previous_login,
    this.user_status,
    this.token,
    this.status,
    this.chk,
  });

  String? user_id;
  String? username;
  String? password;
  String? topic_id;
  String? firstname;
  String? lastname;
  String? email;
  // String? current_login;
  // String? previous_login;
  String? user_status;
  String? token;
  int? status;
  String? chk;

  // Userlogin.fromJson(Map<String, dynamic> json) {
  //   user_id = json['user_id'] as String;
  //   username = json['username'] as String;
  //   password = json['password'] as String;
  //   topic_id = json['topic_id'] as String;
  //   firstname = json['firstname'] as String;
  //   lastname = json['lastname'] as String;
  //   email = json['email'] as String;
  //   // current_login = json['current_login'] as String;
  //   // previous_login = json['previous_login'] as String;
  //   user_status = json['user_status'] as String;
  //   // token = json['token'] as String;
  // }
  factory Userlogin.fromJson(Map<String, dynamic> json) => Userlogin(
        user_id: json['user_id'],
        username: json['username'],
        password: json['password'],
        topic_id: json['topic_id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        email: json['email'],
        user_status: json['user_status'],
        token: json["token"],
        status: json["status"],
        chk: json["chk"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['topic_id'] = this.topic_id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    // data['current_login'] = this.current_login;
    // data['previous_login'] = this.previous_login;
    data['user_status'] = this.user_status;
    data['token'] = this.token;
    data['status'] = this.status;
    data['chk'] = this.chk;
    return data;
  }
}
