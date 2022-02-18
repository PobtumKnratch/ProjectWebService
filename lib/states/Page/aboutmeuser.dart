import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/model_aboutme.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/components/about/aboutme_card.dart';
import 'package:flutter_project_web_supportandservice/states/components/about/aboutme_carousel.dart';
import 'package:flutter_project_web_supportandservice/widget/bottom_bar.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruser.dart';
import 'package:flutter_project_web_supportandservice/widget/headeruser.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutMePage extends StatefulWidget {
  AboutMePage({Key? key}) : super(key: key);
  static const String routeName = '/aboutme';

  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  late double _opacity = 0;

  final icon = [
    Icons.travel_explore_outlined,
    Icons.fastfood_rounded,
    Icons.bedroom_parent_outlined,
    Icons.schedule_send_outlined,
  ];

  final List<String> titlehead = [
    'หมวดท่องเที่ยว',
    'หมวดอาหาร',
    'หมวดป้ายสถานที่',
    'หมวดสถานการณ์',
  ];

  final List<String> titlesub = [
    'ข้อมูลพิกัดสถานที่ภายในรูปภาพ',
    'คำอธิบายรูปภาพประกอบ',
    'วันเวลาของข้อมูลรูปภาพ',
    'รูปแบบของข้อมูลที่มีความหลากหลาย',
  ];

  bool isHover = false;
  Duration duration = Duration(milliseconds: 200);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: size.width < 1200
          ? AppBar(
              iconTheme: IconThemeData(color: Colors.black, size: 20),
              elevation: 0,
              backgroundColor: Colors.greenAccent.shade700,
              title: Row(
                children: [
                  Image(
                    image: AssetImage('images/pictureicon/logo.png'),
                    width: 25,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    'NAVANURAK',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : PreferredSize(
              preferredSize: Size(size.width, 70),
              child: HeaderBar(_opacity),
            ),
      // drawer: createDrawer(context),
      extendBodyBehindAppBar: true,
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: createDrawer(context),
      ),
      body: Responsive(
        mobile: Container(
          color: Colors.greenAccent.shade100,
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.07),
                  child: Container(
                    height: size.height / 1.8,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.14),
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'เกี่ยวกับเรา',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    fontSize: 10,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.01),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 5,
                                    child: Image.asset(
                                      'images/picturecontent/wat.jpg',
                                      fit: BoxFit.fill,
                                      height: size.height * 0.25,
                                      width: size.width,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.02,
                                          // left: size.width * 0.02,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ',
                                            style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                fontSize: 9,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.05,
                                            top: size.height * 0.01),
                                        child: Text(
                                          '"ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" เป็นระบบส่วนเสริมที่มีการนำข้อมูลของ\nคลังข้อมูลรูปภาพ อว. หรือกระทรวงการอุดมศึกษา วิทยาศาสตร์วิจัยและนวัตกรรม เป็นระบบที่เป็นการนำข้อมูลมาใช้ในการของการบริการข้อมูลให้กับประชาชนในการ\nค้นหาหรือดูข้อมูลจากคลังข้อมูลของโครงการโดยทางโครงการได้มีข้อมูลทั้งหมด \n4 หมวด ประกอบด้วย  ',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                              fontSize: 7,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: size.width * 0.05,
                                          // top: size.height * 0.01,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(
                                            //     width: screenSize.width / 15),
                                            ...Iterable<int>.generate(
                                                    icon.length)
                                                .map(
                                              (int index) => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    icon[index],
                                                    color: Colors
                                                        .greenAccent.shade700,
                                                    size: 10,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            size.width * 0.02),
                                                    child: Text(
                                                      titlehead[index],
                                                      style: GoogleFonts.kanit(
                                                        textStyle: TextStyle(
                                                          fontSize: 7,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.55,
                  width: size.width,
                  decoration: BoxDecoration(
                      // color: Colors.blue,
                      ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.14),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'เนื้อหาของคลังข้อมูลรูปภาพ อว.',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: 9,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.01),
                            child: Container(
                              child: AboutMeCarousel(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.025,
                              // left: size.width * 0.05,
                            ),
                            child: Center(
                              child: Text(
                                'ข้อมูลของคลังข้อมูลรูปภาพ อว. เป็นข้อมูลที่ได้จากการเก็บรวบรวมโดย\nเป็นความร่วมมือระหว่างนักวิจัยกับประชาชนโดยมีประชาชนเป็นผู้เก็บรวบ\nรวมข้อมูลดังกล่าวบันทึกลงบนคลังข้อมูลรูปภาพซึ่งรายละเอียดของข้อมูล\nต่างๆที่ถูกบันทึกลงจะประกอบด้วย',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.09,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(width: screenSize.width / 15),
                                ...Iterable<int>.generate(icon.length).map(
                                  (int index) => Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.greenAccent.shade700,
                                        size: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.02),
                                        child: Text(
                                          titlesub[index],
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                              fontSize: 7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.45,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.14),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'รูปแบบการใช้งาน',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: 9,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Center(
                            child: Text(
                              'การใช้งาน "ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" มีขั้นตอนดังนี้',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: 7,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              left: size.width * 0.02,
                              right: size.width * 0.02,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      onHover: (value) {
                                        setState(() {
                                          isHover = value;
                                        });
                                      },
                                      hoverColor: Colors.transparent,
                                      child: AnimatedContainer(
                                        duration: duration,
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.height * 0.01),
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFD9FFFC),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            if (isHover)
                                              BoxShadow(
                                                offset: Offset(0, 20),
                                                blurRadius: 50,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                              ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              duration: duration,
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding * 0.5),
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  if (!isHover)
                                                    BoxShadow(
                                                      offset: Offset(0, 20),
                                                      blurRadius: 30,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                    ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                "images/pictureicon/searchdata.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                                height: AppConst.padding * 1),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                "สามารถทำการค้นหาสถานที่ท่องเที่ยว",
                                                style: GoogleFonts.kanit(
                                                  textStyle: TextStyle(
                                                    fontSize: 7,
                                                  ),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      onHover: (value) {
                                        setState(() {
                                          isHover = value;
                                        });
                                      },
                                      hoverColor: Colors.transparent,
                                      child: AnimatedContainer(
                                        duration: duration,
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.height * 0.01),
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE4FFC7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            if (isHover)
                                              BoxShadow(
                                                offset: Offset(0, 20),
                                                blurRadius: 50,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                              ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              duration: duration,
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding * 0.5),
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  if (!isHover)
                                                    BoxShadow(
                                                      offset: Offset(0, 20),
                                                      blurRadius: 30,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                    ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                "images/pictureicon/location.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                                height: AppConst.padding * 1),
                                            Text(
                                              "สามารถดูข้อมูลจากคลัง\nข้อมูลรูปภาพ",
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 7,
                                                ),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      onHover: (value) {
                                        setState(() {
                                          isHover = value;
                                        });
                                      },
                                      hoverColor: Colors.transparent,
                                      child: AnimatedContainer(
                                        duration: duration,
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.height * 0.01),
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFF3DD),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            if (isHover)
                                              BoxShadow(
                                                offset: Offset(0, 20),
                                                blurRadius: 50,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                              ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              duration: duration,
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding * 0.5),
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  if (!isHover)
                                                    BoxShadow(
                                                      offset: Offset(0, 20),
                                                      blurRadius: 30,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                    ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                "images/pictureicon/usereditor.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                                height: AppConst.padding * 1),
                                            Text(
                                              "สามารถเข้าสู่ระบบผู้ใช้งานเพื่อ\nทำการจัดการข้อมูลคลังรูปภาพ",
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 7,
                                                ),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      onHover: (value) {
                                        setState(() {
                                          isHover = value;
                                        });
                                      },
                                      hoverColor: Colors.transparent,
                                      child: AnimatedContainer(
                                        duration: duration,
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.height * 0.01),
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFE0E0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            if (isHover)
                                              BoxShadow(
                                                offset: Offset(0, 20),
                                                blurRadius: 50,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                              ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              duration: duration,
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding * 0.5),
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  if (!isHover)
                                                    BoxShadow(
                                                      offset: Offset(0, 20),
                                                      blurRadius: 30,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                    ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                "images/pictureicon/anno.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                                height: AppConst.padding * 1),
                                            Text(
                                              "สามารถตรวจสอบข้อมูลรูปภาพ\nได้จากการเข้าสู่ระบบ",
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 7,
                                                ),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                BottomBar(),
              ],
            ),
          ),
        ),
        tablet: Container(
          color: Colors.greenAccent.shade100,
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.04),
                  child: Container(
                    height: size.height * 0.5,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.14),
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'เกี่ยวกับเรา',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.01),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 5,
                                    child: Image.asset(
                                      'images/picturecontent/wat.jpg',
                                      fit: BoxFit.cover,
                                      height: size.height * 0.25,
                                      width: size.width,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.02,
                                          // left: size.width * 0.02,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ',
                                            style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                fontSize: 11,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.05,
                                            top: size.height * 0.01),
                                        child: Text(
                                          '"ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" เป็นระบบส่วนเสริมที่มีการนำข้อมูลของคลังข้อมูลรูปภาพ อว. หรือกระทรวงการอุดมศึกษา\nวิทยาศาสตร์วิจัยและนวัตกรรม เป็นระบบที่เป็นการนำข้อมูลมาใช้ในการของการบริการข้อมูลให้กับประชาชนในการค้นหาหรือดูข้อมูลจาก\nคลังข้อมูลของโครงการโดยทางโครงการได้มีข้อมูลทั้งหมด 4 หมวด ประกอบด้วย  ',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                              fontSize: 9,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: size.width * 0.05,
                                          top: size.height * 0.01,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(
                                            //     width: screenSize.width / 15),
                                            ...Iterable<int>.generate(
                                                    icon.length)
                                                .map(
                                              (int index) => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    icon[index],
                                                    color: Colors
                                                        .greenAccent.shade700,
                                                    size: 12,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            size.width * 0.02),
                                                    child: Text(
                                                      titlehead[index],
                                                      style: GoogleFonts.kanit(
                                                        textStyle: TextStyle(
                                                          fontSize: 9,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.55,
                  width: size.width,
                  decoration: BoxDecoration(
                      // color: Colors.blue,
                      ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.14),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'เนื้อหาของคลังข้อมูลรูปภาพ อว.',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: 11,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.01),
                            child: Container(
                              child: AboutMeCarousel(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.085,
                              top: size.height * 0.025,
                            ),
                            child: Text(
                              'ข้อมูลของคลังข้อมูลรูปภาพ อว. เป็นข้อมูลที่ได้จากการเก็บรวบรวมโดยเป็นความร่วมมือระหว่างนักวิจัยกับประชาชนโดย\nมีประชาชนเป็นผู้เก็บรวบรวมข้อมูลดังกล่าวบันทึกลงบนคลังข้อมูลรูปภาพซึ่งรายละเอียดของข้อมูลต่างๆที่ถูกบันทึกลง\nจะประกอบด้วย',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.09,
                              top: size.height * 0.01,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(width: screenSize.width / 15),
                                ...Iterable<int>.generate(icon.length).map(
                                  (int index) => Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.greenAccent.shade700,
                                        size: 12,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.02),
                                        child: Text(
                                          titlesub[index],
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                              fontSize: 9,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.3,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'รูปแบบการใช้งาน',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: 11,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Center(
                            child: Text(
                              'การใช้งาน "ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" มีขั้นตอนดังนี้',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: size.height * 0.02),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     children: List.generate(aboutme.length,
                          //         (index) => AboutMeCard(index: index)),
                          //   ),
                          // )
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.01,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      onHover: (value) {
                                        setState(() {
                                          isHover = value;
                                        });
                                      },
                                      hoverColor: Colors.transparent,
                                      child: AnimatedContainer(
                                        duration: duration,
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.height * 0.01),
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFD9FFFC),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            if (isHover)
                                              BoxShadow(
                                                offset: Offset(0, 20),
                                                blurRadius: 50,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                              ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              duration: duration,
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding * 0.5),
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  if (!isHover)
                                                    BoxShadow(
                                                      offset: Offset(0, 20),
                                                      blurRadius: 30,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                    ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                "images/pictureicon/searchdata.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                                height: AppConst.padding * 1),
                                            Text(
                                              "สามารถทำการค้นหาสถานที่ท่องเที่ยว",
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 9,
                                                ),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      onHover: (value) {
                                        setState(() {
                                          isHover = value;
                                        });
                                      },
                                      hoverColor: Colors.transparent,
                                      child: AnimatedContainer(
                                        duration: duration,
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.height * 0.01),
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE4FFC7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            if (isHover)
                                              BoxShadow(
                                                offset: Offset(0, 20),
                                                blurRadius: 50,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                              ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              duration: duration,
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding * 0.5),
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  if (!isHover)
                                                    BoxShadow(
                                                      offset: Offset(0, 20),
                                                      blurRadius: 30,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                    ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                "images/pictureicon/location.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                                height: AppConst.padding * 1),
                                            Text(
                                              "สามารถดูข้อมูลจากคลังข้อมูลรูปภาพ",
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 9,
                                                ),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      onHover: (value) {
                                        setState(() {
                                          isHover = value;
                                        });
                                      },
                                      hoverColor: Colors.transparent,
                                      child: AnimatedContainer(
                                        duration: duration,
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.height * 0.01),
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFF3DD),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            if (isHover)
                                              BoxShadow(
                                                offset: Offset(0, 20),
                                                blurRadius: 50,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                              ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              duration: duration,
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding * 0.5),
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  if (!isHover)
                                                    BoxShadow(
                                                      offset: Offset(0, 20),
                                                      blurRadius: 30,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                    ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                "images/pictureicon/usereditor.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                                height: AppConst.padding * 1),
                                            Text(
                                              "สามารถเข้าสู่ระบบผู้ใช้งานเพื่อทำการ\nจัดการข้อมูลคลังรูปภาพ",
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 9,
                                                ),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      onHover: (value) {
                                        setState(() {
                                          isHover = value;
                                        });
                                      },
                                      hoverColor: Colors.transparent,
                                      child: AnimatedContainer(
                                        duration: duration,
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.height * 0.01),
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFE0E0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            if (isHover)
                                              BoxShadow(
                                                offset: Offset(0, 20),
                                                blurRadius: 50,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                              ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              duration: duration,
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding * 0.5),
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  if (!isHover)
                                                    BoxShadow(
                                                      offset: Offset(0, 20),
                                                      blurRadius: 30,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                    ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                "images/pictureicon/anno.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                                height: AppConst.padding * 1),
                                            Text(
                                              "สามารถตรวจสอบข้อมูลรูปภาพ\nได้จากการเข้าสู่ระบบ",
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 9,
                                                ),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BottomBar(),
              ],
            ),
          ),
        ),
        desktop: Container(
          color: Colors.greenAccent.shade100,
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.09),
                  child: Container(
                    height: size.height / 1.8,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.14),
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'เกี่ยวกับเรา',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: screenSize.width / 65,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    child: Image.asset(
                                      'images/picturecontent/wat.jpg',
                                      fit: BoxFit.fill,
                                      height: size.height * 0.37,
                                      width: size.width * 0.3,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.02,
                                          left: size.width * 0.02,
                                        ),
                                        child: Text(
                                          'ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                              fontSize: screenSize.width / 75,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.02,
                                            top: size.height * 0.01),
                                        child: Text(
                                          '"ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" เป็นระบบส่วนเสริมที่มีการนำข้อมูลของคลังข้อมูล\nรูปภาพ อว. หรือกระทรวงการอุดมศึกษา วิทยาศาสตร์วิจัยและนวัตกรรม เป็นระบบที่เป็นการนำ\nข้อมูลมาใช้ในการของการบริการข้อมูลให้กับประชาชนในการค้นหาหรือดูข้อมูลจากคลังข้อมูลของ\nโครงการโดยทางโครงการได้มีข้อมูลทั้งหมด 4 หมวด ประกอบด้วย  ',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                              fontSize: screenSize.width / 100,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.02,
                                            top: size.height * 0.02),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: screenSize.width / 15),
                                            ...Iterable<int>.generate(
                                                    icon.length)
                                                .map(
                                              (int index) => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    icon[index],
                                                    color: Colors
                                                        .greenAccent.shade700,
                                                    size: 18,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            size.width * 0.004),
                                                    child: Text(
                                                      titlehead[index],
                                                      style: GoogleFonts.kanit(
                                                        textStyle: TextStyle(
                                                          fontSize:
                                                              screenSize.width /
                                                                  100,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height / 1.6,
                  width: size.width,
                  decoration: BoxDecoration(
                      // color: Colors.blue,
                      ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.14),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.1,
                                    left: size.width * 0.02),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'เนื้อหาของคลังข้อมูลรูปภาพ อว.',
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                          fontSize: screenSize.width / 75,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      'ข้อมูลของคลังข้อมูลรูปภาพ อว. เป็นข้อมูลที่ได้จากการ\nเก็บรวบรวมโดยเป็นความร่วมมือระหว่างนักวิจัยกับประชาชน\nโดยมีประชาชนเป็นผู้เก็บรวบรวมข้อมูลดังกล่าวบันทึกลงบน\nคลังข้อมูลรูปภาพซึ่งรายละเอียดของข้อมูลต่างๆที่ถูกบันทึก\nลงจะประกอบด้วย',
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                          fontSize: screenSize.width / 100,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: screenSize.width / 15),
                                        ...Iterable<int>.generate(icon.length)
                                            .map(
                                          (int index) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color:
                                                    Colors.greenAccent.shade700,
                                                size: 18,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: size.width * 0.004),
                                                child: Text(
                                                  titlesub[index],
                                                  style: GoogleFonts.kanit(
                                                    textStyle: TextStyle(
                                                      fontSize:
                                                          screenSize.width /
                                                              100,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.01),
                                child: Container(
                                  height: 400,
                                  width: 650,
                                  child: AboutMeCarousel(),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height / 1.5,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.14),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'รูปแบบการใช้งาน',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: screenSize.width / 65,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Center(
                            child: Text(
                              'การใช้งาน "ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" มีขั้นตอนดังนี้',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: screenSize.width / 85,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(aboutme.length,
                                  (index) => AboutMeCard(index: index)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                BottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// // ignore: must_be_immutable
// class AboutMePage extends StatelessWidget {
//   AboutMePage({
//     Key? key,
//   }) : super(key: key);
//   static const String routeName = '/aboutme';
//   late double _opacity = 0;

//   final icon = [
//     Icons.travel_explore_outlined,
//     Icons.fastfood_rounded,
//     Icons.bedroom_parent_outlined,
//     Icons.schedule_send_outlined,
//   ];

//   final List<String> titlehead = [
//     'หมวดท่องเที่ยว',
//     'หมวดอาหาร',
//     'หมวดป้ายสถานที่',
//     'หมวดสถานการณ์',
//   ];

//   final List<String> titlesub = [
//     'ข้อมูลพิกัดสถานที่ภายในรูปภาพ',
//     'คำอธิบายรูปภาพประกอบ',
//     'วันเวลาของข้อมูลรูปภาพ',
//     'รูปแบบของข้อมูลที่มีความหลากหลาย',
//   ];

//   bool isHover = false;
//   Duration duration = Duration(milliseconds: 200);
//   @override
//   Widget build(BuildContext context) {
    
//   }
// }
