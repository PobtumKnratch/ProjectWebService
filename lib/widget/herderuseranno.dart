import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/Page/aboutmeanno.dart';
import 'package:flutter_project_web_supportandservice/states/Page/homeuseranno.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/user_annopage.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/useranno_picture.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/picture_components.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderBarAnno extends StatefulWidget {
  //  HeaderBarAnno({ Key? key }) : super(key: key);
    late double opacity;
  HeaderBarAnno(this.opacity);

  @override
  _HeaderBarAnnoState createState() => _HeaderBarAnnoState();
}

class _HeaderBarAnnoState extends State<HeaderBarAnno> {
   final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  String? firstname;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      firstname = preferences.getString('firstname');
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size(size.width, 70),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.white38,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(2.0, 2.0),
          ),
        ], color: Colors.greenAccent.shade700,),
        height: 75,
        // color: Colors.greenAccent.shade100,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Image(
                image: AssetImage('images/pictureicon/logo.png'),
                width: 40,
              ),
            ),
            SizedBox(
              width: size.width / 70,
            ),
            Text(
              'NAVANURAK',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 3),
            ),
            SizedBox(
              width: size.width / 45,
            ),
            if (!Responsive.isMobileContent(context))
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[0] = true : _isHovering[0] = false;
                  });
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeUserAnno(),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'หน้าหลัก',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: _isHovering[0] ? Colors.black : Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Visibility(
                      maintainAnimation: true,
                      maintainState: true,
                      maintainSize: true,
                      visible: _isHovering[0],
                      child: Container(
                        height: 2,
                        width: 50,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              width: size.width / 35,
            ),
            InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[1] = true : _isHovering[1] = false;
                });
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutMeAnnoPage(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'เกี่ยวกับเรา',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: _isHovering[1] ? Colors.black : Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Visibility(
                    maintainAnimation: true,
                    maintainState: true,
                    maintainSize: true,
                    visible: _isHovering[1],
                    child: Container(
                      height: 2,
                      width: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width / 35,
            ),
            InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[2] = true : _isHovering[2] = false;
                });
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserAnnoData(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ตรวจสอบข้อมูลรูปภาพ',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: _isHovering[2] ? Colors.black : Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Visibility(
                    maintainAnimation: true,
                    maintainState: true,
                    maintainSize: true,
                    visible: _isHovering[2],
                    child: Container(
                      height: 2,
                      width: 100,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width / 35,
            ),
            InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[3] = true : _isHovering[3] = false;
                });
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                   builder: (context) => UserAnnoPicture(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ข้อมูลการท่องเที่ยว',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: _isHovering[3] ? Colors.black : Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Visibility(
                    maintainAnimation: true,
                    maintainState: true,
                    maintainSize: true,
                    visible: _isHovering[3],
                    child: Container(
                      height: 2,
                      width: 100,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width / 35,
            ),
            InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[4] = true : _isHovering[4] = false;
                });
              },
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.clear().then(
                      (value) => Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false),
                    );
                    exit(0);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ออกจากระบบ',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: _isHovering[4] ? Colors.black : Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Visibility(
                    maintainAnimation: true,
                    maintainState: true,
                    maintainSize: true,
                    visible: _isHovering[4],
                    child: Container(
                      height: 2,
                      width: 60,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                // 'ANNOTATOR',
                firstname == null ? 'firstname ' : 'Annotation : $firstname',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            if (Responsive?.isMobileContent(context))
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
          ],
        ),
      ),
    );
  }
}