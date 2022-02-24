import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/states/Page/aboutmeuser.dart';
import 'package:flutter_project_web_supportandservice/states/Page/homeuser.dart';
import 'package:flutter_project_web_supportandservice/states/Page/homeuseredit.dart';
import 'package:flutter_project_web_supportandservice/states/Page/login.dart';
import 'package:flutter_project_web_supportandservice/states/components/home/data_search.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/adduser.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/picture_components.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/form_useredit/add.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/user_editdata.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/user_editpage.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/user_editpersonal%20.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  // '/home':(BuildContext context) => Home(),
  '/login': (BuildContext context) => LoginPage(),
  '/homeuser': (BuildContext context) => HomeUser(),
  '/adduser': (BuildContext context) => Adduser(),
  '/homeuseredit': (BuildContext context) => HomeUserEdit(),
  // '/homeuseranno': (BuildContext context) => HomeUserAnno(),
  '/usereditpage': (BuildContext context) => UserEditPage(),
  '/usereditpersonal': (BuildContext context) => UserEditPersonal(),
  '/usereditdata': (BuildContext context) => UserEditData(),
  '/picturecomponents': (BuildContext context) => PictureComponents(),
  '/aboutme': (BuildContext context) => AboutMePage(),
  '/addpicture': (BuildContext context) => Add(),
  '/datasearch': (BuildContext context) => DataSearch(),
};

String? initialRoute;

// void main() {
//   runApp(
//     MyApp(),
//   );
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? lognedUser = preferences.getString('user_id');
  String? status = preferences.getString('user_status');

  if (lognedUser != null) {
    switch (status) {
      case 'US':
        initialRoute = '/homeuser';
        break;
      default:
        // ignore: unnecessary_statements
        initialRoute = '/homeuseredit';
    }
  } else {
    initialRoute = '/login';
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Future getUserData() => UserPreferences().getUser();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
