import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Adduser extends StatelessWidget {
  const Adduser({Key? key}) : super(key: key);

  createAlertDialog(BuildContext context) {
    TextEditingController _username = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _topic_id = TextEditingController();
    TextEditingController _firstname = TextEditingController();
    TextEditingController _lastname = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _user_status = TextEditingController();

    Future ApiaddUser() async {
      var apiurl =
          "http://localhost/flutter_project_web_supportandservice/Backend/server/api_register.php";

      http.Response response = await http.post(
        Uri.parse(apiurl),
        body: jsonEncode(
          <String, String>{
            "username": _username.text,
            "password": _password.text,
            "topic_id": _topic_id.text,
            "firstname": _firstname.text,
            "lastname": _lastname.text,
            "email": _email.text,
            "user_status": _user_status.text,
          },
        ),
      );
      print(response.body);
      var data = jsonDecode(response.body);
    }

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Add User'),
                TextFormField(
                  controller: _username,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "invaild Field";
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter some Username", labelText: 'Username'),
                ),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "invaild Field";
                  },
                  //const InputDecoration(
                  //labelText: 'Password',
                  decoration: const InputDecoration(
                      hintText: "Enter some Password", labelText: 'Password'),
                ),
                TextFormField(
                  controller: _topic_id,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "invaild Field";
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter some Topic_id", labelText: 'Topic-id'),
                ),
                TextFormField(
                  controller: _firstname,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "invaild Field";
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter some Firstname", labelText: 'Firstname'),
                ),
                TextFormField(
                  controller: _lastname,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "invaild Field";
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter some Lastname", labelText: 'Lastname'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "E-mail"),
                  controller: _email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'invaild Field';
                    } else {
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return 'Check your Email';
                      }
                    }
                  },
                ),
                TextFormField(
                  controller: _user_status,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "invaild Field";
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter some Status", labelText: 'Status'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: const Text('Submit'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ApiaddUser();
                  Navigator.pop(context);
                } else {}
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          SizedBox(
            width: 200,
            height: 50,
            child: RaisedButton(
              onPressed: () {
                createAlertDialog(context);
              },
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Text(
                "Add User",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
