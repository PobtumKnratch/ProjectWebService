import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload2.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload3.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload4.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/card_dataedit.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/form_useredit/add.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitleHeaderEdit extends StatefulWidget {
  TitleHeaderEdit({Key? key}) : super(key: key);

  @override
  _TitleHeaderEditState createState() => _TitleHeaderEditState();
}

class _TitleHeaderEditState extends State<TitleHeaderEdit> {
  int selectIndex = 0;
  double _scrollPosition = 0;
  // ignore: unused_field
  double _opacity = 0;
  List<Upload> models = [];
  List<Upload2> models2 = [];
  List<Upload3> models3 = [];
  List<Upload4> models4 = [];

  bool isLoad = true;

  Future<void> initData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? topic_ic = preferences.getString('topic_id');
    if (topic_ic == '1') {
      models2 = await selectupload2();
      print('length ===>>>> ${models2.length}');
      setState(
        () {
          isLoad = false;
        },
      );
    } else if (topic_ic == '2') {
      models = await selectupload();
      print('length ===>>>> ${models.length}');
      setState(
        () {
          isLoad = false;
        },
      );
    } else if (topic_ic == '3') {
      models3 = await selectupload3();
      print('length ===>>>> ${models3.length}');
      setState(
        () {
          isLoad = false;
        },
      );
    } else if (topic_ic == '4') {
      models4 = await selectupload4();
      print('length ===>>>> ${models4.length}');
      setState(
        () {
          isLoad = false;
        },
      );
    }
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
    // ignore: unused_local_variable
    Size sized = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      border: Border.all(width: 2.0, color: Colors.greenAccent),
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
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: isLoad
                ? Center(
                    child: Column(
                      children: [
                        // CircularProgressIndicator(),
                        Text(
                          'ไม่พบข้อมูล',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(fontSize: 20)),
                        ),
                      ],
                    ),
                  )
                :
                // ListView.builder(
                //     itemBuilder: (context, index) =>
                //         CardDataEdit(model: models[index]),
                //     itemCount: models.length,
                //   )
                Column(
                    children: List.generate(
                      models2.length,
                      (index) => CardDataEdit(
                        model: models2[index],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
