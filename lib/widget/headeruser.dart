import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project_web_supportandservice/Model/user_login.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/Category/Categories.dart';
import 'package:flutter_project_web_supportandservice/states/Page/aboutmeuser.dart';
import 'package:flutter_project_web_supportandservice/states/Page/homeuser.dart';
import 'package:flutter_project_web_supportandservice/states/Page/login.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/picture_components.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruser.dart';
import 'package:flutter_project_web_supportandservice/widget/routeuser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu_item.dart';

class HeaderBar extends StatefulWidget {
  // const HeaderBar({ Key? key }) : super(key: key);
  late double opacity;
  HeaderBar(this.opacity);
  @override
  _HeaderBarState createState() => _HeaderBarState();
}

class _HeaderBarState extends State<HeaderBar> {
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
    return 
    // Responsive(
    //   mobile: IconButton(onPressed: () {
    //     createDrawer(context);
    //   }, icon: Icon(Icons.access_alarm_rounded)),
    //   // Scaffold(backgroundColor: Colors.amber,drawer: Drawer(backgroundColor: Colors.amber,child: Text('data'),)),
    //   tablet: Drawer(),
    //   desktop: PreferredSize(
    //     preferredSize: Size(size.width, 70),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.white38,
    //             blurRadius: 10.0,
    //             spreadRadius: 1.0,
    //             offset: Offset(2.0, 2.0),
    //           ),
    //         ],
    //         color: Colors.greenAccent.shade700,
    //       ),
    //       height: 75,
    //       // color: Colors.greenAccent.shade100,
    //       child: Row(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 60),
    //             child: Image(
    //               image: AssetImage('images/pictureicon/logo.png'),
    //               width: 40,
    //             ),
    //           ),
    //           SizedBox(
    //             width: size.width / 70,
    //           ),
    //           Text(
    //             'NAVANURAK',
    //             style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.w500,
    //                 letterSpacing: 3),
    //           ),
    //           SizedBox(
    //             width: size.width / 45,
    //           ),
    //           if (!Responsive.isMobileContent(context))
    //             InkWell(
    //               onHover: (value) {
    //                 setState(() {
    //                   value ? _isHovering[0] = true : _isHovering[0] = false;
    //                 });
    //               },
    //               onTap: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => HomeUser(),
    //                   ),
    //                 );
    //               },
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Text(
    //                     'หน้าหลัก',
    //                     style: GoogleFonts.kanit(
    //                       textStyle: TextStyle(
    //                         color: _isHovering[0] ? Colors.black : Colors.black,
    //                         fontSize: 18,
    //                       ),
    //                     ),
    //                   ),
    //                   Visibility(
    //                     maintainAnimation: true,
    //                     maintainState: true,
    //                     maintainSize: true,
    //                     visible: _isHovering[0],
    //                     child: Container(
    //                       height: 2,
    //                       width: 50,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           SizedBox(
    //             width: size.width / 35,
    //           ),
    //           InkWell(
    //             onHover: (value) {
    //               setState(() {
    //                 value ? _isHovering[1] = true : _isHovering[1] = false;
    //               });
    //             },
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => AboutMePage(),
    //                 ),
    //               );
    //             },
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Text(
    //                   'เกี่ยวกับเรา',
    //                   style: GoogleFonts.kanit(
    //                     textStyle: TextStyle(
    //                       color: _isHovering[1] ? Colors.black : Colors.black,
    //                       fontSize: 18,
    //                     ),
    //                   ),
    //                 ),
    //                 Visibility(
    //                   maintainAnimation: true,
    //                   maintainState: true,
    //                   maintainSize: true,
    //                   visible: _isHovering[1],
    //                   child: Container(
    //                     height: 2,
    //                     width: 50,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(
    //             width: size.width / 35,
    //           ),
    //           InkWell(
    //             onHover: (value) {
    //               setState(() {
    //                 value ? _isHovering[2] = true : _isHovering[2] = false;
    //               });
    //             },
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => PictureComponents(),
    //                 ),
    //               );
    //             },
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Text(
    //                   'ข้อมูลการท่องเที่ยว',
    //                   style: GoogleFonts.kanit(
    //                     textStyle: TextStyle(
    //                       color: _isHovering[2] ? Colors.black : Colors.black,
    //                       fontSize: 18,
    //                     ),
    //                   ),
    //                 ),
    //                 Visibility(
    //                   maintainAnimation: true,
    //                   maintainState: true,
    //                   maintainSize: true,
    //                   visible: _isHovering[2],
    //                   child: Container(
    //                     height: 2,
    //                     width: 100,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(
    //             width: size.width / 35,
    //           ),
    //           InkWell(
    //             onHover: (value) {
    //               setState(() {
    //                 value ? _isHovering[3] = true : _isHovering[3] = false;
    //               });
    //             },
    //             onTap: () async {
    //               SharedPreferences preferences =
    //                   await SharedPreferences.getInstance();
    //               preferences.clear().then(
    //                     (value) => Navigator.pushNamedAndRemoveUntil(
    //                         context, '/login', (route) => false),
    //                   );
    //               exit(0);
    //             },
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Text(
    //                   'ออกจากระบบ',
    //                   style: GoogleFonts.kanit(
    //                     textStyle: TextStyle(
    //                       color: _isHovering[3] ? Colors.black : Colors.black,
    //                       fontSize: 18,
    //                     ),
    //                   ),
    //                 ),
    //                 Visibility(
    //                   maintainAnimation: true,
    //                   maintainState: true,
    //                   maintainSize: true,
    //                   visible: _isHovering[3],
    //                   child: Container(
    //                     height: 2,
    //                     width: 60,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Spacer(),
    //           Padding(
    //             padding: const EdgeInsets.only(right: 30),
    //             child: Text(
    //               firstname == null ? 'firstname ' : ' User : $firstname',
    //               // 'User',
    //               style: GoogleFonts.kanit(
    //                 textStyle: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           if (Responsive.isMobileContent(context))
    //             IconButton(
    //               icon: Icon(Icons.menu),
    //               onPressed: () {
    //                 Scaffold.of(context).openEndDrawer();
    //               },
    //             ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    PreferredSize(
      preferredSize: Size(size.width, 70),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white38,
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
          color: Colors.greenAccent.shade700,
        ),
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
                      builder: (context) => HomeUser(),
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
                    builder: (context) => AboutMePage(),
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
                    builder: (context) => PictureComponents(),
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
                firstname == null ? 'firstname ' : ' User : $firstname',
                // 'User',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            if (Responsive.isMobileContent(context))
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
