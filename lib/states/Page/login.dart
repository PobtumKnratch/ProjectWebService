// ignore_for_file: non_constant_identifier_names, unused_shown_name

import 'dart:convert' show ascii, base64, json, jsonDecode, jsonEncode;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/user_login.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/Page/homeuser.dart';
import 'package:flutter_project_web_supportandservice/states/Page/homeuseredit.dart';
import 'package:flutter_project_web_supportandservice/widget/dialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/picturebackground/backgroundlogin.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black87.withOpacity(0.65), BlendMode.dstATop),
          ),
        ),
        child: ListView(
          children: [
            // HeaderLogin(),
            Body(),
          ],
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formKey = GlobalKey<FormState>();
  String? token = "";
  late String username, password;
  // Userlogin? userlogin;
  List<Userlogin> userlogin = [];
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkAuthen();
  }
  
  Future checkAuthen({String? password, String? username}) async {
    // try {
    var data = <String, String>{
      'username': usernameController.text,
      'password': passwordController.text
    };
    var url =
        "http://localhost/flutter_project_web_supportandservice/Backend/server/api_login.php";
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        // ignore: deprecated_member_use, unnecessary_brace_in_string_interps
        HttpHeaders.AUTHORIZATION: '${token}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    if (response.statusCode == 200) { 
      // print(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      // ignore: unnecessary_brace_in_string_interps
      print('Map Data : ${map}');
      Userlogin userlogin = Userlogin.fromJson(map);
      String token = userlogin.token.toString();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('jwt', token);
      // ignore: unused_local_variable
      final counter = preferences.getString('jwt') ?? 0;
      // print('Counter Token ${counter}');
      String? password = userlogin.password;
      if (password != null) {
        String? user_status = userlogin.user_status;
        // ignore: unnecessary_brace_in_string_interps
        print('User Status ${user_status}');
        if (user_status == 'US') {
          Fluttertoast.showToast(
            msg: 'เข้าสู่ระบบสำเร็จ ข้อมูลผู้ใช้ทั่วไป',
            gravity: ToastGravity.CENTER_RIGHT,
            toastLength: Toast.LENGTH_LONG,
          );
          routeService(HomeUser(), userlogin);
        } else if (user_status == "ED") {
          Fluttertoast.showToast(
            msg: 'เข้าสู่ระบบสำเร็จ ข้อมูลผู้ใช้แก้ไขข้อมูล',
            gravity: ToastGravity.CENTER_RIGHT,
            toastLength: Toast.LENGTH_LONG,
          );
          routeService(HomeUserEdit(), userlogin);
        // } else if (user_status == 'AN') {
        //   Fluttertoast.showToast(
        //     msg: 'เข้าสู่ระบบสำเร็จ ข้อมูลผู้ใช้ตรวจสอบข้อมูลรูปภาพ',
        //     gravity: ToastGravity.CENTER_RIGHT,
        //     toastLength: Toast.LENGTH_LONG,
        //   );
        //   routeService(HomeUserAnno(), userlogin);
        } else {
          Fluttertoast.showToast(
            msg: 'ไม่พบข้อมูลผู้ใช้',
            gravity: ToastGravity.CENTER_RIGHT,
            toastLength: Toast.LENGTH_LONG,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'รหัสผ่านไม่ถูกต้อง',
          gravity: ToastGravity.CENTER_RIGHT,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } 
    // else {
    //   // Fluttertoast.showToast(
    //   //   msg: 'ข้อมูลผู้ใช้ไม่ถูกต้อง กรุณากรอกข้อมูลใหม่',
    //   //   gravity: ToastGravity.CENTER_RIGHT,
    //   //   toastLength: Toast.LENGTH_LONG,
    //   // );
    //   print('Response status login: [${response.statusCode}]');
    // }
  }

  Future<Null> routeService(Widget myWidget, Userlogin userlogin) async {
    String user_id = userlogin.user_id.toString();
    String username = userlogin.username.toString();    
    String topic_id = userlogin.topic_id.toString();
    String firstname = userlogin.firstname.toString();
    String email = userlogin.email.toString();
    String user_status = userlogin.user_status.toString();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user_id', user_id);
    preferences.setString('username', username);
    preferences.setString('topic_id', topic_id);
    preferences.setString('firstname', firstname);
    preferences.setString('email', email);
    preferences.setString('user_status', user_status);
    // return prefs.commit();

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Responsive(
      mobile: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.2),
            child: Container(
              // height: size.height*0.5,
              width: size.width*0.85,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Image(
                      image: AssetImage('images/pictureicon/logo.png'),
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Login',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.03,
                  ),
                  Container(padding: EdgeInsets.only(bottom: size.height*0.02),
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.08,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            width: size.width * 0.6,
                            // height: size.height * 0.05,
                            child: TextFormField(
                              // obscureText: true,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill out your information';
                                } else {
                                  return null;
                                }
                              },
                              controller: usernameController,
                              onChanged: (value) => username = value.trim(),
                              decoration: InputDecoration(
                                errorStyle: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                labelText: "Enter your username :",
                                labelStyle: GoogleFonts.kanit(
                                  textStyle:
                                      TextStyle(fontSize: size.height * 0.02),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.black54, width: 1),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: size.width * 0.6,
                            // height: size.height * 0.05,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill out your information';
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              controller: passwordController,
                              onChanged: (value) => password = value.trim(),
                              decoration: InputDecoration(
                                // suffixIcon: Icon(Icons.remove_red_eye),
                                errorStyle: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                labelText: "Enter your password :",
                                labelStyle: GoogleFonts.kanit(
                                  textStyle:
                                      TextStyle(fontSize: size.height * 0.02),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.black54,
                                    width: 1,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: size.width * 0.25,
                            height: size.height * 0.045,
                            child: ElevatedButton(
                              child: Text(
                                "LogIn",
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: size.height * 0.016),
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  // print('username = $username, password = $password');

                                  // ignore: unnecessary_null_comparison
                                  if (username == null ||
                                      username.isEmpty ||
                                      // ignore: unnecessary_null_comparison
                                      password == null ||
                                      password.isEmpty) {
                                    normalDialog(
                                        context,
                                        'ไม่สามารถเข้าสู่ระบบได้',
                                        'กรุณากรอกข้อมูลของท่านให้ครบถ้วน');
                                  } else {
                                    checkAuthen(
                                        username: username,
                                        password: password);
                                  }
                                } else {}
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.greenAccent,
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      tablet: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.25),
            child: Container(
              // height: size.height*0.5,
              width: size.height*0.5,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: Image(
                      image: AssetImage('images/pictureicon/logo.png'),
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Login',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(padding: EdgeInsets.only(bottom: size.height*0.02),
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.07,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                          width: size.width * 0.6,
                          // height: size.height * 0.05,
                          child: TextFormField(
                            // obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill out your information';
                              } else {
                                return null;
                              }
                            },
                            controller: usernameController,
                            onChanged: (value) => username = value.trim(),
                            decoration: InputDecoration(
                              errorStyle: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  color: Colors.red.shade400,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              labelText: "Enter your username :",
                              labelStyle: GoogleFonts.kanit(
                                textStyle:
                                    TextStyle(fontSize: size.height * 0.02),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors.black54, width: 1),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                          width: size.width * 0.6,
                          // height: size.height * 0.05,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill out your information';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            controller: passwordController,
                            onChanged: (value) => password = value.trim(),
                            decoration: InputDecoration(
                              // suffixIcon: Icon(Icons.remove_red_eye),
                              errorStyle: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  color: Colors.red.shade400,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              labelText: "Enter your password :",
                              labelStyle: GoogleFonts.kanit(
                                textStyle:
                                    TextStyle(fontSize: size.height * 0.02),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 1,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: size.width * 0.25,
                            height: size.height * 0.045,
                            child: ElevatedButton(
                              child: Text(
                                "LogIn",
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: size.height * 0.016),
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  // print('username = $username, password = $password');

                                  // ignore: unnecessary_null_comparison
                                  if (username == null ||
                                      username.isEmpty ||
                                      // ignore: unnecessary_null_comparison
                                      password == null ||
                                      password.isEmpty) {
                                    normalDialog(
                                        context,
                                        'ไม่สามารถเข้าสู่ระบบได้',
                                        'กรุณากรอกข้อมูลของท่านให้ครบถ้วน');
                                  } else {
                                    checkAuthen(
                                        username: username,
                                        password: password);
                                  }
                                } else {}
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.greenAccent,
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      desktop: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.15),
            child: Container(
              // height: size.height,
              width: 540,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Image(
                      image: AssetImage('images/pictureicon/logo.png'),
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Login',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: size.height*0.02),
                    margin:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            // width: size.width,
                            // height: size.height,
                            child: TextFormField(
                              // obscureText: true,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill out your information';
                                } else {
                                  return null;
                                }
                              },
                              controller: usernameController,
                              onChanged: (value) => username = value.trim(),
                              decoration: InputDecoration(
                                errorStyle: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                labelText: "Enter your username :",
                                labelStyle: GoogleFonts.kanit(
                                  textStyle:
                                      TextStyle(fontSize: size.height * 0.02),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.black54, width: 1),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Container(
                            // width: size.width * 0.6,
                            // height: size.height * 0.07,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill out your information';
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              controller: passwordController,
                              onChanged: (value) => password = value.trim(),
                              decoration: InputDecoration(
                                // suffixIcon: Icon(Icons.remove_red_eye),
                                errorStyle: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                labelText: "Enter your password :",
                                labelStyle: GoogleFonts.kanit(
                                  textStyle:
                                      TextStyle(fontSize: size.height * 0.02),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.black54,
                                    width: 1,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: size.width * 0.1,
                            height: size.height * 0.045,
                            child: ElevatedButton(
                              child: Text(
                                "LogIn",
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: size.height * 0.016),
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  // print('username = $username, password = $password');

                                  // ignore: unnecessary_null_comparison
                                  if (username == null ||
                                      username.isEmpty ||
                                      // ignore: unnecessary_null_comparison
                                      password == null ||
                                      password.isEmpty) {
                                    normalDialog(
                                        context,
                                        'ไม่สามารถเข้าสู่ระบบได้',
                                        'กรุณากรอกข้อมูลของท่านให้ครบถ้วน');
                                  } else {
                                    checkAuthen(
                                        username: username,
                                        password: password);
                                  }
                                } else {}
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.greenAccent,
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogin(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return
    // Responsive(
    //   mobile: Container(
    //     width: 150,
    //     height: 40,
    //     child: ElevatedButton(
    //       child: Text(
    //         "LogIn",
    //         style: GoogleFonts.kanit(
    //           textStyle: TextStyle(color: Colors.black, fontSize: 14),
    //         ),
    //       ),
    //       onPressed: () async {
    //         if (formKey.currentState!.validate()) {
    //           print('username = $username, password = $password');
    //           if ((username.isEmpty) || (password.isEmpty)) {
    //             print('Have Space');
    //             // normalDialog(context, 'Have Space', 'Please Fill Every Blank');
    //           // } else {
    //           //       var jwt = await apilogin(username: username, password: password);
    //           //       if (jwt != null) {
    //           //         storage.write(key: "jwt", value: jwt);
    //           //         Navigator.push(
    //           //   context, MaterialPageRoute(builder: (context) => HomeUser.fromBase64(jwt)));
    //           //   }
    //             apilogin(username: username, password: password);
    //             print('No Space');
    //             // checkAuthen(context);
    //           }

    //           // print('No Space');
    //         }
    //         // else{

    //         // }
    //       },
    //       style: ElevatedButton.styleFrom(
    //         primary: Colors.greenAccent.shade700,
    //         onPrimary: Colors.black,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(8),
    //         ),
    //       ),
    //     ),
    //   ),
    //   tablet: Container(
    //     width: 150,
    //     height: 40,
    //     child: ElevatedButton(
    //       child: Text(
    //         "LogIn",
    //         style: GoogleFonts.kanit(
    //           textStyle: TextStyle(color: Colors.black, fontSize: 18),
    //         ),
    //       ),
    //       onPressed: () async {
    //         if (formKey.currentState!.validate()) {
    //           print('username = $username, password = $password');
    //           if ((username.isEmpty) || (password.isEmpty)) {
    //             print('Have Space');
    //             // normalDialog(context, 'Have Space', 'Please Fill Every Blank');
    //           } else {
    //             //     var jwt = await apilogin(username: username, password: password);
    //             //     if (jwt != null) {
    //             //       storage.write(key: "jwt", value: jwt);
    //             //       Navigator.push(
    //             // context, MaterialPageRoute(builder: (context) => HomeUser.fromBase64(jwt)));
    //             // }
    //             apilogin(username: username, password: password);
    //             print('No Space');
    //             // checkAuthen(context);
    //           }

    //           // print('No Space');
    //         }
    //         // else{

    //         // }
    //       },
    //       style: ElevatedButton.styleFrom(
    //         primary: Colors.greenAccent.shade700,
    //         onPrimary: Colors.black,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(12),
    //         ),
    //       ),
    //     ),
    //   ),
    //   desktop: Container(
    //     width: 200,
    //     height: 150,
    //     child: ElevatedButton(
    //       child: Text(
    //         "LogIn",
    //         style: GoogleFonts.kanit(
    //           textStyle: TextStyle(color: Colors.black, fontSize: 20),
    //         ),
    //       ),
    //       onPressed: () async {
    //         if (formKey.currentState!.validate()) {
    //           print('username = $username, password = $password');
    //           if ((username.isEmpty) || (password.isEmpty)) {
    //             print('Have Space');
    //             // normalDialog(context, 'Have Space', 'Please Fill Every Blank');
    //           } else {
    //             //     var jwt = await apilogin(username: username, password: password);
    //             //     if (jwt != null) {
    //             //       storage.write(key: "jwt", value: jwt);
    //             //       Navigator.push(
    //             // context, MaterialPageRoute(builder: (context) => HomeUser.fromBase64(jwt)));
    //             // }
    //             apilogin(username: username, password: password);
    //             print('No Space');
    //             // checkAuthen(context);
    //           }

    //           // print('No Space');
    //         }
    //         // else{

    //         // }
    //       },
    //       style: ElevatedButton.styleFrom(
    //         primary: Colors.greenAccent.shade700,
    //         onPrimary: Colors.black,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(15),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Container(
      width: size.width < 820
          ? size.width * 0.13
          : size.width * 0.13 > 830
              ? size.width * 0.1
              : size.width * 0.1,
      height: size.height < 820
          ? size.height * 0.04
          : size.height * 0.04 > 830
              ? size.height * 0.03
              : size.height * 0.03,
      child: ElevatedButton(
        child: Text(
          "LogIn",
          style: GoogleFonts.kanit(
            textStyle:
                TextStyle(color: Colors.black, fontSize: size.height * 0.016),
          ),
        ),
        onPressed: () async {
          // if (formKey.currentState!.validate()) {
          //   print('username = $username, password = $password');
          //   if ((username.isEmpty) || (password.isEmpty)) {
          //     print('Have Space');
          //     // normalDialog(context, 'Have Space', 'Please Fill Every Blank');
          //   } else {
          //     var jwt = await apilogin(username: username, password: password);
          //     if (jwt != null) {
          //       storage.write(key: "jwt", value: jwt);
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => HomeUser(),
          //         ),
          //       );
          //     }
          //     print('No Space');
          //     // checkAuthen(context);
          //   }

          // print('No Space');
          // }
          // else{

          // }
          if (formKey.currentState!.validate()) {
            // print('username = $username, password = $password');

            // ignore: unnecessary_null_comparison
            if (username == null ||
                username.isEmpty ||
                // ignore: unnecessary_null_comparison
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'ไม่สามารถเข้าสู่ระบบได้',
                  'กรุณากรอกข้อมูลของท่านให้ครบถ้วน');
            } else {
              checkAuthen(username: username, password: password);
            }
          } else {}
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.greenAccent.shade700,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget builduser() {
    Size size = MediaQuery.of(context).size;
    // return Responsive(
    //   mobile: Container(
    //     height: 100,
    //     width: size.width * 1,
    //     child: TextFormField(
    //       // obscureText: true,
    //       keyboardType: TextInputType.emailAddress,
    //       validator: (value) {
    //         if (value == null || value.isEmpty) {
    //           return 'Please fill out your information';
    //         } else {
    //           return null;
    //         }
    //       },
    //       controller: usernameController,
    //       onChanged: (value) => username = value.trim(),
    //       decoration: InputDecoration(
    //         errorStyle: GoogleFonts.kanit(
    //           textStyle: TextStyle(
    //             color: Colors.red.shade400,
    //             fontSize: 12,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         labelText: "Enter your username :",
    //         labelStyle: GoogleFonts.kanit(
    //           textStyle: TextStyle(fontSize: 14),
    //         ),
    //         border: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(10),
    //           borderSide: BorderSide(color: Colors.black54, width: 1),
    //         ),
    //         filled: true,
    //         fillColor: Colors.white,
    //       ),
    //     ),
    //   ),
    //   tablet: Container(
    //     // height: 60,
    //     width: size.width * 1,
    //     child: TextFormField(
    //       // obscureText: true,
    //       keyboardType: TextInputType.emailAddress,
    //       validator: (value) {
    //         if (value == null || value.isEmpty) {
    //           return 'Please fill out your information';
    //         } else {
    //           return null;
    //         }
    //       },
    //       controller: usernameController,
    //       onChanged: (value) => username = value.trim(),
    //       decoration: InputDecoration(
    //         errorStyle: GoogleFonts.kanit(
    //           textStyle: TextStyle(
    //             color: Colors.red.shade400,
    //             fontSize: 14,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         labelText: "Enter your username :",
    //         labelStyle: GoogleFonts.kanit(
    //           textStyle: TextStyle(fontSize: 17),
    //         ),
    //         border: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(14),
    //           borderSide: BorderSide(color: Colors.black54, width: 1),
    //         ),
    //         filled: true,
    //         fillColor: Colors.white,
    //       ),
    //     ),
    //   ),
    //   desktop: Container(
    //     height: size.height * 4,
    //     // width: size.width * 1.5,
    //     child: TextFormField(
    //       obscureText: true,
    //       keyboardType: TextInputType.emailAddress,
    //       validator: (value) {
    //         if (value == null || value.isEmpty) {
    //           return 'Please fill out your information';
    //         } else {
    //           return null;
    //         }
    //       },
    //       controller: usernameController,
    //       onChanged: (value) => username = value.trim(),
    //       decoration: InputDecoration(
    //         errorStyle: GoogleFonts.kanit(
    //           textStyle: TextStyle(
    //             color: Colors.red.shade400,
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         labelText: "Enter your username :",
    //         labelStyle: GoogleFonts.kanit(
    //           textStyle: TextStyle(fontSize: 18),
    //         ),
    //         border: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(18),
    //           borderSide: BorderSide(color: Colors.black54, width: 1),
    //         ),
    //         filled: true,
    //         fillColor: Colors.white,
    //       ),
    //     ),
    //   ),
    // );
    return Container(
      width: size.width < 820
          ? size.width * 0.6
          : size.width * 0.6 > 830
              ? size.width * 0.6
              : size.width * 0.6,
      height: size.height <= 820
          ? size.height * 0.06
          : size.height * 0.06 >= 830
              ? size.height * 0.2
              : size.height * 0.2,
      child: TextFormField(
        // obscureText: true,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please fill out your information';
          } else {
            return null;
          }
        },
        controller: usernameController,
        onChanged: (value) => username = value.trim(),
        decoration: InputDecoration(
          errorStyle: GoogleFonts.kanit(
            textStyle: TextStyle(
              color: Colors.red.shade400,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          labelText: "Enter your username :",
          labelStyle: GoogleFonts.kanit(
            textStyle: TextStyle(fontSize: size.height * 0.02),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black54, width: 1),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget buildpassword() {
    Size size = MediaQuery.of(context).size;
    return Responsive(
      mobile: Container(
        height: 100,
        width: size.width * 1,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please fill out your information';
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          controller: passwordController,
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            // suffixIcon: Icon(Icons.remove_red_eye),
            errorStyle: GoogleFonts.kanit(
              textStyle: TextStyle(
                color: Colors.red.shade400,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            labelText: "Enter your password :",
            labelStyle: GoogleFonts.kanit(
              textStyle: TextStyle(fontSize: 14),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black54,
                width: 1,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
      tablet: Container(
        width: size.width * 1,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please fill out your information';
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          controller: passwordController,
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            // suffixIcon: Icon(Icons.remove_red_eye),
            errorStyle: GoogleFonts.kanit(
              textStyle: TextStyle(
                color: Colors.red.shade400,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            labelText: "Enter your password :",
            labelStyle: GoogleFonts.kanit(
              textStyle: TextStyle(fontSize: 17),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.black54,
                width: 1,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
      desktop: Container(
        height: size.height * 3,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please fill out your information';
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          controller: passwordController,
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            // suffixIcon: Icon(Icons.remove_red_eye),
            errorStyle: GoogleFonts.kanit(
              textStyle: TextStyle(
                color: Colors.red.shade400,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            labelText: "Enter your password :",
            labelStyle: GoogleFonts.kanit(
              textStyle: TextStyle(fontSize: 18),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: Colors.black54,
                width: 1,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
    // return Container(
    //   width: size.width < 820
    //       ? size.width * 0.6
    //       : size.width * 0.6 > 830
    //           ? size.width * 0.6
    //           : size.width * 0.6,
    //   height: size.height <= 820
    //       ? size.height * 0.06
    //       : size.height * 0.06 >= 830
    //           ? size.height * 0.1
    //           : size.height * 0.1,
    //   child: TextFormField(
    //     validator: (value) {
    //       if (value == null || value.isEmpty) {
    //         return 'Please fill out your information';
    //       } else {
    //         return null;
    //       }
    //     },
    //     keyboardType: TextInputType.visiblePassword,
    //     obscureText: true,
    //     controller: passwordController,
    //     onChanged: (value) => password = value.trim(),
    //     decoration: InputDecoration(
    //       // suffixIcon: Icon(Icons.remove_red_eye),
    //       errorStyle: GoogleFonts.kanit(
    //         textStyle: TextStyle(
    //           color: Colors.red.shade400,
    //           fontSize: 12,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       labelText: "Enter your password :",
    //       labelStyle: GoogleFonts.kanit(
    //         textStyle: TextStyle(fontSize: size.height * 0.02),
    //       ),
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(8),
    //         borderSide: BorderSide(
    //           color: Colors.black54,
    //           width: 1,
    //         ),
    //       ),
    //       filled: true,
    //       fillColor: Colors.white,
    //     ),
    //   ),
    // );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
