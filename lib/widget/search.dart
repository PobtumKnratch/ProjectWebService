// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter_project_web_supportandservice/Model/response.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/user_food_log.dart';
import 'package:flutter_project_web_supportandservice/states/components/home/data_search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Model/fileupload2.dart';

class Searchandservice extends StatefulWidget {
  // var screenSize;

  Searchandservice({
    Key? key,
    // required this.screenSize,
  }) : super(key: key);
  @override
  _SearchandserviceState createState() => _SearchandserviceState();
}

class _SearchandserviceState extends State<Searchandservice> {
  final formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  List<String> response = [];
  List<Upload2> upload2 = [];

  // late  Size screenSize;

  File? file;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  // ignore: unused_element
  static Future<List<Response>> getLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('lib/assets/response.json');
    final body = responseFormJson(data);
    return body;
  }

  // Future getUsers() async {
  //   try {
  //     final url = 'http://localhost/Project_flutter_nectec/viewData.php';
  //     final response = await http.get(
  //       Uri.parse(url),
  //     );
  //     return usersFormJson(response.body);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future getFood() async {
    try {
      final url = 'http://localhost/Project_flutter_nectec/user_food_log.php';
      // ignore: non_constant_identifier_names
      final Foods = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'xxxx',
        },
      );

      // return foodFromJson(response.body);
      if (Foods.statusCode == 200) {
        print(Foods);
        return foodFromJson(Foods.body);
      } else {
        print(Foods.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Future getupload() async {
  //   try {
  //     final url =
  //         'http://localhost/Project_flutter_nectec/Data/ShowData/fileupload2.php';
  //     final response = await http.get(Uri.parse(url));
  //     print(response);
  //     return uploadFromJson(response.body);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<void> pickerimage(ImageSource imageSource) async {
    try {
      var myfile = await ImagePicker().getImage(
        source: imageSource,
        maxHeight: 50.0,
        maxWidth: 50.0,
      );
      setState(() {
        file = File(myfile!.path);
      });
    } catch (e) {}
  }

  Widget showImage() {
    // ignore: unused_local_variable
    double size = MediaQuery.of(context).size.height * 0.4;
    return Responsive(
      mobile: Container(
        // color: Colors.blueAccent.shade200,
        // width: MediaQuery.of(context).size.width * 0.4,
        // height: MediaQuery.of(context).size.height * 0.4,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 10,
                top: 7,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                // height: MediaQuery.of(context).size.height * 0.4,
                // width: 600,
                // height: size*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(color: Colors.black45, width: 1.2),
                ),
                child: file == null
                    ? Text(
                        "กรุณากดปุ่ม"
                        "อัพโหลด"
                        "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 10,
                            color: Colors.redAccent.shade200,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.4,
                        // width: 500,
                        // height: size*0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.black45, width: 1),
                        ),
                        child: Image.network(file!.path),
                      ),
              ),
            ),
          ],
        ),
      ),
      tablet: Container(
        // color: Colors.blueAccent.shade200,
        // width: MediaQuery.of(context).size.width * 0.4,
        // height: MediaQuery.of(context).size.height * 0.4,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                top: 7,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                // height: MediaQuery.of(context).size.height * 0.4,
                // width: 600,
                // height: size*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(color: Colors.black45, width: 1.2),
                ),
                child: file == null
                    ? Text(
                        "กรุณากดปุ่ม"
                        "อัพโหลด"
                        "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent.shade200,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.4,
                        // width: 500,
                        // height: size*0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.black45, width: 1),
                        ),
                        child: Image.network(file!.path),
                      ),
              ),
            ),
          ],
        ),
      ),
      desktop: Container(
        // color: Colors.blueAccent.shade200,
        // width: MediaQuery.of(context).size.width * 0.4,
        // height: MediaQuery.of(context).size.height * 0.4,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                top: 7,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                // height: MediaQuery.of(context).size.height * 0.4,
                // width: 600,
                // height: size*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(color: Colors.black45, width: 1.2),
                ),
                child: file == null
                    ? Text(
                        "กรุณากดปุ่ม"
                        "อัพโหลด"
                        "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent.shade200,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.4,
                        // width: 500,
                        // height: size*0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.black45, width: 1),
                        ),
                        child: Image.network(file!.path),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
    // Container(
    //   // color: Colors.blueAccent.shade200,
    //   // width: MediaQuery.of(context).size.width * 0.4,
    //   // height: MediaQuery.of(context).size.height * 0.4,
    //   child: Stack(
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.only(
    //           left: 30,
    //           top: 7,
    //         ),
    //         child: Container(
    //           width: MediaQuery.of(context).size.width * 0.35,
    //           // height: MediaQuery.of(context).size.height * 0.4,
    //           // width: 600,
    //           // height: size*0.4,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(7.0),
    //             border: Border.all(color: Colors.black45, width: 1.2),
    //           ),
    //           child: file == null
    //               ? Text(
    //                   "กรุณากดปุ่ม"
    //                   "อัพโหลด"
    //                   "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
    //                   style: GoogleFonts.kanit(
    //                     textStyle: TextStyle(
    //                       fontSize: 16,
    //                       color: Colors.redAccent.shade200,
    //                     ),
    //                   ),
    //                   textAlign: TextAlign.center,
    //                 )
    //               : Container(
    //                   width: MediaQuery.of(context).size.width * 0.35,
    //                   height: MediaQuery.of(context).size.height * 0.4,
    //                   // width: 500,
    //                   // height: size*0.4,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(7.0),
    //                     border: Border.all(color: Colors.black45, width: 1),
    //                   ),
    //                   child: Image.network(file!.path),
    //                 ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  void searchupload(String query) {
    // ignore: unused_local_variable
    final suggestions = upload2.where((upload) {
      final uploadname = upload.name.toLowerCase();
      final input = query.toLowerCase();

      return uploadname.contains(input);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // double _scrollPosition = 0;
    // double _opacity = 0;
    var size = MediaQuery.of(context).size;
    // _opacity = _scrollPosition < size.height * 0.40
    //     ? _scrollPosition / (size.height * 0.40)
    //     : 1;
    return
        // Center(
        //   heightFactor: 1,
        //   child: Padding(
        //     padding: EdgeInsets.only(
        //       top: size.height * 0.05,
        //       left: Responsive.isMobileContent(context)
        //           ? size.width / 15
        //           : size.width / 15,
        //       right: Responsive.isMobileContent(context)
        //           ? size.width / 12
        //           : size.width / 5,
        //     ),
        //     child:
        Responsive(
      mobile: Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.02,
            left: size.width / 15,
            right: size.width / 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Form(
                        key: formKey,
                        child: SizedBox(
                          width: size.width * 0.55,
                          height: size.height * 0.03,
                          child: TextFormField(
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(fontSize: 11, height: 3.7),
                            ),
                            // ignore: body_might_complete_normally_nullable
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '    กรุณากรอกข้อมูลที่ใช้สำหรับการค้นหาชื่อสถานที่ , ชื่ออาหารหรือชื่อกิจกรรม';
                              }
                            },
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 13,
                                ),
                                hintText:
                                    'กรุณากรอกข้อมูล ชื่อสถานที่ , ชื่ออาหาร , ชื่อกิจกรรม เพื่อทำการค้นหา',
                                hintStyle: GoogleFonts.kanit(
                                  textStyle: TextStyle(fontSize: 9),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.black54, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.black54, width: 1),
                                ),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: [
                      FlatButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
                        },
                        color: Colors.greenAccent.shade400,
                        height: 30,
                        minWidth: 25,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'ค้นหา',
                          style: GoogleFonts.kanit(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Align(
            //       alignment: Alignment.center,
            //       child: Stack(
            //         children: [
            //           Column(
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   MaterialButton(
            //                     onPressed: () {
            //                       pickerimage(ImageSource.gallery);
            //                     },
            //                     color: Colors.greenAccent.shade400,
            //                     height: 24,
            //                     minWidth: 14,
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(5),
            //                     ),
            //                     child: Text(
            //                       'เลือกรูปภาพ',
            //                       style: GoogleFonts.kanit(
            //                         textStyle: TextStyle(
            //                           color: Colors.black,
            //                           fontSize: 10,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   // showImage(),
            //                   Container(
            //                     // color: Colors.blueAccent.shade200,
            //                     // width: MediaQuery.of(context).size.width * 0.4,
            //                     // height: MediaQuery.of(context).size.height * 0.4,
            //                     child: Stack(
            //                       children: [
            //                         Padding(
            //                           padding: EdgeInsets.only(
            //                             left: 8,
            //                             top: 5,
            //                           ),
            //                           child: Container(
            //                             width:
            //                                 MediaQuery.of(context).size.width *
            //                                     0.4,
            //                             // height: MediaQuery.of(context).size.height * 0.4,
            //                             // width: 600,
            //                             // height: size*0.4,
            //                             decoration: BoxDecoration(
            //                               borderRadius:
            //                                   BorderRadius.circular(7.0),
            //                               border: Border.all(
            //                                   color: Colors.black45,
            //                                   width: 1.2),
            //                             ),
            //                             child: file == null
            //                                 ? Text(
            //                                     "กรุณากดปุ่ม"
            //                                     "อัพโหลด"
            //                                     "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
            //                                     style: GoogleFonts.kanit(
            //                                       textStyle: TextStyle(
            //                                         fontSize: 10,
            //                                         color: Colors
            //                                             .redAccent.shade200,
            //                                       ),
            //                                     ),
            //                                     textAlign: TextAlign.center,
            //                                   )
            //                                 : Container(
            //                                     width: MediaQuery.of(context)
            //                                             .size
            //                                             .width *
            //                                         0.3,
            //                                     height: MediaQuery.of(context)
            //                                             .size
            //                                             .height *
            //                                         0.2,
            //                                     // width: 500,
            //                                     // height: size*0.4,
            //                                     decoration: BoxDecoration(
            //                                       borderRadius:
            //                                           BorderRadius.circular(
            //                                               5.0),
            //                                       border: Border.all(
            //                                           color: Colors.black45,
            //                                           width: 1),
            //                                     ),
            //                                     child:
            //                                         Image.network(file!.path),
            //                                   ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            //       FutureBuilder<List<Response>>(
            //         future: getUploadLocally(context),
            //         builder: (context, snapshot) {
            //           if (response.isNotEmpty) {
            //             return ListView.builder(
            //               shrinkWrap: true,
            //               physics: BouncingScrollPhysics(),
            //               controller: _scrollController,
            //               itemCount: snapshot.data.length,
            //               itemBuilder: (Upload, index) {
            //                 final upload = snapshot.data[index];
            //                 return ListTile(
            //                   title: Container(
            //                     child: Image.network(
            //                       "http://localhost/Project_flutter_nectec/mhesi-covid19-data/food-images/${upload.image}",
            //                       width: 100,
            //                       height: 100,
            //                       errorBuilder: (context, error, stackTrace) {
            //                         return Center(
            //                           child: Text('No Image Data'),
            //                         );
            //                       },
            //                     ),
            //                   ),
            //                   subtitle: Center(
            //                     child: Text('${upload.name}'),
            //                   ),
            //                 );
            //               },
            //             );
            //           } else {
            //             return Center(
            //               child: CircularProgressIndicator(),
            //             );
            //           }
            //         },
            //       ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      tablet: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Form(
                      key: formKey,
                      child: SizedBox(
                        width: size.width * 0.6,
                        height: size.height * 0.04,
                        child: TextFormField(
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(fontSize: 14, height: 4),
                          ),
                          // ignore: body_might_complete_normally_nullable
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '    กรุณากรอกข้อมูลที่ใช้สำหรับการค้นหาชื่อสถานที่ , ชื่ออาหารหรือชื่อกิจกรรม';
                            }
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.red.shade400,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 16,
                              ),
                              hintText:
                                  'กรุณากรอกข้อมูล ชื่อสถานที่ , ชื่ออาหาร , ชื่อกิจกรรม เพื่อทำการค้นหา',
                              hintStyle: GoogleFonts.kanit(
                                textStyle: TextStyle(fontSize: 14),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black54, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black54, width: 1),
                              ),
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  children: [
                    FlatButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
                      color: Colors.greenAccent.shade400,
                      height: 45,
                      minWidth: 60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'ค้นหา',
                        style: GoogleFonts.kanit(
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Align(
          //       alignment: Alignment.center,
          //       child: Stack(
          //         children: [
          //           Column(
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   MaterialButton(
          //                     onPressed: () {
          //                       pickerimage(ImageSource.gallery);
          //                     },
          //                     color: Colors.greenAccent.shade400,
          //                     height: 45,
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(10)),
          //                     child: Text(
          //                       'เลือกรูปภาพ',
          //                       style: GoogleFonts.kanit(
          //                         textStyle: TextStyle(
          //                           color: Colors.black,
          //                           fontSize: 18,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                   showImage(),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // FutureBuilder<List<User>>(
          //   future: getUploadLocally(context),
          //   builder: (context, snapshot) {
          //     if (upload.isNotEmpty) {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         physics: BouncingScrollPhysics(),
          //         controller: _scrollController,
          //         itemCount: snapshot.data.length,
          //         itemBuilder: (Upload, index) {
          //           final upload = snapshot.data[index];
          //           return ListTile(
          //             title: Container(
          //               child: Image.network(
          //                 "http://localhost/Project_flutter_nectec/mhesi-covid19-data/food-images/${upload.image}",
          //                 width: 100,
          //                 height: 100,
          //                 errorBuilder: (context, error, stackTrace) {
          //                   return Center(
          //                     child: Text('No Image Data'),
          //                   );
          //                 },
          //               ),
          //             ),
          //             subtitle: Center(
          //               child: Text('${upload.name}'),
          //             ),
          //           );
          //         },
          //       );
          //     } else {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   },
          // ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      desktop: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Form(
                      key: formKey,
                      child: SizedBox(
                        width: 700,
                        child: TextFormField(
                          style: GoogleFonts.kanit(),
                          // ignore: body_might_complete_normally_nullable
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '    กรุณากรอกข้อมูลที่ใช้สำหรับการค้นหาชื่อสถานที่ , ชื่ออาหารหรือชื่อกิจกรรม';
                            }
                          },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                color: Colors.red.shade400,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.search),
                            hintText:
                                'กรุณากรอกข้อมูล ชื่อสถานที่ , ชื่ออาหาร , ชื่อกิจกรรม เพื่อทำการค้นหา',
                            hintStyle: GoogleFonts.kanit(
                              textStyle: TextStyle(fontSize: 18),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide:
                                  BorderSide(color: Colors.black54, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide:
                                  BorderSide(color: Colors.black54, width: 1),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          // onChanged: searchupload,
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: upload2.length,
                    //     itemBuilder: (context, index) {
                    //       final upload = upload2[index];
                    //       return ListTile(
                    //         leading: Image.network(
                    //           upload.image,
                    //           fit: BoxFit.cover,
                    //           width: 50,
                    //           height: 50,
                    //         ),
                    //         title: Text(upload.name),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  children: [
                    FlatButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DataSearch(),
                            ),
                          );
                          // showSearch(context: context, delegate: Search());
                        }
                      },
                      color: Colors.greenAccent.shade400,
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'ค้นหา',
                        style: GoogleFonts.kanit(
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Align(
          //       alignment: Alignment.center,
          //       child: Stack(
          //         children: [
          //           Column(
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   MaterialButton(
          //                     onPressed: () {
          //                       pickerimage(ImageSource.gallery);
          //                     },
          //                     color: Colors.greenAccent.shade400,
          //                     height: 45,
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(10)),
          //                     child: Text(
          //                       'เลือกรูปภาพ',
          //                       style: GoogleFonts.kanit(
          //                         textStyle: TextStyle(
          //                           color: Colors.black,
          //                           fontSize: 18,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                   showImage(),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // FutureBuilder<List<Response>>(
          //   future: getLocally(context),
          //   builder: (context, snapshot) {
          //     if (response.isNotEmpty) {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         physics: BouncingScrollPhysics(),
          //         controller: _scrollController,
          //         itemCount: snapshot.data!.length,
          //         itemBuilder: (Response, index) {
          //           final response = snapshot.data![index];
          //           return ListTile(
          //             title: Text('${response.id}'),
          //             // Container(
          //             //   child: Image.network(
          //             //     "http://localhost/Project_flutter_nectec/mhesi-covid19-data/food-images/${response.image}",
          //             //     width: 100,
          //             //     height: 100,
          //             //     errorBuilder: (context, error, stackTrace) {
          //             //       return Center(
          //             //         child: Text('No Image Data'),
          //             //       );
          //             //     },
          //             //   ),
          //             // ),
          //             subtitle: Center(
          //               child: Text('${response.name}'),
          //             ),
          //           );
          //         },
          //       );
          //     } else {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   },
          // ),
          // FutureBuilder<List<User>>(
          //   future: getUploadLocally(context),
          //   builder: (context, snapshot) {
          //     if (upload.isNotEmpty) {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         physics: BouncingScrollPhysics(),
          //         controller: _scrollController,
          //         itemCount: snapshot.data.length,
          //         itemBuilder: (Upload, index) {
          //           final upload = snapshot.data[index];
          //           return ListTile(
          //             title: Container(
          //               child: Image.network(
          //                 "http://localhost/Project_flutter_nectec/mhesi-covid19-data/food-images/${upload.image}",
          //                 width: 100,
          //                 height: 100,
          //                 errorBuilder: (context, error, stackTrace) {
          //                   return Center(
          //                     child: Text('No Image Data'),
          //                   );
          //                 },
          //               ),
          //             ),
          //             subtitle: Center(
          //               child: Text('${upload.name}'),
          //             ),
          //           );
          //         },
          //       );
          //     } else {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   },
          // ),
          // SizedBox(
          //   height: 20,
          // ),
        ],
      ),
      //  Column(
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Align(
      //           alignment: Alignment.center,
      //           child: Stack(
      //             children: [
      //               Form(
      //                 key: formKey,
      //                 child: SizedBox(
      //                   width: 700,
      //                   child: TextFormField(
      //                     validator: (value) {
      //                       if (value == null || value.isEmpty) {
      //                         return '    กรุณากรอกข้อมูลที่ใช้สำหรับการค้นหาชื่อสถานที่ , ชื่ออาหารหรือชื่อกิจกรรม';
      //                       }
      //                     },
      //                     decoration: InputDecoration(
      //                         errorStyle: TextStyle(
      //                             color: Colors.red.shade400,
      //                             fontSize: 16,
      //                             fontWeight: FontWeight.bold),
      //                         prefixIcon: Icon(Icons.search),
      //                         hintText:
      //                             'กรุณากรอกข้อมูล ชื่อสถานที่ , ชื่ออาหาร , ชื่อกิจกรรม เพื่อทำการค้นหา',
      //                         hintStyle: GoogleFonts.kanit(
      //                           textStyle: TextStyle(fontSize: 18),
      //                         ),
      //                         border: OutlineInputBorder(
      //                           borderRadius: BorderRadius.circular(18),
      //                           borderSide: BorderSide(
      //                               color: Colors.black54, width: 1),
      //                         ),
      //                         focusedBorder: OutlineInputBorder(
      //                           borderRadius: BorderRadius.circular(18),
      //                           borderSide: BorderSide(
      //                               color: Colors.black54, width: 1),
      //                         ),
      //                         filled: true,
      //                         fillColor: Colors.white),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         SizedBox(
      //           width: 20,
      //         ),
      //         Align(
      //           alignment: Alignment.centerRight,
      //           child: Stack(
      //             children: [
      //               FlatButton(
      //                 onPressed: () {
      //                   if (formKey.currentState!.validate()) {}
      //                 },
      //                 color: Colors.greenAccent.shade400,
      //                 height: 50,
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(10)),
      //                 child: Text(
      //                   'ค้นหา',
      //                   style: GoogleFonts.kanit(
      //                     textStyle:
      //                         TextStyle(color: Colors.black, fontSize: 18),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Align(
      //           alignment: Alignment.center,
      //           child: Stack(
      //             children: [
      //               Column(
      //                 children: [
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       MaterialButton(
      //                         onPressed: () {
      //                           pickerimage(ImageSource.gallery);
      //                         },
      //                         color: Colors.greenAccent.shade400,
      //                         height: 45,
      //                         shape: RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.circular(10)),
      //                         child: Text(
      //                           'เลือกรูปภาพ',
      //                           style: GoogleFonts.kanit(
      //                             textStyle: TextStyle(
      //                               color: Colors.black,
      //                               fontSize: 18,
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       showImage(),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //     // FutureBuilder<List<User>>(
      //     //   future: getUploadLocally(context),
      //     //   builder: (context, snapshot) {
      //     //     if (upload.isNotEmpty) {
      //     //       return ListView.builder(
      //     //         shrinkWrap: true,
      //     //         physics: BouncingScrollPhysics(),
      //     //         controller: _scrollController,
      //     //         itemCount: snapshot.data.length,
      //     //         itemBuilder: (Upload, index) {
      //     //           final upload = snapshot.data[index];
      //     //           return ListTile(
      //     //             title: Container(
      //     //               child: Image.network(
      //     //                 "http://localhost/Project_flutter_nectec/mhesi-covid19-data/food-images/${upload.image}",
      //     //                 width: 100,
      //     //                 height: 100,
      //     //                 errorBuilder: (context, error, stackTrace) {
      //     //                   return Center(
      //     //                     child: Text('No Image Data'),
      //     //                   );
      //     //                 },
      //     //               ),
      //     //             ),
      //     //             subtitle: Center(
      //     //               child: Text('${upload.name}'),
      //     //             ),
      //     //           );
      //     //         },
      //     //       );
      //     //     } else {
      //     //       return Center(
      //     //         child: CircularProgressIndicator(),
      //     //       );
      //     //     }
      //     //   },
      //     // ),
      //     SizedBox(
      //       height: 20,
      //     ),
      // FutureBuilder<List<Upload>>(
      //   future: getupload(),
      //   builder: (context, snapshot) {
      //     if (upload.isNotEmpty) {
      //       return StaggeredGridView.countBuilder(
      //         padding: EdgeInsets.symmetric(
      //           horizontal: 30,
      //         ),
      //         shrinkWrap: true,
      //         primary: false,
      //         physics: BouncingScrollPhysics(),
      //         crossAxisCount: 5,
      //         itemCount: snapshot.data.length,
      //         itemBuilder: (Upload, index) {
      //           final upload = snapshot.data[index];
      //           return Card(
      //             margin: EdgeInsets.zero,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(8),
      //             ),
      //             child: Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Container(
      //                 alignment: Alignment.center,
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Flexible(
      //                       flex: 1,
      //                       fit: FlexFit.loose,
      //                       child: Stack(
      //                         children: [
      //                           Center(
      //                             child: CircularProgressIndicator(),
      //                           ),
      //                           ClipRRect(
      //                             borderRadius: BorderRadius.circular(8),
      //                             clipBehavior: Clip.antiAlias,
      //                             child: CachedNetworkImage(
      //                               placeholder: (context, url) =>
      //                                   CircularProgressIndicator(),
      //                               imageUrl:
      //                                   'http://localhost/Project_flutter_nectec/Data/fileupload2/${upload.image}',
      //                               fit: BoxFit.fill,
      //                               width: size.width,
      //                               height: size.height,
      //                               errorWidget: (context, url, error) =>
      //                                   Image.asset(
      //                                 'images/travel.jpg',
      //                                 fit: BoxFit.cover,
      //                                 width: size.width,
      //                                 height: size.height,
      //                               ),
      //                             ),
      //                           ),
      //                           Padding(
      //                             padding: const EdgeInsets.only(top: 210),
      //                             child: GridTile(
      //                               footer: Material(
      //                                 color: Colors.transparent,
      //                                 shape: RoundedRectangleBorder(
      //                                   borderRadius: BorderRadius.vertical(
      //                                     bottom: Radius.circular(8),
      //                                   ),
      //                                 ),
      //                                 clipBehavior: Clip.antiAlias,
      //                               ),
      //                               child: GridTileBar(
      //                                 backgroundColor: Colors.black26,
      //                                 title: Text(
      //                                   cutWord('${upload.name}'),
      //                                   textAlign: TextAlign.center,
      //                                   softWrap: true,
      //                                   style: TextStyle(
      //                                     fontSize: 18,
      //                                   ),
      //                                 ),
      //                                 subtitle: Text(
      //                                   '${upload.date}',
      //                                   textAlign: TextAlign.center,
      //                                   softWrap: true,
      //                                   style: TextStyle(fontSize: 18),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             //   ],
      //             // ),
      //           );
      //         },
      //         staggeredTileBuilder: (index) => index % 7 == 0
      //             ? StaggeredTile.count(2, 1)
      //             : StaggeredTile.count(1, 1),
      //         mainAxisSpacing: 8,
      //         crossAxisSpacing: 8,
      //         controller: _scrollController,
      //       );
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
      //   ],
      // ),
      //   ),
      // ),
    );
  }
}
