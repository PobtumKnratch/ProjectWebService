import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/widget/routeuseredit.dart';

Widget createDraweredit(BuildContext context) {
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
            Navigator.pushReplacementNamed(context, routeuseredit.homeuseredit);
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_support_outlined),
          title: Text('จัดการข้อมูลรูปภาพ'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuseredit.editdata);
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_support_outlined),
          title: Text('เกี่ยวกับเรา'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuseredit.aboutmeeditor);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('ออกจากระบบ'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuseredit.login);
          },
        ),
      ],
    ),
  );
}
