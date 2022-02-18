import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleHeaderAnno extends StatefulWidget {
  const TitleHeaderAnno({Key? key}) : super(key: key);

  @override
  _TitleHeaderAnnoState createState() => _TitleHeaderAnnoState();
}

class _TitleHeaderAnnoState extends State<TitleHeaderAnno> {
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
    return Container(
      padding: EdgeInsets.only(
          top: size.height * 0.05,
          left: size.width * 0.1,
          right: size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'การตรวจสอบข้อมูลรูปภาพ',
            textAlign: TextAlign.start,
            style: GoogleFonts.kanit(
              textStyle: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            'กรุณาเลือกหมวดหมู่ของรูปภาพที่ต้องการตรวจสอบ',
            textAlign: TextAlign.start,
            style: GoogleFonts.kanit(
              textStyle: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
