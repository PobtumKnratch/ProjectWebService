import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload2.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload3.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload4.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/card_dataedit.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/form_useredit/add.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitleHeaderEdit extends StatefulWidget {
  static const String routeName = '/titleheaderedit';
  TitleHeaderEdit({Key? key}) : super(key: key);

  @override
  _TitleHeaderEditState createState() => _TitleHeaderEditState();
}

class _TitleHeaderEditState extends State<TitleHeaderEdit> {
  int selectIndex = 0;
  double _scrollPosition = 0;
  // ignore: unused_field
  double _opacity = 0;
  List<Upload> showModel = [];

  bool isLoad = true;

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
    setState(
      () {
        isLoad = false;
      },
    );
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    double sizeWidth = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    Size sized = MediaQuery.of(context).size;
    return Responsive(
      mobile: Padding(
        padding: EdgeInsets.only(top: size.height * 0.05),
        child: isLoad
            ? Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: sizeWidth * 0.12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'การจัดการข้อมูลการท่องเที่ยว',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            splashColor: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Add(),
                                ),
                              ),
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.0, color: Colors.greenAccent),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_box_outlined,
                                    size: 30,
                                    color: Colors.greenAccent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'เพิ่มข้อมูลรูปภาพ',
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizeWidth * 0.1, vertical: 10),
                      child: Divider(
                        color: Colors.black12,
                        height: 10,
                        thickness: 2,
                        indent: 10,
                        endIndent: size.width * 0.025,
                      ),
                    ),
                    Column(
                      children: List.generate(
                        showModel.length,
                        (index) => CardDataEdit(
                          model: showModel[index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      tablet: Padding(
        padding: EdgeInsets.only(top: size.height * 0.05),
        child: isLoad
            ? Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: sizeWidth * 0.12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'การจัดการข้อมูลการท่องเที่ยว',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            splashColor: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Add(),
                                ),
                              ),
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.0, color: Colors.greenAccent),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_box_outlined,
                                    size: 30,
                                    color: Colors.greenAccent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'เพิ่มข้อมูลรูปภาพ',
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizeWidth * 0.1, vertical: 10),
                      child: Divider(
                        color: Colors.black12,
                        height: 10,
                        thickness: 2,
                        indent: 10,
                        endIndent: size.width * 0.025,
                      ),
                    ),
                    Column(
                      children: List.generate(
                        showModel.length,
                        (index) => CardDataEdit(
                          model: showModel[index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      desktop: Padding(
        padding: EdgeInsets.only(top: size.height * 0.05),
        child: isLoad
            ? Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: sizeWidth * 0.12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'การจัดการข้อมูลการท่องเที่ยว',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            splashColor: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Add(),
                                ),
                              ),
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.0, color: Colors.greenAccent),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_box_outlined,
                                    size: 30,
                                    color: Colors.greenAccent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'เพิ่มข้อมูลรูปภาพ',
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizeWidth * 0.1, vertical: 10),
                      child: Divider(
                        color: Colors.black12,
                        height: 10,
                        thickness: 2,
                        indent: 10,
                        endIndent: size.width * 0.025,
                      ),
                    ),
                    Column(
                      children: List.generate(
                        showModel.length,
                        (index) => CardDataEdit(
                          model: showModel[index],
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
