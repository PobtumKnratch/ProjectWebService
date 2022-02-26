// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/form_useredit/edit_data.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CardDataEdit extends StatefulWidget {
  Upload model;
  CardDataEdit({required this.model, Key? key}) : super(key: key);

  @override
  _CardDataEditState createState() => _CardDataEditState();
}

class _CardDataEditState extends State<CardDataEdit> {
  int selectIndex = 0;
  double _scrollPosition = 0;
  double _opacity = 0;
  DateTime? date;

  @override
  // ignore: must_call_super
  void initState() {
    date = DateTime.parse(widget.model.date);
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    return Responsive(
      mobile: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: sizeWidth * 0.1, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: sizeWidth * 0.25,
                        height: sizeWidth * 0.15,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            imageUrl: '$hostpic/${widget.model.image}',
                            fit: BoxFit.cover,
                            width: sizeWidth,
                            height: sizeWidth,
                            errorWidget: (context, url, error) => Image.asset(
                              'images/picturecontent/travel.jpg',
                              fit: BoxFit.cover,
                              width: sizeWidth,
                              height: sizeWidth,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.01, left: size.width * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.model.title,
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.012,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'ชื่อรูปภาพ : ',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.015,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.model.name,
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.015,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'วันที่ : ',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${date!.day} ${allMonth[date!.month - 1]} ${date!.year + 543}',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'เวลา : ',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${date!.hour.toString().padLeft(2, '0')} : ${date!.minute.toString().padLeft(2, '0')}',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'คำอธิบายรูปภาพ : ',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.012,
                                ),
                              ),
                            ),
                            Text(
                              getEndl(widget.model.description),
                              // widget.model.description,
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.012,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  ButtonTheme(
                    child: ButtonBar(
                      children: <Widget>[
                        Container(
                          width: size.height * 0.15,
                          margin: EdgeInsets.all(5),
                          height: size.height * 0.05,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                color: Color.fromARGB(255, 216, 184, 0),
                              ),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditData(),
                              ),
                            ),
                            padding: EdgeInsets.all(10.0),
                            color: Color.fromARGB(255, 216, 184, 0),
                            textColor: Colors.white,
                            child: Text(
                              "แก้ไขข้อมูล",
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.01,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Container(
                            width: size.height * 0.15,
                            margin: EdgeInsets.all(5),
                            height: size.height * 0.05,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 192, 0, 0),
                                ),
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.all(10.0),
                              color: Color.fromARGB(255, 192, 0, 0),
                              textColor: Colors.white,
                              child: Text(
                                'ลบข้อมูล',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    fontSize: sizeWidth * 0.01,
                                  ),
                                ),
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
            SizedBox(
              height: size.height * 0.02,
            ),
            Divider(
              color: Colors.black12,
              height: 10,
              thickness: 2,
              indent: 10,
              endIndent: size.width * 0.025,
            ),
          ],
        ),
      ),
      tablet: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: sizeWidth * 0.1, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: sizeWidth * 0.25,
                        height: sizeWidth * 0.15,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            imageUrl: '$hostpic/${widget.model.image}',
                            fit: BoxFit.cover,
                            width: sizeWidth,
                            height: sizeWidth,
                            errorWidget: (context, url, error) => Image.asset(
                              'images/picturecontent/travel.jpg',
                              fit: BoxFit.cover,
                              width: sizeWidth,
                              height: sizeWidth,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.01, left: size.width * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.model.title,
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.012,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'ชื่อรูปภาพ : ',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.015,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.model.name,
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.015,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'วันที่ : ',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${date!.day} ${allMonth[date!.month - 1]} ${date!.year + 543}',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'เวลา : ',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${date!.hour.toString().padLeft(2, '0')} : ${date!.minute.toString().padLeft(2, '0')}',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'คำอธิบายรูปภาพ : ',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.012,
                                ),
                              ),
                            ),
                            Text(
                              getEndl(widget.model.description),
                              // widget.model.description,
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.012,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  ButtonTheme(
                    child: ButtonBar(
                      children: <Widget>[
                        Container(
                          width: size.height * 0.15,
                          margin: EdgeInsets.all(5),
                          height: size.height * 0.05,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                color: Color.fromARGB(255, 216, 184, 0),
                              ),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditData(),
                              ),
                            ),
                            padding: EdgeInsets.all(10.0),
                            color: Color.fromARGB(255, 216, 184, 0),
                            textColor: Colors.white,
                            child: Text(
                              "แก้ไขข้อมูล",
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.01,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Container(
                            width: size.height * 0.15,
                            margin: EdgeInsets.all(5),
                            height: size.height * 0.05,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 192, 0, 0),
                                ),
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.all(10.0),
                              color: Color.fromARGB(255, 192, 0, 0),
                              textColor: Colors.white,
                              child: Text(
                                'ลบข้อมูล',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    fontSize: sizeWidth * 0.01,
                                  ),
                                ),
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
            SizedBox(
              height: size.height * 0.02,
            ),
            Divider(
              color: Colors.black12,
              height: 10,
              thickness: 2,
              indent: 10,
              endIndent: size.width * 0.025,
            ),
          ],
        ),
      ),
      desktop: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: sizeWidth * 0.1, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: sizeWidth * 0.25,
                        height: sizeWidth * 0.15,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            imageUrl: '$hostpic/${widget.model.image}',
                            fit: BoxFit.cover,
                            width: sizeWidth,
                            height: sizeWidth,
                            errorWidget: (context, url, error) => Image.asset(
                              'images/picturecontent/travel.jpg',
                              fit: BoxFit.cover,
                              width: sizeWidth,
                              height: sizeWidth,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.01, left: size.width * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.model.title,
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.012,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'ชื่อรูปภาพ : ',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.015,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.model.name,
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.015,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'วันที่ : ',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${date!.day} ${allMonth[date!.month - 1]} ${date!.year + 543}',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'เวลา : ',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${date!.hour.toString().padLeft(2, '0')} : ${date!.minute.toString().padLeft(2, '0')}',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: sizeWidth * 0.01,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'คำอธิบายรูปภาพ : ',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.012,
                                ),
                              ),
                            ),
                            Text(
                              getEndl(widget.model.description),
                              // widget.model.description,
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.012,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  ButtonTheme(
                    child: ButtonBar(
                      children: <Widget>[
                        Container(
                          width: size.height * 0.15,
                          margin: EdgeInsets.all(5),
                          height: size.height * 0.05,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                color: Color.fromARGB(255, 216, 184, 0),
                              ),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditData(),
                              ),
                            ),
                            padding: EdgeInsets.all(10.0),
                            color: Color.fromARGB(255, 216, 184, 0),
                            textColor: Colors.white,
                            child: Text(
                              "แก้ไขข้อมูล",
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: sizeWidth * 0.01,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Container(
                            width: size.height * 0.15,
                            margin: EdgeInsets.all(5),
                            height: size.height * 0.05,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 192, 0, 0),
                                ),
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.all(10.0),
                              color: Color.fromARGB(255, 192, 0, 0),
                              textColor: Colors.white,
                              child: Text(
                                'ลบข้อมูล',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    fontSize: sizeWidth * 0.01,
                                  ),
                                ),
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
            SizedBox(
              height: size.height * 0.02,
            ),
            Divider(
              color: Colors.black12,
              height: 10,
              thickness: 2,
              indent: 10,
              endIndent: size.width * 0.025,
            ),
          ],
        ),
      ),
    );
  }

  String getEndl(String txt) {
    String t = '';
    for (var i = 0; i < txt.length; i++) {
      t += txt[i];
      if (i % 50 == 0) {
        // ignore: unnecessary_statements
        t += '\n${txt[i]}';
      }
      if (t.length > 30) {
        t = t.substring(0, 30);
        t = '$t ..ดูข้อมูลเพิ่มเติม';
      }
    }
    return t;
  }
}
