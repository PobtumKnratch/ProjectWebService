import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedHeading extends StatelessWidget {
  const FeaturedHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.01,
          left: screenSize.width / 15,
          right: screenSize.width / 15,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ข้อมูลแนะนำ',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,),
              ),
            ),
            // Expanded(
            //   child: Text(
            //     'ข้อมูลเกี่ยวกับสถานที่ท่องเที่ยว',
            //     style: GoogleFonts.kanit(
            //       textStyle: TextStyle(
            //         fontSize: 5,
            //         // fontFamily: 'Raleway',
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black,
            //       ),
            //     ),
            //     textAlign: TextAlign.end,
            //   ),
            // ),
          ],
        ),
      ),
      tablet: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.02,
          left: screenSize.width / 15,
          right: screenSize.width / 15,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'ข้อมูลแนะนำ',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(
                  fontSize: 20,
                  // fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'ข้อมูลเกี่ยวกับสถานที่ท่องเที่ยว',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    // fontSize: 30,
                    // fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
      desktop: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.06,
          left: screenSize.width / 15,
          right: screenSize.width / 15,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'ข้อมูลแนะนำ',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(
                  fontSize: 30,
                  // fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'ข้อมูลเกี่ยวกับสถานที่ท่องเที่ยว',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    // fontSize: 30,
                    // fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
      //  Padding(
      //   padding: EdgeInsets.only(
      //     top: screenSize.height * 0.06,
      //     left: screenSize.width / 15,
      //     right: screenSize.width / 15,
      //   ),
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       Text(
      //         'ข้อมูลแนะนำ',
      //         style: GoogleFonts.kanit(
      //           textStyle: TextStyle(
      //             fontSize: 30,
      //             // fontFamily: 'Raleway',
      //             fontWeight: FontWeight.bold,
      //             color: Colors.black,
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //         child: Text(
      //           'ข้อมูลเกี่ยวกับสถานที่ท่องเที่ยว',
      //           style: GoogleFonts.kanit(
      //             textStyle: TextStyle(
      //               // fontSize: 30,
      //               // fontFamily: 'Raleway',
      //               fontWeight: FontWeight.bold,
      //               color: Colors.black,
      //             ),
      //           ),
      //           textAlign: TextAlign.end,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
