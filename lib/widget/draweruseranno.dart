import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/widget/routeuseranno.dart';

Widget createDraweranno(BuildContext context) {
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
            Navigator.pushReplacementNamed(context, routeuseranno.homeuseranno);
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_support_outlined),
          title: Text('ตรวจสอบข้อมูลรูปภาพ'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuseranno.annodata);
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_support_outlined),
          title: Text('ข้อมูลการท่องเที่ยว'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuseranno.viewpicture);
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_support_outlined),
          title: Text('เกี่ยวกับเรา'),
          onTap: () {
            Navigator.pushReplacementNamed(
                context, routeuseranno.aboutmeanno);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('ออกจากระบบ'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuseranno.login);
          },
        ),
      ],
    ),
  );
}
