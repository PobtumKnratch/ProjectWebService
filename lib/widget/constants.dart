import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload3.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload4.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_project_web_supportandservice/Model/fileupload2.dart';
import 'package:shared_preferences/shared_preferences.dart';

String hosttravel = 'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload2';
String hostInsert = 'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/insertData';
String hostlogin = 'http://localhost/flutter_project_web_supportandservice/Backend/server';

const List<String> allMonth = [
  "มกราคม",
  "กุมภาพันธ์",
  "มีนาคม",
  "เมษายน",
  "พฤษภาคม",
  "มิถุนายน",
  "กรกฎาคม",
  "สิงหาคม",
  "กันยายน",
  "ตุลาคม",
  "พฤศจิกายน",
  "ธันวาคม"
];

// ignore: non_constant_identifier_names
final Categoriesclass = [
  'images/picturecontent/wat1.jpg',
  'images/picturecontent/food2.jpg',
  'images/picturecontent/signboard2.jpg',
  'images/picturecontent/sea ​​of ​​fog.jpeg',
];

final titleclass = [
  'ท่องเที่ยว',
  'อาหาร',
  'ป้ายสถานที่',
  'สถานการณ์',
];
const kTextColor = Color(0xFF707070);
const kDefaultPadding = 20.0;

Future<List<Upload>> getupload() async {
  List<Upload> models = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userID = preferences.getString('user_id')!;
  final url =
      'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/ShowData/fileupload.php';
  final response = await http.get(Uri.parse(url));
  print(response);
  if (response.statusCode == 200) {
    // return upload2FromJson(response.body);
    // print(response.body);
    for (var item in json.decode(response.body)) {
      models.add(Upload.fromMap(item));
    }
  } else {
    throw Exception(response.hashCode);
  }
  return models;
}

Future<List<Upload2>> getupload2() async {
  List<Upload2> models = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userID = preferences.getString('user_id')!;
  final url =
      'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/ShowData/fileupload2.php';
  final response = await http.get(Uri.parse(url));
  print(response);
  if (response.statusCode == 200) {
    // return upload2FromJson(response.body);
    // print(response.body);
    for (var item in json.decode(response.body)) {
      models.add(Upload2.fromMap(item));
    }
  } else {
    throw Exception(response.hashCode);
  }
  return models;
}

Future<List<Upload3>> getupload3() async {
  List<Upload3> models = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userID = preferences.getString('user_id')!;
  final url =
      'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/ShowData/fileupload3.php';
  final response = await http.get(Uri.parse(url));
  print(response);
  if (response.statusCode == 200) {
    // return upload2FromJson(response.body);
    // print(response.body);
    for (var item in json.decode(response.body)) {
      models.add(Upload3.fromMap(item));
    }
  } else {
    throw Exception(response.hashCode);
  }
  return models;
}

Future<List<Upload4>> getupload4() async {
  List<Upload4> models = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userID = preferences.getString('user_id')!;
  final url =
      'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/ShowData/fileupload4.php';
  final response = await http.get(Uri.parse(url));
  print(response);
  if (response.statusCode == 200) {
    // return upload2FromJson(response.body);
    // print(response.body);
    for (var item in json.decode(response.body)) {
      models.add(Upload4.fromMap(item));
    }
  } else {
    throw Exception(response.hashCode);
  }
  return models;
}

Future<List<Upload>> selectupload() async {
  List<Upload> models = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userID = preferences.getString('user_id')!;
  final url =
      'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/SelectData/selectdata.php?user_id=$userID';
  final response = await http.get(Uri.parse(url));
  print(response);
  if (response.statusCode == 200) {
    // return upload2FromJson(response.body);
    // print(response.body);
    for (var item in json.decode(response.body)) {
      models.add(Upload.fromMap(item));
    }
  } else {
    throw Exception(response.hashCode);
  }
  return models;
}


Future<List<Upload2>> selectupload2() async {
  List<Upload2> models = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userID = preferences.getString('user_id')!;
  final url =
      'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/SelectData/selectdata2.php?user_id=$userID';
  final response = await http.get(Uri.parse(url));
  print(response);
  if (response.statusCode == 200) {
    // return upload2FromJson(response.body);
    // print(response.body);
    for (var item in json.decode(response.body)) {
      models.add(Upload2.fromMap(item));
    }
  } else {
    throw Exception(response.hashCode);
  }
  return models;
}


Future<List<Upload3>> selectupload3() async {
  List<Upload3> models = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userID = preferences.getString('user_id')!;
  final url =
      'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/SelectData/selectdata3.php?user_id=$userID';
  final response = await http.get(Uri.parse(url));
  print(response);
  if (response.statusCode == 200) {
    // return upload2FromJson(response.body);
    // print(response.body);
    for (var item in json.decode(response.body)) {
      models.add(Upload3.fromMap(item));
    }
  } else {
    throw Exception(response.hashCode);
  }
  return models;
}


Future<List<Upload4>> selectupload4() async {
  List<Upload4> models = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userID = preferences.getString('user_id')!;
  final url =
      'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/SelectData/selectdata4.php?user_id=$userID';
  final response = await http.get(Uri.parse(url));
  print(response);
  if (response.statusCode == 200) {
    // return upload2FromJson(response.body);
    // print(response.body);
    for (var item in json.decode(response.body)) {
      models.add(Upload4.fromMap(item));
    }
  } else {
    throw Exception(response.hashCode);
  }
  return models;
}