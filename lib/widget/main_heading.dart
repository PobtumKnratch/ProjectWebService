import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHeading extends StatelessWidget {
  const MainHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Container(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.02,
          bottom: screenSize.height * 0.01,
        ),
        width: screenSize.width,
        child: Text(
          'รูปแบบของข้อมูลการท่องเที่ยว',
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              fontSize: 10,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      tablet: Container(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.02,
          bottom: screenSize.height * 0.01,
        ),
        width: screenSize.width,
        child: Text(
          'รูปแบบของข้อมูลการท่องเที่ยว',
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      desktop: Container(
        padding: EdgeInsets.only(
          top: screenSize.height / 10,
          bottom: screenSize.height / 15,
        ),
        width: screenSize.width,
        child: Text(
          'รูปแบบของข้อมูลการท่องเที่ยว',
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              fontSize: 30,
              // fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
