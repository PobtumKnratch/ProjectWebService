import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/user_login.dart';
import 'package:flutter_project_web_supportandservice/login_user/provider/auth_provider.dart';
import 'package:flutter_project_web_supportandservice/login_user/provider/user_provider.dart';
import 'package:flutter_project_web_supportandservice/login_user/widgetlogin.dart';
import 'package:flutter_project_web_supportandservice/states/Page/homeuser.dart';
import 'package:provider/provider.dart';

class PageUserlogin extends StatefulWidget {
  const PageUserlogin({Key? key}) : super(key: key);
  static const String routeName = '/pageuserlogin';

  @override
  _PageUserloginState createState() => _PageUserloginState();
}

class _PageUserloginState extends State<PageUserlogin> {
  late String username;
  late String password;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    var dologin = () {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        final Future respose = auth.login(username, password);

        respose.then((response) {
          if (response['status']) {
            Userlogin userlogin = response['user'];

            Provider.of<UserProvider>(context, listen: false)
                .setUserlogin(userlogin);
            Navigator.pushReplacementNamed(context, HomeUser.routeName);
          } else {}
        });
      } else {}
    };

    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CircularProgressIndicator(), Text('login fail')],
    );
    return Container(
      padding: EdgeInsets.all(40.0),
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15.0,
          ),
          Text("Email"),
          SizedBox(
            height: 5.0,
          ),
          TextFormField(
            autofocus: false,
            validator: (value) =>
                value!.isEmpty ? "please enter username" : null,
            onSaved: (value) => username = value!,
            decoration: buildInputDecoration('enter email', Icons.email),
          ),
          SizedBox(
            height: 20,
          ),
          Text("password"),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            autofocus: false,
            obscureText: true,
            validator: (value) =>
                value!.isEmpty ? "please enter password" : null,
            onSaved: (value) => password = value!,
            decoration: buildInputDecoration('enter password', Icons.lock),
          ),
          SizedBox(
            height: 20,
          ),
          auth.loggedInStatus == Status.Authenticating
              ? loading
              : longButtons('Login', dologin),
        ],
      )),
    );
  }
}
