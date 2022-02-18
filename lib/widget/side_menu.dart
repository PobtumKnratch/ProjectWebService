import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/states/Page/login.dart';
// import 'package:flutter_project_web_supportandservice/widget/menucontroller.dart';
// import 'package:get/get.dart';

import 'menu_item.dart';

class SideMenu extends StatelessWidget {
  // final MenuController _controller = Get.put(MenuController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return 
    // Scaffold(
      // key: _controller.scaffoldkey,
      // drawer: Drawer(
      //   child: Container(
      //     color: Colors.greenAccent.shade100,
      //     child: ListView(
      //       children: [
      //         DrawerHeader(
      //           child: Padding(
      //             padding: EdgeInsets.symmetric(horizontal: 30),
      //             child: Image(
      //               image: AssetImage('images/logo.png'),
      //               width: 50,
      //             ),
      //           ),
      //         ),
      //         ListTile(
      //           contentPadding: EdgeInsets.symmetric(horizontal: 20),
      //           onTap: () {},
      //           title: Text(
      //             'หน้าหลัก',
      //             style: TextStyle(
      //               color: Colors.black,
      //               fontSize: 18,
      //             ),
      //           ),
      //         ),
              
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    Container(
    height: size.height,
    width: size.width,
    color: Colors.white,
    child: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 5, top: 10),
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.content_copy,
                color: Colors.black,
                size: 30,
              ),
              label: Text(
                'หน้าหลัก',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.contact_page,
                color: Colors.black,
                size: 30,
              ),
              label: Text(
                'เกี่ยวกับเรา',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
                size: 30,
              ),
              label: Text(
                'ออกจากระบบ',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
    // NavItem(
    //   title: 'หน้าหลัก',
    //   tapEvent: () {},
    // ),
    // SizedBox(
    //   height: 10,
    // ),
    // NavItem(
    //   title: 'เกี่ยวกับเรา',
    //   tapEvent: () {},
    // ),
    // SizedBox(
    //   height: 10,
    // ),
    // NavItem(
    //   title: 'คู่มือการใช้งาน',
    //   tapEvent: () {},
    // ),
    // SizedBox(
    //   height: 10,
    // ),
    // NavItem(
    //   title: 'ออกจากระบบ',
    //   tapEvent: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => LoginPage(),
    //       ),
    //     );
    //   },
    // ),
            ],
          ),
        ),
      ),
    );
  }
}
