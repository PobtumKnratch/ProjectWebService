import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

List<User> usersFormJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
String usersToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final String info_Id;
  final String user_Id;
  final String email;
  final String firstname;
  final String lastname;
  final String topic_Id;
  final String phase;

  const User(
      {required this.info_Id,
      required this.user_Id,
      required this.email,
      required this.firstname,
      required this.lastname,
      required this.topic_Id,
      required this.phase});

  static User fromJson(json) {
    return User(
      info_Id: json['info_id'] as String,
      user_Id: json['user_id'] as String,
      email: json['email'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      topic_Id: json['topic_id'] as String,
      phase: json['phase'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['info_id'] = this.info_Id;
    data['user_id'] = this.user_Id;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['topic_id'] = this.topic_Id;
    data['phase'] = this.phase;
    return data;
  }
}
