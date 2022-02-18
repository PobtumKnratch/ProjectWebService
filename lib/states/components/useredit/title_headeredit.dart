import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/card_dataedit.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/form_useredit/add.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/form_useredit/add_data.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/form_useredit/testinsert.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleHeaderEdit extends StatefulWidget {
  TitleHeaderEdit({Key? key}) : super(key: key);

  @override
  _TitleHeaderEditState createState() => _TitleHeaderEditState();
}

class _TitleHeaderEditState extends State<TitleHeaderEdit> {
  int selectIndex = 0;
  double _scrollPosition = 0;
  double _opacity = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    Size sized = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: sized.height,
        width: sized.width,
        padding: EdgeInsets.only(
            top: size.height * 0.1,
            left: size.width * 0.1,
            right: size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            CardDataEdit(),
          ],
        ),
      ),
    );
  }
}
