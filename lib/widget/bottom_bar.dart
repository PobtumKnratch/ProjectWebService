import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/widget/bottom_bar_column.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBar extends StatelessWidget {
  BottomBar({
    Key? key,
  }) : super(key: key);

  static const Color gradientStartColor = Color(0xff11998e);
  static const Color gradientEndColor = Color(0xff0575E6);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Responsive(
      mobile: Container(
        // margin: EdgeInsets.only(top: size.height * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: gradientStartColor,
              offset: Offset(1.0, 6.0),
              blurRadius: 1.0,
            ),
            BoxShadow(
              color: gradientEndColor,
              offset: Offset(1.0, 6.0),
              blurRadius: 1.0,
            ),
          ],
          gradient: LinearGradient(
              colors: [gradientStartColor, gradientEndColor],
              begin: const FractionalOffset(0.2, 0.2),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),

        //color: Colors.blueGrey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: AssetImage('images/pictureicon/logo.png'),
                width: size.width * 0.12,
                height: size.height * 0.12,
              ),
            ),
            Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'เกี่ยวกับเรา',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Text(
                      '"ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" \nเป็นระบบส่วนเสริมที่มีการนำข้อมูลของคลัง\nข้อมูลรูปภาพ อว. หรือกระทรวงการอุดมศึกษา \nวิทยาศาสตร์วิจัยและนวัตกรรม เป็นระบบที่เป็น\nการนำข้อมูลมาใช้ในการของการบริการข้อมูล\nให้กับประชาชนในการค้นหาหรือดูข้อมูลจาก\nคลังข้อมูลของโครงการโดยทางโครงการได้\nมีข้อมูลทั้งหมด 4 หมวด ประกอบด้วย \nหมวดท่องเที่ยว หมวดอาหาร หมวดป้าย\nสถานที่และหมวดสถานการณ์',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.white, fontSize: 7),
                      ),
                      // textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(right: size.width * 0.06),
                  width: 2,
                  height: 110,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ติดต่อเรา',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Text(
                      'ศูนย์เทคโนโลยีอิเล็กทรอนิกส์และ\nคอมพิวเตอร์แห่งชาติ 112 \nถนนพหลโยธิน ตำบลคลองหนึ่ง \nอำเภอคลองหลวง\nจังหวัดปทุมธานี 12120\nโทรศัพท์ 02-564-6900 \nโทรสาร 02-564-6901-3\nอีเมล info@nectec.or.th',
                      style: GoogleFonts.kanit(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 8)),
                    )
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            Center(
              child: Text(
                'Copyright © 2021 | ศูนย์เทคโนโลยีอิเล็กทรอนิกส์และคอมพิวเตอร์แห่งชาติ 2565',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 7,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Container(
      //   margin: EdgeInsets.only(top: size.height * 0.01),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.all(Radius.circular(0.0)),
      //     boxShadow: <BoxShadow>[
      //       BoxShadow(
      //         color: gradientStartColor,
      //         offset: Offset(1.0, 6.0),
      //         blurRadius: 1.0,
      //       ),
      //       BoxShadow(
      //         color: gradientEndColor,
      //         offset: Offset(1.0, 6.0),
      //         blurRadius: 1.0,
      //       ),
      //     ],
      //     gradient: LinearGradient(
      //         colors: [gradientStartColor, gradientEndColor],
      //         begin: const FractionalOffset(0.2, 0.2),
      //         end: const FractionalOffset(1.0, 1.0),
      //         stops: [0.0, 1.0],
      //         tileMode: TileMode.clamp),
      //   ),
      //   padding: EdgeInsets.all(30),
      //   //color: Colors.blueGrey[900],
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       BottomBarColumn(
      //         heading: 'เกี่ยวกับเรา',
      //       ),
      //       Text(
      //         '"ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" \nเป็นระบบส่วนเสริมที่มีการนำข้อมูลของคลัง\nข้อมูลรูปภาพ อว. หรือกระทรวงการอุดมศึกษา\nวิทยาศาสตร์วิจัยและนวัตกรรม เป็นระบบที่เป็น\nการนำข้อมูลมาใช้ในการของการบริการข้อมูลให้\nกับประชาชนในการค้นหาหรือดูข้อมูลจากคลัง\nข้อมูลของโครงการโดยทางโครงการได้มีข้อมูล\nทั้งหมด 4 หมวด ประกอบด้วย หมวดท่องเที่ยว \nหมวดอาหาร หมวดป้ายสถานที่และหมวดสถานการณ์',
      //         style: GoogleFonts.kanit(
      //           textStyle: TextStyle(color: Colors.white, fontSize: 8),
      //         ),
      //         textAlign: TextAlign.left,
      //       ),
      //       // Image(
      //       //   image: AssetImage('images/pictureicon/logo.png'),
      //       //   width: size.width * 0.12,
      //       //   height: size.height * 0.12,
      //       // ),
      //       BottomBarColumn(
      //         heading: 'ติดต่อเรา',
      //       ),
      //       Text(
      //         'ศูนย์เทคโนโลยีอิเล็กทรอนิกส์และคอมพิวเตอร์แห่งชาติ \n112 ถนนพหลโยธิน ตำบลคลองหนึ่ง อำเภอคลองหลวง\nจังหวัดปทุมธานี 12120\nโทรศัพท์ 02-564-6900 โทรสาร 02-564-6901-3\nอีเมล info@nectec.or.th',
      //         style: GoogleFonts.kanit(
      //             textStyle: TextStyle(
      //           color: Colors.white,fontSize: 8
      //         )),
      //       ),
      //       Divider(
      //         color: Colors.white,
      //       ),
      //       // SizedBox(height: 5),
      //       Center(
      //         child: Text(
      //           'Copyright © 2021 | ศูนย์เทคโนโลยีอิเล็กทรอนิกส์และคอมพิวเตอร์แห่งชาติ 2565',
      //           style: GoogleFonts.kanit(
      //             textStyle: TextStyle(
      //               color: Colors.white,
      //               fontSize: 6,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      tablet: Container(
        // margin: EdgeInsets.only(top: size.height * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: gradientStartColor,
              offset: Offset(1.0, 6.0),
              blurRadius: 1.0,
            ),
            BoxShadow(
              color: gradientEndColor,
              offset: Offset(1.0, 6.0),
              blurRadius: 1.0,
            ),
          ],
          gradient: LinearGradient(
              colors: [gradientStartColor, gradientEndColor],
              begin: const FractionalOffset(0.2, 0.2),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),

        //color: Colors.blueGrey[900],
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image(
                  image: AssetImage('images/pictureicon/logo.png'),
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เกี่ยวกับเรา',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          '"ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" เป็นระบบส่วนเสริมที่มีการ\nนำข้อมูลของคลังข้อมูลรูปภาพ อว. หรือกระทรวงการอุดมศึกษา \nวิทยาศาสตร์วิจัยและนวัตกรรม เป็นระบบที่เป็นการนำข้อมูลมาใช้ในการ\nของการบริการข้อมูลให้กับประชาชนในการค้นหาหรือดูข้อมูลจากคลัง\nข้อมูลของโครงการโดยทางโครงการได้มีข้อมูลทั้งหมด 4 หมวด \nประกอบด้วย หมวดท่องเที่ยว หมวดอาหาร หมวดป้ายสถานที่และ\nหมวดสถานการณ์',
                          style: GoogleFonts.kanit(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 9),
                          ),
                          // textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(right: size.width * 0.04),
                      width: 2,
                      height: 120,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ติดต่อเรา',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          'ศูนย์เทคโนโลยีอิเล็กทรอนิกส์และคอมพิวเตอร์แห่งชาติ 112 \nถนนพหลโยธิน ตำบลคลองหนึ่ง อำเภอคลองหลวง\nจังหวัดปทุมธานี 12120\nโทรศัพท์ 02-564-6900 โทรสาร 02-564-6901-3\nอีเมล info@nectec.or.th',
                          style: GoogleFonts.kanit(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Center(
                child: Text(
                  'Copyright © 2021 | ศูนย์เทคโนโลยีอิเล็กทรอนิกส์และคอมพิวเตอร์แห่งชาติ 2565',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 7,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      desktop: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: gradientStartColor,
              offset: Offset(1.0, 6.0),
              blurRadius: 1.0,
            ),
            BoxShadow(
              color: gradientEndColor,
              offset: Offset(1.0, 6.0),
              blurRadius: 1.0,
            ),
          ],
          gradient: LinearGradient(
              colors: [gradientStartColor, gradientEndColor],
              begin: const FractionalOffset(0.2, 0.2),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        padding: EdgeInsets.all(30),
        //color: Colors.blueGrey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image(
                    image: AssetImage('images/pictureicon/logo.png'),
                    width: size.width * 0.18,
                    height: size.height * 0.18,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BottomBarColumn(
                      heading: 'เกี่ยวกับเรา',
                    ),
                    Text(
                      '"ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" เป็นระบบส่วนเสริมที่มีการนำข้อมูลของคลังข้อมูล\nรูปภาพ อว. หรือกระทรวงการอุดมศึกษา วิทยาศาสตร์วิจัยและนวัตกรรม เป็นระบบที่เป็นการนำ\nข้อมูลมาใช้ในการของการบริการข้อมูลให้กับประชาชนในการค้นหาหรือดูข้อมูลจากคลังข้อมูลของ\nโครงการโดยทางโครงการได้มีข้อมูลทั้งหมด 4 หมวด ประกอบด้วย หมวดท่องเที่ยว หมวดอาหาร \nหมวดป้ายสถานที่และหมวดสถานการณ์',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.white),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: size.width * 0.02),
                  width: 2,
                  height: 150,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BottomBarColumn(
                        heading: 'ติดต่อเรา',
                      ),
                      Text(
                        'ศูนย์เทคโนโลยีอิเล็กทรอนิกส์และคอมพิวเตอร์แห่งชาติ \n112 ถนนพหลโยธิน ตำบลคลองหนึ่ง อำเภอคลองหลวง\nจังหวัดปทุมธานี 12120\nโทรศัพท์ 02-564-6900 โทรสาร 02-564-6901-3\nอีเมล info@nectec.or.th',
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                          color: Colors.white,
                        )),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Copyright © 2021 | ศูนย์เทคโนโลยีอิเล็กทรอนิกส์และคอมพิวเตอร์แห่งชาติ 2565',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
