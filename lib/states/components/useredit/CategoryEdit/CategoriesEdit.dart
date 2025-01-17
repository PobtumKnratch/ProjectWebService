import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload2.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload3.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload4.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/CategoryEdit/foodedit.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/CategoryEdit/scenarioedit.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/CategoryEdit/signboardedit.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/CategoryEdit/traveledit.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:flutter_project_web_supportandservice/widget/search_view.dart';
// import 'package:flutter_project_web_supportandservice/states/Category/food.dart';
// import 'package:flutter_project_web_supportandservice/states/Category/scenario.dart';
// import 'package:flutter_project_web_supportandservice/states/Category/signboard.dart';
// import 'package:flutter_project_web_supportandservice/states/Category/travel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesEdit extends StatefulWidget {
  const CategoriesEdit({Key? key}) : super(key: key);

  @override
  _CategoriesEditState createState() => _CategoriesEditState();
}

class _CategoriesEditState extends State<CategoriesEdit> {
    // ignore: unused_field
  Upload? model;
  static const String routeName = '/categories';
  List<Upload> models = [];
  List<Upload2> models2 = [];
  List<Upload3> models3 = [];
  List<Upload4> models4 = [];
  List<Upload> showModel = [];
  List<Upload2> showModel2 = [];
  List<Upload3> showModel3 = [];
  List<Upload4> showModel4 = [];
  List<String> categories = [
    'หมวดการท่องเที่ยว',
    'หมวดตามสถานการณ์',
    'หมวดอาหาร',
    'หมวดป้ายสถานที่',
  ];
  int selectIndex = 0;
  double _scrollPosition = 0;
  // ignore: unused_field
  double _opacity = 0;

  bool isLoading = true;

  String? searchStatus;

  Future<Null> getStart() async {
    models = await getupload();
    showModel = models;
    models2 = await getupload2();
    showModel2 = models2;
    models3 = await getupload3();
    showModel3 = models3;
    models4 = await getupload4();
    showModel4 = models4;
    // print(models2);
    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  // return jsonData;
  @override
  void initState() {
    initData();
    getStart();
    super.initState();
  }

  Future<void> initData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? topic_ic = preferences.getString('topic_id');
    if (topic_ic == '1') {
      List<Upload2> models2 = await selectupload2();
      print('length ===>>>> ${models2.length}');
      for (var item in models2) {
        showModel.add(Upload(
            title: 'หมวดหมู่การท่องเที่ยว',
            id: item.id,
            user_id: item.user_id,
            name: item.name,
            description: item.description,
            image: 'fileupload2/${item.image}',
            date: item.date,
            tag: item.tag));
      }
    } else if (topic_ic == '2') {
      List<Upload> models = await selectupload();
      print('length ===>>>> ${models.length}');
      for (var item in models) {
        showModel.add(Upload(
            title: 'หมวดหมู่อาหาร',
            id: item.id,
            user_id: item.user_id,
            name: item.name,
            description: item.description,
            image: 'fileupload/${item.image}',
            date: item.date,
            tag: item.tag));
      }
    } else if (topic_ic == '3') {
      List<Upload3> models3 = await selectupload3();
      print('length ===>>>> ${models3.length}');
      for (var item in models3) {
        showModel.add(Upload(
            title: 'ป้ายสถานที่ท่องเที่ยวต่างๆ',
            id: item.id,
            user_id: item.user_id,
            name: item.name,
            description: item.description,
            image: 'fileupload3/${item.image}',
            date: item.date,
            tag: item.tag));
      }
    } else if (topic_ic == '4') {
      List<Upload4> models4 = await selectupload4();
      print('length ===>>>> ${models4.length}');
      for (var item in models4) {
        showModel.add(Upload(
            title: 'หมวดหมู่ตามสถานการณ์',
            id: item.id,
            user_id: item.user_id,
            name: item.name,
            description: item.description,
            image: 'fileupload4/${item.image}',
            date: item.date,
            tag: item.tag));
      }
    }
  }

  Widget menubuild() {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Responsive(
      mobile: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // width: size.wi,
            child: Text(
              "ข้อมูลการท่องเที่ยว",
              textAlign: TextAlign.center,
              style: GoogleFonts.kanit(
                textStyle: TextStyle(
                  fontSize: 10,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.only(left: size.height * 0.01),
            // width: size.wi,
            child: Text(
              "ข้อมูลรูปภาพการท่องเที่ยว จากคลังข้อมูลรูปภาพที่ถูกแบ่งออกเป็นทั้งหมด 4 หมวด \nเป็นภาพถ่ายท่องเที่ยวและทิวทัศน์ตามสถานที่ต่างๆ",
              textAlign: TextAlign.center,
              style: GoogleFonts.kanit(
                textStyle: TextStyle(
                  fontSize: 7,
                ),
              ),
            ),
          ),
        ],
      ),
      tablet: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // width: size.wi,
            child: FittedBox(
              child: Text(
                "ข้อมูลการท่องเที่ยว",
                textAlign: TextAlign.start,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: size.height * 0.01),
            // width: size.wi,
            child: FittedBox(
              child: Text(
                "ข้อมูลรูปภาพการท่องเที่ยว จากคลังข้อมูลรูปภาพที่ถูกแบ่งออกเป็นทั้งหมด 4 หมวด เป็นภาพถ่ายท่องเที่ยวและทิวทัศน์ตามสถานที่ต่างๆ",
                textAlign: TextAlign.start,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                      // fontSize: 35,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
      desktop: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // width: size.wi,
            child: FittedBox(
              child: Text(
                "ข้อมูลการท่องเที่ยว",
                textAlign: TextAlign.start,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: size.height * 0.01),
            // width: size.wi,
            child: FittedBox(
              child: Text(
                "ข้อมูลรูปภาพการท่องเที่ยว จากคลังข้อมูลรูปภาพที่ถูกแบ่งออกเป็นทั้งหมด 4 หมวด เป็นภาพถ่ายท่องเที่ยวและทิวทัศน์ตามสถานที่ต่างๆ",
                textAlign: TextAlign.start,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                      // fontSize: 35,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget travel() {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Responsive(
      mobile: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectIndex = 0;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Ink.image(
                    height: size.height * 0.05,
                    width: size.width * 1,
                    image: AssetImage('images/picturecontent/wat.jpg'),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.1, left: size.height * 0.11),
                    child: Text(
                      'TRAVEL',
                      textAlign: TextAlign.center,
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
          ),
        ),
      ),
      tablet: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectIndex = 0;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Ink.image(
                        height: size.height * 0.295,
                        width: size.width * 0.18,
                        image: AssetImage('images/picturecontent/wat.jpg'),
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.1, left: size.height * 0.11),
                        child: Text(
                          'TRAVEL',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      desktop: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectIndex = 0;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Ink.image(
                        height: size.height * 0.295,
                        width: size.width * 0.18,
                        image: AssetImage('images/picturecontent/wat.jpg'),
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.1, left: size.height * 0.11),
                        child: Text(
                          'TRAVEL',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget scenario() {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Responsive(
      mobile: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectIndex = 1;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Ink.image(
                        height: size.height * 0.3,
                        width: size.width * 0.18,
                        image:
                            AssetImage('images/picturecontent/scenario1.jpg'),
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.1, left: size.height * 0.11),
                        child: Text(
                          'SCENARIO',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      tablet: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectIndex = 1;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Ink.image(
                        height: size.height * 0.3,
                        width: size.width * 0.18,
                        image:
                            AssetImage('images/picturecontent/scenario1.jpg'),
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.1, left: size.height * 0.11),
                        child: Text(
                          'SCENARIO',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      desktop: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectIndex = 1;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Ink.image(
                        height: size.height * 0.3,
                        width: size.width * 0.18,
                        image:
                            AssetImage('images/picturecontent/scenario1.jpg'),
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.1, left: size.height * 0.11),
                        child: Text(
                          'SCENARIO',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget food() {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                selectIndex = 2;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Ink.image(
                      height: size.height * 0.3,
                      width: size.width * 0.18,
                      image: AssetImage('images/picturecontent/food1.jpg'),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.1, left: size.height * 0.13),
                      child: Text(
                        'FOOD',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signboard() {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                selectIndex = 3;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Ink.image(
                      height: size.height * 0.3,
                      width: size.width * 0.18,
                      image: AssetImage('images/picturecontent/signboard2.jpg'),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.1, left: size.height * 0.11),
                      child: Text(
                        'SIGNBOARD',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Responsive(
      mobile: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              height: size.height * 0.3,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.1),
                    child: Center(
                      child: menubuild(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.08,
                        right: size.width * 0.08,
                        top: size.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectIndex = 0;
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Ink.image(
                                      height: size.height * 0.08,
                                      width: size.width * 0.185,
                                      image: AssetImage(
                                          'images/picturecontent/wat.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      'TRAVEL',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectIndex = 1;
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Ink.image(
                                      height: size.height * 0.08,
                                      width: size.width * 0.185,
                                      image: AssetImage(
                                          'images/picturecontent/scenario1.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      'SCENARIO',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectIndex = 2;
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Ink.image(
                                      height: size.height * 0.08,
                                      width: size.width * 0.185,
                                      image: AssetImage(
                                          'images/picturecontent/food1.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      'FOOD',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectIndex = 3;
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Ink.image(
                                      height: size.height * 0.08,
                                      width: size.width * 0.185,
                                      image: AssetImage(
                                          'images/picturecontent/signboard2.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      'SIGNBOARD',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.01),
              child: [
                TravelEdit(models: showModel2, 
                // model: model!
                ),
                ScenarioEdit(models: showModel4),
                FoodStateEdit(models: showModel),
                SignboardEdit(models: showModel3),
              ][selectIndex],
            ),
          ],
        ),
      ),
      tablet: Container(
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 220,
                  bottom: 20,
                ),
                child: menubuild(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.08,
                    right: size.width * 0.08,
                    top: size.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectIndex = 0;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Ink.image(
                                  height: size.height * 0.09,
                                  width: size.width * 0.185,
                                  image: AssetImage(
                                      'images/picturecontent/wat.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'TRAVEL',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectIndex = 1;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Ink.image(
                                  height: size.height * 0.09,
                                  width: size.width * 0.185,
                                  image: AssetImage(
                                      'images/picturecontent/scenario1.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'SCENARIO',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectIndex = 2;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Ink.image(
                                  height: size.height * 0.09,
                                  width: size.width * 0.185,
                                  image: AssetImage(
                                      'images/picturecontent/food1.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'FOOD',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectIndex = 3;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Ink.image(
                                  height: size.height * 0.09,
                                  width: size.width * 0.185,
                                  image: AssetImage(
                                      'images/picturecontent/signboard2.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'SIGNBOARD',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.1),
                child: isLoading
                    ? CircularProgressIndicator()
                    : Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 16,
                        semanticContainer: size.height.isFinite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.03,
                                left: size.width * 0.05,
                                right: size.height * 0.05,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    categories[selectIndex],
                                    style: GoogleFonts.kanit(
                                      // fontSize: 18,
                                      color: Colors.greenAccent.shade700,
                                    ),
                                  ),
                                  Spacer(),
                                  SearchView(
                                    showBtnSearch: true,
                                    onChanged: (value) async {
                                      setState(() {
                                        showModel = models
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                        showModel2 = models2
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                        showModel3 = models3
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                        showModel4 = models4
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.03,
                                right: size.height * 0.03,
                              ),
                              child: Divider(
                                color: Colors.black12,
                                height: 10,
                                thickness: 2,
                                indent: 10,
                                endIndent: size.width * 0.025,
                              ),
                            ),
                            [
                              TravelEdit(models: showModel2, 
                              // model: model!
                              ),
                              ScenarioEdit(models: showModel4),
                              FoodStateEdit(models: showModel),
                              SignboardEdit(models: showModel3),
                            ][selectIndex],
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      desktop: Container(
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 220,
                  bottom: 20,
                ),
                child: menubuild(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  travel(),
                  scenario(),
                  food(),
                  signboard(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.1),
                child: isLoading
                    ? CircularProgressIndicator()
                    : Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 16,
                        semanticContainer: size.height.isFinite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.03,
                                left: size.width * 0.1,
                                right: size.height * 0.1,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    categories[selectIndex],
                                    style: GoogleFonts.kanit(
                                      fontSize: 18,
                                      color: Colors.greenAccent.shade700,
                                    ),
                                  ),
                                  Spacer(),
                                  SearchView(
                                    showBtnSearch: true,
                                    onChanged: (value) async {
                                      setState(() {
                                        showModel = models
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                        showModel2 = models2
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                        showModel3 = models3
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                        showModel4 = models4
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.03,
                                right: size.height * 0.03,
                              ),
                              child: Divider(
                                color: Colors.black12,
                                height: 10,
                                thickness: 2,
                                indent: 10,
                                endIndent: size.width * 0.025,
                              ),
                            ),
                            [
                              TravelEdit(models: showModel2, 
                              // model: model!
                              ),
                              ScenarioEdit(models: showModel4),
                              FoodStateEdit(models: showModel),
                              SignboardEdit(models: showModel3),
                            ][selectIndex],
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//   static const String routeName = '/categories';
//   List<Widget> categories = [
//     TravelEdit(),
//     ScenarioEdit(),
//     FoodStateEdit(),
//     SignboardEdit(),
//   ];
//   int selectIndex = 0;
//   double _scrollPosition = 0;
//   double _opacity = 0;

//   Widget menubuild() {
//     var size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
//     return Responsive(
//       mobile: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             // width: size.wi,
//             child: Text(
//               "ข้อมูลการท่องเที่ยว",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.kanit(
//                 textStyle: TextStyle(
//                   fontSize: 10,
//                   decoration: TextDecoration.underline,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             // padding: EdgeInsets.only(left: size.height * 0.01),
//             // width: size.wi,
//             child: Text(
//               "ข้อมูลรูปภาพการท่องเที่ยว จากคลังข้อมูลรูปภาพที่ถูกแบ่งออกเป็นทั้งหมด 4 หมวด \nเป็นภาพถ่ายท่องเที่ยวและทิวทัศน์ตามสถานที่ต่างๆ",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.kanit(
//                 textStyle: TextStyle(
//                   fontSize: 7,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       tablet: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             // width: size.wi,
//             child: FittedBox(
//               child: Text(
//                 "ข้อมูลการท่องเที่ยว",
//                 textAlign: TextAlign.start,
//                 style: GoogleFonts.kanit(
//                   textStyle: TextStyle(
//                     fontSize: 35,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(left: size.height * 0.01),
//             // width: size.wi,
//             child: FittedBox(
//               child: Text(
//                 "ข้อมูลรูปภาพการท่องเที่ยว จากคลังข้อมูลรูปภาพที่ถูกแบ่งออกเป็นทั้งหมด 4 หมวด เป็นภาพถ่ายท่องเที่ยวและทิวทัศน์ตามสถานที่ต่างๆ",
//                 textAlign: TextAlign.start,
//                 style: GoogleFonts.kanit(
//                   textStyle: TextStyle(
//                       // fontSize: 35,
//                       ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       desktop: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             // width: size.wi,
//             child: FittedBox(
//               child: Text(
//                 "ข้อมูลการท่องเที่ยว",
//                 textAlign: TextAlign.start,
//                 style: GoogleFonts.kanit(
//                   textStyle: TextStyle(
//                     fontSize: 35,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(left: size.height * 0.01),
//             // width: size.wi,
//             child: FittedBox(
//               child: Text(
//                 "ข้อมูลรูปภาพการท่องเที่ยว จากคลังข้อมูลรูปภาพที่ถูกแบ่งออกเป็นทั้งหมด 4 หมวด เป็นภาพถ่ายท่องเที่ยวและทิวทัศน์ตามสถานที่ต่างๆ",
//                 textAlign: TextAlign.start,
//                 style: GoogleFonts.kanit(
//                   textStyle: TextStyle(
//                       // fontSize: 35,
//                       ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget travel() {
//     var size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
//     return Responsive(
//       mobile: Center(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Card(
//             clipBehavior: Clip.antiAlias,
//             elevation: 16,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   selectIndex = 0;
//                 });
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Ink.image(
//                     height: size.height * 0.05,
//                     width: size.width * 1,
//                     image: AssetImage('images/picturecontent/wat.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: size.height * 0.1, left: size.height * 0.11),
//                     child: Text(
//                       'TRAVEL',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.kanit(
//                         textStyle: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       tablet: Center(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Card(
//             clipBehavior: Clip.antiAlias,
//             elevation: 16,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   selectIndex = 0;
//                 });
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     alignment: Alignment.bottomLeft,
//                     children: [
//                       Ink.image(
//                         height: size.height * 0.295,
//                         width: size.width * 0.18,
//                         image: AssetImage('images/picturecontent/wat.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: size.height * 0.1, left: size.height * 0.11),
//                         child: Text(
//                           'TRAVEL',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.kanit(
//                             textStyle: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       desktop: Center(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Card(
//             clipBehavior: Clip.antiAlias,
//             elevation: 16,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   selectIndex = 0;
//                 });
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     alignment: Alignment.bottomLeft,
//                     children: [
//                       Ink.image(
//                         height: size.height * 0.295,
//                         width: size.width * 0.18,
//                         image: AssetImage('images/picturecontent/wat.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: size.height * 0.1, left: size.height * 0.11),
//                         child: Text(
//                           'TRAVEL',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.kanit(
//                             textStyle: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget scenario() {
//     var size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
//     return Responsive(
//       mobile: Center(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Card(
//             clipBehavior: Clip.antiAlias,
//             elevation: 16,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   selectIndex = 1;
//                 });
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     alignment: Alignment.bottomLeft,
//                     children: [
//                       Ink.image(
//                         height: size.height * 0.3,
//                         width: size.width * 0.18,
//                         image:
//                             AssetImage('images/picturecontent/scenario1.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: size.height * 0.1, left: size.height * 0.11),
//                         child: Text(
//                           'SCENARIO',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.kanit(
//                             textStyle: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       tablet: Center(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Card(
//             clipBehavior: Clip.antiAlias,
//             elevation: 16,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   selectIndex = 1;
//                 });
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     alignment: Alignment.bottomLeft,
//                     children: [
//                       Ink.image(
//                         height: size.height * 0.3,
//                         width: size.width * 0.18,
//                         image:
//                             AssetImage('images/picturecontent/scenario1.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: size.height * 0.1, left: size.height * 0.11),
//                         child: Text(
//                           'SCENARIO',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.kanit(
//                             textStyle: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       desktop: Center(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Card(
//             clipBehavior: Clip.antiAlias,
//             elevation: 16,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   selectIndex = 1;
//                 });
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     alignment: Alignment.bottomLeft,
//                     children: [
//                       Ink.image(
//                         height: size.height * 0.3,
//                         width: size.width * 0.18,
//                         image:
//                             AssetImage('images/picturecontent/scenario1.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: size.height * 0.1, left: size.height * 0.11),
//                         child: Text(
//                           'SCENARIO',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.kanit(
//                             textStyle: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget food() {
//     var size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Card(
//           clipBehavior: Clip.antiAlias,
//           elevation: 16,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: InkWell(
//             onTap: () {
//               setState(() {
//                 selectIndex = 2;
//               });
//             },
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   alignment: Alignment.bottomLeft,
//                   children: [
//                     Ink.image(
//                       height: size.height * 0.3,
//                       width: size.width * 0.18,
//                       image: AssetImage('images/picturecontent/food1.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: size.height * 0.1, left: size.height * 0.13),
//                       child: Text(
//                         'FOOD',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.kanit(
//                           textStyle: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget signboard() {
//     var size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Card(
//           clipBehavior: Clip.antiAlias,
//           elevation: 16,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: InkWell(
//             onTap: () {
//               setState(() {
//                 selectIndex = 3;
//               });
//             },
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   alignment: Alignment.bottomLeft,
//                   children: [
//                     Ink.image(
//                       height: size.height * 0.3,
//                       width: size.width * 0.18,
//                       image: AssetImage('images/picturecontent/signboard2.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: size.height * 0.1, left: size.height * 0.11),
//                       child: Text(
//                         'SIGNBOARD',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.kanit(
//                           textStyle: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
//     Size sized = MediaQuery.of(context).size;
//     return Responsive(
//       mobile: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Padding(
//             //   padding: const EdgeInsets.only(
//             //     left: 220,
//             //     bottom: 20,
//             //   ),
//             //   child: menubuild(),
//             // ),
//             Container(
//               decoration: BoxDecoration(color: Colors.white),height: size.height*0.3,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: size.height*0.1),
//                     child: Center(
//                       child: menubuild(),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: size.width * 0.08,
//                         right: size.width * 0.08,
//                         top: size.height * 0.02),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Card(
//                           clipBehavior: Clip.antiAlias,
//                           elevation: 16,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 selectIndex = 0;
//                               });
//                             },
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Stack(
//                                   alignment: Alignment.bottomCenter,
//                                   children: [
//                                     Ink.image(
//                                       height: size.height * 0.08,
//                                       width: size.width * 0.185,
//                                       image: AssetImage(
//                                           'images/picturecontent/wat.jpg'),
//                                       fit: BoxFit.cover,
//                                     ),
//                                     Text(
//                                       'TRAVEL',
//                                       textAlign: TextAlign.center,
//                                       style: GoogleFonts.kanit(
//                                         textStyle: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 8,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Card(
//                           clipBehavior: Clip.antiAlias,
//                           elevation: 16,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 selectIndex = 1;
//                               });
//                             },
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Stack(
//                                   alignment: Alignment.bottomCenter,
//                                   children: [
//                                     Ink.image(
//                                       height: size.height * 0.08,
//                                       width: size.width * 0.185,
//                                       image: AssetImage(
//                                           'images/picturecontent/scenario1.jpg'),
//                                       fit: BoxFit.cover,
//                                     ),
//                                     Text(
//                                       'SCENARIO',
//                                       textAlign: TextAlign.center,
//                                       style: GoogleFonts.kanit(
//                                         textStyle: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 8,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Card(
//                           clipBehavior: Clip.antiAlias,
//                           elevation: 16,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 selectIndex = 2;
//                               });
//                             },
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Stack(
//                                   alignment: Alignment.bottomCenter,
//                                   children: [
//                                     Ink.image(
//                                       height: size.height * 0.08,
//                                       width: size.width * 0.185,
//                                       image: AssetImage(
//                                           'images/picturecontent/food1.jpg'),
//                                       fit: BoxFit.cover,
//                                     ),
//                                     Text(
//                                       'FOOD',
//                                       textAlign: TextAlign.center,
//                                       style: GoogleFonts.kanit(
//                                         textStyle: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 8,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Card(
//                           clipBehavior: Clip.antiAlias,
//                           elevation: 16,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 selectIndex = 3;
//                               });
//                             },
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Stack(
//                                   alignment: Alignment.bottomCenter,
//                                   children: [
//                                     Ink.image(
//                                       height: size.height * 0.08,
//                                       width: size.width * 0.185,
//                                       image: AssetImage(
//                                           'images/picturecontent/signboard2.jpg'),
//                                       fit: BoxFit.cover,
//                                     ),
//                                     Text(
//                                       'SIGNBOARD',
//                                       textAlign: TextAlign.center,
//                                       style: GoogleFonts.kanit(
//                                         textStyle: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 8,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // scenario(),
//                         // food(),
//                         // signboard(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: size.height * 0.01),
//               child: categories[selectIndex],
//             ),
//           ],
//         ),
//       ),
//       tablet: Container(
//         child: Padding(
//           padding: EdgeInsets.only(top: size.height * 0.12),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 220,
//                   bottom: 20,
//                 ),
//                 child: menubuild(),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   travel(),
//                   scenario(),
//                   food(),
//                   signboard(),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: size.height * 0.1),
//                 child: Card(
//                     clipBehavior: Clip.antiAlias,
//                     elevation: 16,
//                     semanticContainer: size.height.isFinite,
//                     shape: RoundedRectangleBorder(
//                         // side: BorderSide(),
//                         borderRadius: BorderRadius.circular(15)),
//                     child: categories[selectIndex]),
//               ),
//             ],
//           ),
//         ),
//       ),
//       desktop: Container(
//         child: Padding(
//           padding: EdgeInsets.only(top: size.height * 0.12),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 220,
//                   bottom: 20,
//                 ),
//                 child: menubuild(),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   travel(),
//                   scenario(),
//                   food(),
//                   signboard(),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: size.height * 0.1),
//                 child: Card(
//                     clipBehavior: Clip.antiAlias,
//                     elevation: 16,
//                     semanticContainer: size.height.isFinite,
//                     shape: RoundedRectangleBorder(
//                         // side: BorderSide(),
//                         borderRadius: BorderRadius.circular(15)),
//                     child: categories[selectIndex]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget travel() {
//   //   var size = MediaQuery.of(context).size;
//   //   _opacity = _scrollPosition < size.height * 0.40
//   //       ? _scrollPosition / (size.height * 0.40)
//   //       : 1;
//   //   return Responsive(
//   //     mobile: Center(
//   //       child: Padding(
//   //         padding: EdgeInsets.all(10.0),
//   //         child: Card(
//   //           clipBehavior: Clip.antiAlias,
//   //           elevation: 16,
//   //           shape: RoundedRectangleBorder(
//   //             borderRadius: BorderRadius.circular(15),
//   //           ),
//   //           child: InkWell(
//   //             onTap: () {
//   //               setState(() {
//   //                 selectIndex = 0;
//   //               });
//   //             },
//   //             child: Column(
//   //               mainAxisSize: MainAxisSize.min,
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Stack(
//   //                   alignment: Alignment.bottomLeft,
//   //                   children: [
//   //                     Ink.image(
//   //                       height: size.height * 0.05,
//   //                       width: size.width * 1,
//   //                       image: AssetImage('images/picturecontent/wat.jpg'),
//   //                       fit: BoxFit.cover,
//   //                     ),
//   //                     Padding(
//   //                       padding: EdgeInsets.only(
//   //                           top: size.height * 0.1, left: size.height * 0.11),
//   //                       child: Text(
//   //                         'TRAVEL',
//   //                         textAlign: TextAlign.center,
//   //                         style: GoogleFonts.kanit(
//   //                           textStyle: TextStyle(
//   //                             color: Colors.white,
//   //                             fontSize: 14,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //     tablet: Center(
//   //       child: Padding(
//   //         padding: EdgeInsets.all(10.0),
//   //         child: Card(
//   //           clipBehavior: Clip.antiAlias,
//   //           elevation: 16,
//   //           shape: RoundedRectangleBorder(
//   //             borderRadius: BorderRadius.circular(15),
//   //           ),
//   //           child: InkWell(
//   //             onTap: () {
//   //               setState(() {
//   //                 selectIndex = 0;
//   //               });
//   //             },
//   //             child: Column(
//   //               mainAxisSize: MainAxisSize.min,
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Stack(
//   //                   alignment: Alignment.bottomLeft,
//   //                   children: [
//   //                     Ink.image(
//   //                       height: size.height * 0.295,
//   //                       width: size.width * 0.18,
//   //                       image: AssetImage('images/picturecontent/wat.jpg'),
//   //                       fit: BoxFit.cover,
//   //                     ),
//   //                     Padding(
//   //                       padding: EdgeInsets.only(
//   //                           top: size.height * 0.1, left: size.height * 0.11),
//   //                       child: Text(
//   //                         'TRAVEL',
//   //                         textAlign: TextAlign.center,
//   //                         style: GoogleFonts.kanit(
//   //                           textStyle: TextStyle(
//   //                             color: Colors.white,
//   //                             fontSize: 24,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //     desktop: Center(
//   //       child: Padding(
//   //         padding: EdgeInsets.all(10.0),
//   //         child: Card(
//   //           clipBehavior: Clip.antiAlias,
//   //           elevation: 16,
//   //           shape: RoundedRectangleBorder(
//   //             borderRadius: BorderRadius.circular(15),
//   //           ),
//   //           child: InkWell(
//   //             onTap: () {
//   //               setState(() {
//   //                 selectIndex = 0;
//   //               });
//   //             },
//   //             child: Column(
//   //               mainAxisSize: MainAxisSize.min,
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Stack(
//   //                   alignment: Alignment.bottomLeft,
//   //                   children: [
//   //                     Ink.image(
//   //                       height: size.height * 0.295,
//   //                       width: size.width * 0.18,
//   //                       image: AssetImage('images/picturecontent/wat.jpg'),
//   //                       fit: BoxFit.cover,
//   //                     ),
//   //                     Padding(
//   //                       padding: EdgeInsets.only(
//   //                           top: size.height * 0.1, left: size.height * 0.11),
//   //                       child: Text(
//   //                         'TRAVEL',
//   //                         textAlign: TextAlign.center,
//   //                         style: GoogleFonts.kanit(
//   //                           textStyle: TextStyle(
//   //                             color: Colors.white,
//   //                             fontSize: 24,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget scenario() {
//   //   var size = MediaQuery.of(context).size;
//   //   _opacity = _scrollPosition < size.height * 0.40
//   //       ? _scrollPosition / (size.height * 0.40)
//   //       : 1;
//   //   return Responsive(
//   //     mobile: Center(
//   //       child: Padding(
//   //         padding: EdgeInsets.all(10.0),
//   //         child: Card(
//   //           clipBehavior: Clip.antiAlias,
//   //           elevation: 16,
//   //           shape: RoundedRectangleBorder(
//   //             borderRadius: BorderRadius.circular(15),
//   //           ),
//   //           child: InkWell(
//   //             onTap: () {
//   //               setState(() {
//   //                 selectIndex = 1;
//   //               });
//   //             },
//   //             child: Column(
//   //               mainAxisSize: MainAxisSize.min,
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Stack(
//   //                   alignment: Alignment.bottomLeft,
//   //                   children: [
//   //                     Ink.image(
//   //                       height: size.height * 0.3,
//   //                       width: size.width * 0.18,
//   //                       image:
//   //                           AssetImage('images/picturecontent/scenario1.jpg'),
//   //                       fit: BoxFit.cover,
//   //                     ),
//   //                     Padding(
//   //                       padding: EdgeInsets.only(
//   //                           top: size.height * 0.1, left: size.height * 0.11),
//   //                       child: Text(
//   //                         'SCENARIO',
//   //                         textAlign: TextAlign.center,
//   //                         style: GoogleFonts.kanit(
//   //                           textStyle: TextStyle(
//   //                             color: Colors.white,
//   //                             fontSize: 24,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //     tablet: Center(
//   //       child: Padding(
//   //         padding: EdgeInsets.all(10.0),
//   //         child: Card(
//   //           clipBehavior: Clip.antiAlias,
//   //           elevation: 16,
//   //           shape: RoundedRectangleBorder(
//   //             borderRadius: BorderRadius.circular(15),
//   //           ),
//   //           child: InkWell(
//   //             onTap: () {
//   //               setState(() {
//   //                 selectIndex = 1;
//   //               });
//   //             },
//   //             child: Column(
//   //               mainAxisSize: MainAxisSize.min,
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Stack(
//   //                   alignment: Alignment.bottomLeft,
//   //                   children: [
//   //                     Ink.image(
//   //                       height: size.height * 0.3,
//   //                       width: size.width * 0.18,
//   //                       image:
//   //                           AssetImage('images/picturecontent/scenario1.jpg'),
//   //                       fit: BoxFit.cover,
//   //                     ),
//   //                     Padding(
//   //                       padding: EdgeInsets.only(
//   //                           top: size.height * 0.1, left: size.height * 0.11),
//   //                       child: Text(
//   //                         'SCENARIO',
//   //                         textAlign: TextAlign.center,
//   //                         style: GoogleFonts.kanit(
//   //                           textStyle: TextStyle(
//   //                             color: Colors.white,
//   //                             fontSize: 24,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //     desktop: Center(
//   //       child: Padding(
//   //         padding: EdgeInsets.all(10.0),
//   //         child: Card(
//   //           clipBehavior: Clip.antiAlias,
//   //           elevation: 16,
//   //           shape: RoundedRectangleBorder(
//   //             borderRadius: BorderRadius.circular(15),
//   //           ),
//   //           child: InkWell(
//   //             onTap: () {
//   //               setState(() {
//   //                 selectIndex = 1;
//   //               });
//   //             },
//   //             child: Column(
//   //               mainAxisSize: MainAxisSize.min,
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Stack(
//   //                   alignment: Alignment.bottomLeft,
//   //                   children: [
//   //                     Ink.image(
//   //                       height: size.height * 0.3,
//   //                       width: size.width * 0.18,
//   //                       image:
//   //                           AssetImage('images/picturecontent/scenario1.jpg'),
//   //                       fit: BoxFit.cover,
//   //                     ),
//   //                     Padding(
//   //                       padding: EdgeInsets.only(
//   //                           top: size.height * 0.1, left: size.height * 0.11),
//   //                       child: Text(
//   //                         'SCENARIO',
//   //                         textAlign: TextAlign.center,
//   //                         style: GoogleFonts.kanit(
//   //                           textStyle: TextStyle(
//   //                             color: Colors.white,
//   //                             fontSize: 24,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget food() {
//   //   var size = MediaQuery.of(context).size;
//   //   _opacity = _scrollPosition < size.height * 0.40
//   //       ? _scrollPosition / (size.height * 0.40)
//   //       : 1;
//   //   return Center(
//   //     child: Padding(
//   //       padding: EdgeInsets.all(10.0),
//   //       child: Card(
//   //         clipBehavior: Clip.antiAlias,
//   //         elevation: 16,
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(15),
//   //         ),
//   //         child: InkWell(
//   //           onTap: () {
//   //             setState(() {
//   //               selectIndex = 2;
//   //             });
//   //           },
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Stack(
//   //                 alignment: Alignment.bottomLeft,
//   //                 children: [
//   //                   Ink.image(
//   //                     height: size.height * 0.3,
//   //                     width: size.width * 0.18,
//   //                     image: AssetImage('images/picturecontent/food1.jpg'),
//   //                     fit: BoxFit.cover,
//   //                   ),
//   //                   Padding(
//   //                     padding: EdgeInsets.only(
//   //                         top: size.height * 0.1, left: size.height * 0.13),
//   //                     child: Text(
//   //                       'FOOD',
//   //                       textAlign: TextAlign.center,
//   //                       style: GoogleFonts.kanit(
//   //                         textStyle: TextStyle(
//   //                           color: Colors.white,
//   //                           fontSize: 24,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget signboard() {
//   //   var size = MediaQuery.of(context).size;
//   //   _opacity = _scrollPosition < size.height * 0.40
//   //       ? _scrollPosition / (size.height * 0.40)
//   //       : 1;
//   //   return Center(
//   //     child: Padding(
//   //       padding: EdgeInsets.all(10.0),
//   //       child: Card(
//   //         clipBehavior: Clip.antiAlias,
//   //         elevation: 16,
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(15),
//   //         ),
//   //         child: InkWell(
//   //           onTap: () {
//   //             setState(() {
//   //               selectIndex = 3;
//   //             });
//   //           },
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Stack(
//   //                 alignment: Alignment.bottomLeft,
//   //                 children: [
//   //                   Ink.image(
//   //                     height: size.height * 0.3,
//   //                     width: size.width * 0.18,
//   //                     image: AssetImage('images/picturecontent/signboard2.jpg'),
//   //                     fit: BoxFit.cover,
//   //                   ),
//   //                   Padding(
//   //                     padding: EdgeInsets.only(
//   //                         top: size.height * 0.1, left: size.height * 0.11),
//   //                     child: Text(
//   //                       'SIGNBOARD',
//   //                       textAlign: TextAlign.center,
//   //                       style: GoogleFonts.kanit(
//   //                         textStyle: TextStyle(
//   //                           color: Colors.white,
//   //                           fontSize: 24,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
