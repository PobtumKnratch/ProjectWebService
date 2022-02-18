import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/widget/routeuser.dart';
import 'package:google_fonts/google_fonts.dart';

Widget createDrawer(BuildContext context) {
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
          leading: Icon(Icons.home_outlined, color: Colors.black),
          title: Text(
            'หน้าหลัก',
            style: GoogleFonts.kanit(color: Colors.black,fontSize: 14),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuser.home);
          },
        ),
        ListTile(
          leading: Icon(Icons.travel_explore, color: Colors.black),
          title: Text(
            'ข้อมูลการท่องเที่ยว',
            style: GoogleFonts.kanit(color: Colors.black,fontSize: 14),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuser.picturecomponent);
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_support_outlined, color: Colors.black),
          title: Text(
            'เกี่ยวกับเรา',
            style: GoogleFonts.kanit(color: Colors.black,fontSize: 14),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuser.aboutme);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app, color: Colors.black),
          title: Text(
            'ออกจากระบบ',
            style: GoogleFonts.kanit(color: Colors.black,fontSize: 14),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeuser.login);
          },
        ),
      ],
    ),
  );
}
