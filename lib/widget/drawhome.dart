import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/widget/routeuser.dart';

Widget createDrawerhome(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.greenAccent.shade100,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          color: Colors.greenAccent.shade100,
          child: DrawerHeader(
            child: Image(
              image: AssetImage('images/picturecontent/travel.jpg'),
              fit: BoxFit.fill,
            ),
            // Text(
            //   'Navigation Drawer',
            //   style: TextStyle(
            //     fontSize: 20,
            //   ),
            // ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.content_copy_outlined),
          title: Text('หน้าหลัก'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuser.home);
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_support_outlined),
          title: Text('ข้อมูลการท่องเที่ยว'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuser.picturecomponent);
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_support_outlined),
          title: Text('เกี่ยวกับเรา'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuser.aboutme);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('ออกจากระบบ'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuser.login);
          },
        ),
      ],
    ),
  );
}
