import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/login_user/pageuserlogin.dart';
import 'package:flutter_project_web_supportandservice/states/Page/aboutmeuser.dart';
import 'package:flutter_project_web_supportandservice/states/Page/homeuser.dart';
import 'package:flutter_project_web_supportandservice/states/Page/homeuseranno.dart';
import 'package:flutter_project_web_supportandservice/states/Page/homeuseredit.dart';
import 'package:flutter_project_web_supportandservice/states/Page/login.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/circle.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/rectanglePage.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/rectanglePaintPage.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/mycustom.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/user_annopage.dart';
import 'package:flutter_project_web_supportandservice/states/components/home/data_search.dart';
import 'package:flutter_project_web_supportandservice/states/components/home/home.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/adduser.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/picture_components.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/form_useredit/add.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/form_useredit/insert.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/form_useredit/testinsert.dart';
// import 'package:flutter_project_web_supportandservice/states/components/useredit/form_useredit/add_data.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/user_editdata.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/user_editpage.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/user_editpersonal%20.dart';

final Map<String, WidgetBuilder> map = {
  // '/home':(BuildContext context) => Home(),
  '/login': (BuildContext context) => LoginPage(),
  '/homeuser': (BuildContext context) => HomeUser(),
  '/adduser': (BuildContext context) => Adduser(),
  '/homeuseredit': (BuildContext context) => HomeUserEdit(),
  '/homeuseranno': (BuildContext context) => HomeUserAnno(),
  '/usereditpage': (BuildContext context) => UserEditPage(),
  '/usereditpersonal': (BuildContext context) => UserEditPersonal(),
  '/usereditdata': (BuildContext context) => UserEditData(),
  '/picturecomponents': (BuildContext context) => PictureComponents(),
  '/aboutme': (BuildContext context) => AboutMePage(),
  '/addpicture': (BuildContext context) => Add(),
  '/pageuserlogin': (BuildContext context) => PageUserlogin(),
  '/userannodata' :(BuildContext context) => UserAnnoData(),
  '/mycustom':(BuildContext context) =>MyCustomPainter(),
  '/Rec':(BuildContext context) => RectanglePaintPage(),
  '/rectangle':(BuildContext context) => RectanglePage(),
  '/circle':(BuildContext context) => CirclePage(),
  '/insertData' :(BuildContext context) => InsertData(),
  '/insert':(BuildContext context) => Insert(),
  '/datasearch':(BuildContext context) => DataSearch(),
};

String initialRoute = '/login';

void main() {
  runApp(
    MyApp(),
  );
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

    // return MultiProvider(
    //   providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
    //   child: MaterialApp(
    //     home: FutureBuilder(
    //       future: getUserData(),
    //       builder: (context, snapshot) {
    //         switch (snapshot.connectionState) {
    //           case ConnectionState.none:
    //           case ConnectionState.waiting:
    //             return CircularProgressIndicator();
    //           default:
    //             if (snapshot.hasError)
    //               return Text('Error: ${snapshot.error}');
    //             else if (snapshot.data == null) {
    //               return PageUserlogin();
    //             } else {
    //               Provider.of<UserProvider>(context).setUser(snapshot.data);
    //             }
    //             return HomeUser();
    //         }
    //       },
    //     ),
    //     debugShowCheckedModeBanner: false,
    //     routes: map,
    //     initialRoute: initialRoute,
    //   ),
    // );
  }
}
