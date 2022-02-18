import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDataAnnoScenario extends StatefulWidget {
  const CardDataAnnoScenario({ Key? key }) : super(key: key);

  @override
  _CardDataAnnoScenarioState createState() => _CardDataAnnoScenarioState();
}

class _CardDataAnnoScenarioState extends State<CardDataAnnoScenario> {
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
      width: sized.width,
      padding: EdgeInsets.only(
        top: size.height * 0.01,
        left: size.width * 0.1,
        right: size.width * 0.1,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.05),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.grey[200],
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.02,
                    left: size.width * 0.02,
                    bottom: size.height * 0.02),
                child: Container(
                  width: size.width * 0.3,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: const DecorationImage(
                      image: AssetImage('images/picturecontent/annoscenario.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.02,
                  left: size.width * 0.02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'หมวดหมู่รูปภาพ : ',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'สถานการณ์',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'คำอธิบายรูปภาพ : ',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'เป็นรูปถ่ายเกี่ยวกับสถานที่ท่องเที่ยวซึ่งจะมีข้อมูลการท่องเที่ยว \nจากการไปท่องเที่ยวในสถานที่ต่างๆ',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.1),
                          child: FlatButton(
                            minWidth: size.width * 0.13,
                            height: size.height * 0.06,
                            color: Colors.greenAccent.shade100,
                            child: Text(
                              'ตรวจสอบรูปภาพ',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onPressed: () => {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => EditData(),
                              //   ),
                              // ),
                            },
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
    );
  }
}