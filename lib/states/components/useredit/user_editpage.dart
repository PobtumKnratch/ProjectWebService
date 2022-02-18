// import 'dart:ffi';
import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
// import 'package:flutter_project_web_supportandservice/Model/user_food_log.dart';
// import 'package:flutter_project_web_supportandservice/Model/user_info.dart';
// import 'package:flutter_project_web_supportandservice/states/Category/food.dart';
// import 'package:flutter_project_web_supportandservice/states/Category/scenario.dart';
// import 'package:flutter_project_web_supportandservice/states/Category/signboard.dart';
// import 'package:flutter_project_web_supportandservice/states/Category/travel.dart';
// import 'package:flutter_project_web_supportandservice/states/controller/category_controller.dart';
// import 'package:flutter_project_web_supportandservice/states/controller/select_controller.dart';
// import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UserEditPage extends StatefulWidget {
  UserEditPage({Key? key}) : super(key: key);
  static const String routeName = '/usereditpage';

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  double _scrollPosition = 0;
  double _opacity = 0;
  final String imagePath = 'images/picturecontent/';

  final CarouselController _controller = CarouselController();

  // List _isHovering = [false, false, false, false, false, false, false];
  // List _isSelected = [true, false, false, false, false, false, false];

  // int _current = 0;

  // final List<String> images = [
  //   'images/picturecontent/wat.jpg',
  //   'images/picturecontent/waterfall.jpg',
  //   'images/picturecontent/khaoyai.jpg',
  //   'images/picturecontent/food4.jpg',
  //   'images/picturecontent/monjam.jpg',
  //   'images/picturecontent/skywalkbaythong.jpeg',
  // ];

  // final List<String> places = [
  //   'วัฒนธรรม',
  //   'แหล่งท่องเที่ยวน้ำตก',
  //   'แหล่งท่องเที่ยวภูเขา',
  //   'อาหารไทย',
  //   'ป้ายสถานที่สำคัญ',
  //   'สถานการณ์ต่างๆ',
  // ];

  // List<Widget> generateImageTiles(screenSize) {
  //   var screenSize = MediaQuery.of(context).size;
  //   return images
  //       .map(
  //         (element) => ClipRRect(
  //           borderRadius: BorderRadius.circular(8.0),
  //           child: Image.asset(
  //             element,
  //             width: screenSize.width,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       )
  //       .toList();
  // }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    var screenSize = MediaQuery.of(context).size;
    // var imageSliders = generateImageTiles(screenSize);
    return Responsive(
      mobile: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: size.height * 0.1),
                height: size.height * 0.5,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(
                        'images/picturebackground/useranno.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black87.withOpacity(0.65), BlendMode.dstATop),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // width: size.width *0.3,
                        // height: size.height *0.3,
                        child: FittedBox(
                          child: Text(
                            'เครื่องมือตรวจสอบข้อมูลคลังรูปภาพ อว.',
                            maxLines: 2,
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Image(
                        image: AssetImage('images/pictureicon/logo.png'),
                        width: size.width * 0.13,
                        height: size.height * 0.13,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      tablet: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: size.height * 0.1),
                height: size.height * 0.53,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(
                        'images/picturebackground/useranno.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black87.withOpacity(0.65), BlendMode.dstATop),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // width: size.width *0.3,
                        // height: size.height *0.3,
                        child: FittedBox(
                          child: Text(
                            'เครื่องมือตรวจสอบข้อมูลคลังรูปภาพ อว.',
                            // maxLines: 2,
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Image(
                        image: AssetImage('images/pictureicon/logo.png'),
                        width: size.width * 0.16,
                        height: size.height * 0.16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      desktop: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: size.height * 0.1),
                height: size.height * 0.72,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(
                        'images/picturebackground/useranno.jpg'),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        Colors.black87.withOpacity(0.65), BlendMode.dstATop),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          'เครื่องมือในการอัพเดทข้อมูลรูปภาพ',
                          maxLines: 2,
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'เครื่องมือตรวจสอบข้อมูลรูปภาพสำหรับผู้ใช้ที่ต้องการเพิ่มเนื้อ \n โดยให้ผู้ใช้สามารถจัดการข้อมูลรูปภาพจากคลังข้อมูลรูปภาพ อว.',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Image(
                        image: AssetImage('images/pictureicon/logo.png'),
                        width: size.width * 0.2,
                        height: size.height * 0.2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // Column(
      //   children: <Widget>[
      //     Stack(
      //       children: <Widget>[
      //         Container(
      //           padding: EdgeInsets.only(top: size.height * 0.1),
      //           height: size.height * 0.72,
      //           width: size.width,
      //           decoration: BoxDecoration(
      //             image: DecorationImage(
      //               image: ExactAssetImage('images/picturebackground/backgroundmain.jpg'),
      //               fit: BoxFit.cover,
      //               colorFilter: ColorFilter.mode(
      //                   Colors.black87.withOpacity(0.65), BlendMode.dstATop),
      //             ),
      //             borderRadius: BorderRadius.only(
      //               bottomLeft: Radius.circular(10),
      //               bottomRight: Radius.circular(10),
      //             ),
      //           ),
      //           margin: EdgeInsets.symmetric(horizontal: 30),
      //           child: Padding(
      //             padding: const EdgeInsets.only(top: 30),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 Container(
      //                   // width: size.width *0.3,
      //                   // height: size.height *0.3,
      //                   child: FittedBox(
      //                     child: Text(
      //                       'เครื่องมือสนับสนุนและบริการข้อมูล \n',
      //                       maxLines: 2,
      //                       style: GoogleFonts.kanit(
      //                         textStyle: TextStyle(
      //                           fontSize: 40,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 Image(
      //                   image: AssetImage('images/pictureicon/logo.png'),
      //                   width: size.width * 0.2,
      //                   height: size.height * 0.2,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(top: 470),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: <Widget>[
      //               Searchandservice(),
      //               // Categories(),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
//     var screenSize = MediaQuery.of(context).size;
//     var imageSliders = generateImageTiles(screenSize);
//     return Padding(
//       padding: EdgeInsets.only(
//         top: screenSize.height * 0.09,
//       ),
//       child: Stack(
//         children: [
//           CarouselSlider(
//             items: imageSliders,
//             options: CarouselOptions(
//                 enlargeCenterPage: true,
//                 aspectRatio: 12 / 5,
//                 autoPlay: true,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     _current = index;
//                     for (int i = 0; i < imageSliders.length; i++) {
//                       if (i == index) {
//                         _isSelected[i] = true;
//                       } else {
//                         _isSelected[i] = false;
//                       }
//                     }
//                   });
//                 }),
//             carouselController: _controller,
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               top: screenSize.height / 3,
//             ),
//             child: AspectRatio(
//               aspectRatio: 15 / 4,
//               child: Center(
//                 child: Text(
//                   places[_current],
//                   style: GoogleFonts.kanit(
//                     textStyle: TextStyle(
//                       // letterSpacing: 5,
//                       // fontFamily: 'Electrolize',
//                       fontSize: screenSize.width / 45,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           AspectRatio(
//             aspectRatio: 15 / 6,
//             child: Center(
//               heightFactor: 10,
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     left: screenSize.width / 8,
//                     right: screenSize.width / 8,
//                   ),
//                   child: Card(
//                     elevation: 5,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         top: screenSize.height / 50,
//                         bottom: screenSize.height / 50,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           for (int i = 0; i < places.length; i++)
//                             Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 InkWell(
//                                   splashColor: Colors.transparent,
//                                   hoverColor: Colors.transparent,
//                                   onHover: (value) {
//                                     setState(() {
//                                       value
//                                           ? _isHovering[i] = true
//                                           : _isHovering[i] = false;
//                                     });
//                                   },
//                                   onTap: () {
//                                     _controller.animateToPage(i);
//                                   },
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                         top: screenSize.height / 80,
//                                         bottom: screenSize.height / 90),
//                                     child: Text(
//                                       places[i],
//                                       style: TextStyle(
//                                         color: _isHovering[i]
//                                             ? Colors.blueGrey[900]
//                                             : Colors.greenAccent.shade700,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Visibility(
//                                   maintainSize: true,
//                                   maintainAnimation: true,
//                                   maintainState: true,
//                                   visible: _isSelected[i],
//                                   child: AnimatedOpacity(
//                                     duration: Duration(milliseconds: 400),
//                                     opacity: _isSelected[i] ? 1 : 0,
//                                     child: Container(
//                                       height: 4,
//                                       decoration: BoxDecoration(
//                                         color: Colors.greenAccent.shade100,
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(12),
//                                         ),
//                                       ),
//                                       width: screenSize.width / 10,
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class UserEditPage extends StatelessWidget {
//   UserEditPage({Key? key}) : super(key: key);
//   static const String routeName = '/usereditpage';
//   double _scrollPosition = 0;
//   double _opacity = 0;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
//     return 
    // Column(
    //   children: <Widget>[
    //     Stack(
    //       children: <Widget>[
    //         Container(
    //           padding: EdgeInsets.only(top: 50),
    //           height: size.height * 0.67,
    //           width: size.width,
    //           decoration: BoxDecoration(
    //             image: DecorationImage(
    //               image: ExactAssetImage('images/picturebackground/backgroundmain.jpg'),
    //               fit: BoxFit.cover,
    //               colorFilter: ColorFilter.mode(
    //                   Colors.black87.withOpacity(0.65), BlendMode.dstATop),
    //             ),
    //             borderRadius: BorderRadius.only(
    //               bottomLeft: Radius.circular(10),
    //               bottomRight: Radius.circular(10),
    //             ),
    //           ),
    //           margin: EdgeInsets.symmetric(horizontal: 30),
    //           child: Padding(
    //             padding: const EdgeInsets.only(top: 30),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Container(
    //                   // width: size.width *0.3,
    //                   // height: size.height *0.3,
    //                   child: FittedBox(
    //                     child: Text(
    //                       'เครื่องมือสนับสนุนและบริการข้อมูล \n',maxLines: 2,
    //                       style: GoogleFonts.kanit(
    //                         textStyle: TextStyle(
    //                           fontSize: 40,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Image(
    //                   image: AssetImage('images/pictureicon/logo.png'),
    //                   width: size.width*0.2,
    //                   height: size.height*0.2,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(top: 470),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //               Searchandservice(),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  // }
// }

// class Searchandservice extends StatefulWidget {
//   @override
//   _SearchandserviceState createState() => _SearchandserviceState();
// }

// class _SearchandserviceState extends State<Searchandservice> {
//   final formKey = GlobalKey<FormState>();
//   final ScrollController _scrollController = ScrollController();

//   File? file;
//   List<String> upload = [];
//   List<String> food = [];
//   bool loading = false, allLoaded = false;

//   mockFetch() async {
//     if (allLoaded) {
//       return;
//     }
//     setState(() {
//       loading = true;
//     });
//     await Future.delayed(Duration(milliseconds: 500));
//     List<String> newData = upload.length >= 60
//         ? []
//         : List.generate(20, (index) => "List Upload ${index + upload.length}");
//     if (newData.isNotEmpty) {
//       upload.addAll(newData);
//     }
//     setState(() {
//       loading = false;
//       allLoaded = newData.isEmpty;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     mockFetch();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//               _scrollController.position.maxScrollExtent &&
//           !loading) {
//         mockFetch();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _scrollController.dispose();
//   }

//   static Future getUploadLocally(BuildContext context) async {
//     try {
//       final assetBundle = DefaultAssetBundle.of(context);
//       final data = await assetBundle.loadString('lib/assets/fileupload.json');
//       final body = usersFormJson(data);
//       return body;
//     } catch (e) {}
//   }

//   Future getUsers() async {
//     try {
//       final url = 'http://localhost/Project_flutter_nectec/viewData.php';
//       final response = await http.get(
//         Uri.parse(url),
//       );
//       return usersFormJson(response.body);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future getFood() async {
//     try {
//       final url = 'http://localhost/Project_flutter_nectec/user_food_log.php';
//       final Foods = await http.get(
//         Uri.parse(url),
//         headers: {
//           HttpHeaders.authorizationHeader: 'xxxx',
//         },
//       );

//       // return foodFromJson(response.body);
//       if (Foods.statusCode == 200) {
//         print(Foods);
//         return foodFromJson(Foods.body);
//       } else {
//         print(Foods.statusCode);
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future getupload() async {
//     try {
//       final url =
//           'http://localhost/Project_flutter_nectec/Data/ShowData/fileupload2.php';
//       final response = await http.get(Uri.parse(url));
//       print(response);
//       return uploadFromJson(response.body);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future<void> pickerimage(ImageSource imageSource) async {
//     try {
//       var myfile = await ImagePicker().getImage(
//         source: imageSource,
//         maxHeight: 50.0,
//         maxWidth: 50.0,
//       );
//       setState(() {
//         file = File(myfile!.path);
//       });
//     } catch (e) {}
//   }

//   Widget showImage() {
//     // double size = MediaQuery.of(context).size.height*0.4;
//     return Container(
//       // color: Colors.blueAccent.shade200,
//       width: MediaQuery.of(context).size.width * 0.4,
//       height: MediaQuery.of(context).size.height * 0.4,
//       child: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//               left: 30,
//               top: 7,
//             ),
//             child: Container(
//               width: 500,
//               // height: size*0.4,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(7.0),
//                 border: Border.all(color: Colors.black45, width: 1.2),
//               ),
//               child: file == null
//                   ? Text(
//                       "กรุณากดปุ่ม"
//                       "อัพโหลด"
//                       "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
//                       style: GoogleFonts.kanit(
//                         textStyle: TextStyle(
//                           fontSize: 16,
//                           color: Colors.redAccent.shade200,
//                         ),
//                       ),
//                       textAlign: TextAlign.center,
//                     )
//                   : Image.network(file!.path),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _scrollPosition = 0;
//   double _opacity = 0;
//     Size size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: Stack(
//                   children: [
//                     Form(
//                       key: formKey,
//                       child: SizedBox(
//                         width: 700,
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return '    กรุณากรอกข้อมูลที่ใช้สำหรับการค้นหาชื่อสถานที่ , ชื่ออาหารหรือชื่อกิจกรรม';
//                             }
//                           },
//                           decoration: InputDecoration(
//                               errorStyle: TextStyle(
//                                   color: Colors.red.shade400,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                               prefixIcon: Icon(Icons.search),
//                               hintText:
//                                   'กรุณากรอกข้อมูล ชื่อสถานที่ , ชื่ออาหาร , ชื่อกิจกรรม เพื่อทำการค้นหา',
//                               hintStyle: GoogleFonts.kanit(
//                                 textStyle: TextStyle(fontSize: 18),
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(18),
//                                 borderSide:
//                                     BorderSide(color: Colors.black54, width: 1),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(18),
//                                 borderSide:
//                                     BorderSide(color: Colors.black54, width: 1),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Stack(
//                   children: [
//                     FlatButton(
//                       onPressed: () {
//                         if (formKey.currentState!.validate()) {}
//                       },
//                       color: Colors.greenAccent.shade400,
//                       height: 50,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Text(
//                         'ค้นหา',
//                         style: GoogleFonts.kanit(
//                           textStyle:
//                               TextStyle(color: Colors.black, fontSize: 18),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: Stack(
//                   children: [
//                     Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             MaterialButton(
//                               onPressed: () {
//                                 pickerimage(ImageSource.gallery);
//                               },
//                               color: Colors.greenAccent.shade400,
//                               height: 45,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Text(
//                                 'เลือกรูปภาพ',
//                                 style: GoogleFonts.kanit(
//                                   textStyle: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             showImage(),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Categories(),
//           // FutureBuilder<List<User>>(
//           //   future: getUploadLocally(context),
//           //   builder: (context, snapshot) {
//           //     if (upload.isNotEmpty) {
//           //       return ListView.builder(
//           //         shrinkWrap: true,
//           //         physics: BouncingScrollPhysics(),
//           //         controller: _scrollController,
//           //         itemCount: snapshot.data.length,
//           //         itemBuilder: (Upload, index) {
//           //           final upload = snapshot.data[index];
//           //           return ListTile(
//           //             title: Container(
//           //               child: Image.network(
//           //                 "http://localhost/Project_flutter_nectec/mhesi-covid19-data/food-images/${upload.image}",
//           //                 width: 100,
//           //                 height: 100,
//           //                 errorBuilder: (context, error, stackTrace) {
//           //                   return Center(
//           //                     child: Text('No Image Data'),
//           //                   );
//           //                 },
//           //               ),
//           //             ),
//           //             subtitle: Center(
//           //               child: Text('${upload.name}'),
//           //             ),
//           //           );
//           //         },
//           //       );
//           //     } else {
//           //       return Center(
//           //         child: CircularProgressIndicator(),
//           //       );
//           //     }
//           //   },
//           // ),
//           SizedBox(
//             height: 20,
//           ),
//           // FutureBuilder<List<Upload>>(
//           //   future: getupload(),
//           //   builder: (context, snapshot) {
//           //     if (upload.isNotEmpty) {
//           //       return StaggeredGridView.countBuilder(
//           //         padding: EdgeInsets.symmetric(
//           //           horizontal: 30,
//           //         ),
//           //         shrinkWrap: true,
//           //         primary: false,
//           //         physics: BouncingScrollPhysics(),
//           //         crossAxisCount: 5,
//           //         itemCount: snapshot.data.length,
//           //         itemBuilder: (Upload, index) {
//           //           final upload = snapshot.data[index];
//           //           return Card(
//           //             margin: EdgeInsets.zero,
//           //             shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.circular(8),
//           //             ),
//           //             child: Padding(
//           //               padding: const EdgeInsets.all(8.0),
//           //               child: Container(
//           //                 alignment: Alignment.center,
//           //                 child: Column(
//           //                   mainAxisAlignment: MainAxisAlignment.start,
//           //                   crossAxisAlignment: CrossAxisAlignment.start,
//           //                   children: [
//           //                     Flexible(
//           //                       flex: 1,
//           //                       fit: FlexFit.loose,
//           //                       child: Stack(
//           //                         children: [
//           //                           Center(
//           //                             child: CircularProgressIndicator(),
//           //                           ),
//           //                           ClipRRect(
//           //                             borderRadius: BorderRadius.circular(8),
//           //                             clipBehavior: Clip.antiAlias,
//           //                             child: CachedNetworkImage(
//           //                               placeholder: (context, url) =>
//           //                                   CircularProgressIndicator(),
//           //                               imageUrl:
//           //                                   'http://localhost/Project_flutter_nectec/Data/fileupload2/${upload.image}',
//           //                               fit: BoxFit.fill,
//           //                               width: size.width,
//           //                               height: size.height,
//           //                               errorWidget: (context, url, error) =>
//           //                                   Image.asset(
//           //                                 'images/travel.jpg',
//           //                                 fit: BoxFit.cover,
//           //                                 width: size.width,
//           //                                 height: size.height,
//           //                               ),
//           //                             ),
//           //                           ),
//           //                           Padding(
//           //                             padding: const EdgeInsets.only(top: 210),
//           //                             child: GridTile(
//           //                               footer: Material(
//           //                                 color: Colors.transparent,
//           //                                 shape: RoundedRectangleBorder(
//           //                                   borderRadius: BorderRadius.vertical(
//           //                                     bottom: Radius.circular(8),
//           //                                   ),
//           //                                 ),
//           //                                 clipBehavior: Clip.antiAlias,
//           //                               ),
//           //                               child: GridTileBar(
//           //                                 backgroundColor: Colors.black26,
//           //                                 title: Text(
//           //                                   cutWord('${upload.name}'),
//           //                                   textAlign: TextAlign.center,
//           //                                   softWrap: true,
//           //                                   style: TextStyle(
//           //                                     fontSize: 18,
//           //                                   ),
//           //                                 ),
//           //                                 subtitle: Text(
//           //                                   '${upload.date}',
//           //                                   textAlign: TextAlign.center,
//           //                                   softWrap: true,
//           //                                   style: TextStyle(fontSize: 18),
//           //                                 ),
//           //                               ),
//           //                             ),
//           //                           ),
//           //                         ],
//           //                       ),
//           //                     ),
//           //                   ],
//           //                 ),
//           //               ),
//           //             ),
//           //             //   ],
//           //             // ),
//           //           );
//           //         },
//           //         staggeredTileBuilder: (index) => index % 7 == 0
//           //             ? StaggeredTile.count(2, 1)
//           //             : StaggeredTile.count(1, 1),
//           //         mainAxisSpacing: 8,
//           //         crossAxisSpacing: 8,
//           //         controller: _scrollController,
//           //       );
//           //     } else {
//           //       return Center(
//           //         child: CircularProgressIndicator(),
//           //       );
//           //     }
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }

//   String cutWord(String name) {
//     String result = name;
//     if (result.length > 6) {
//       result = result.substring(0, 5);
//       result = '$result ...';
//     }
//     return result;
//   }
// }

// class Categories extends StatefulWidget {
//   const Categories({Key? key}) : super(key: key);

//   @override
//   _CategoriesState createState() => _CategoriesState();
// }

// class _CategoriesState extends State<Categories> {
//   List<Widget> categories = [
//     Travel(),
//     Scenario(),
//     FoodState(),
//     Signboard(),
//   ];
//   int selectIndex = 0;

//   Widget menubuild() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           // width: size.wi,
//           child: FittedBox(
//             child: Text(
//               "ข้อมูลการท่องเที่ยว",
//               textAlign: TextAlign.start,
//               style: GoogleFonts.kanit(
//                 textStyle: TextStyle(
//                   fontSize: 45,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 220, bottom: 20),
//           child: menubuild(),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             travel(),
//             scenario(),
//             food(),
//             signboard(),
//           ],
//         ),
//         categories[selectIndex],
//       ],
//     );
//   }

//   Widget travel() {
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
//                 selectIndex = 0;
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
//                       height: 200,
//                       width: 250,
//                       image: AssetImage('images/picturecontent/travel.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: 20, left: 82, right: 82, bottom: 120),
//                       child: Text(
//                         'TRAVEL',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold),
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

//   Widget scenario() {
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
//                 selectIndex = 1;
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
//                       height: 200,
//                       width: 250,
//                       image: AssetImage('images/picturecontent/scenario1.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: 50, left: 20, right: 65, bottom: 60),
//                       child: Text(
//                         'SCENARIO',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold),
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

//   Widget food() {
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
//                       height: 200,
//                       width: 250,
//                       image: AssetImage('images/picturecontent/food1.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: 80, left: 85, right: 82, bottom: 15),
//                       child: Text(
//                         'FOOD',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.monoton(
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
//                       height: 200,
//                       width: 260,
//                       image: AssetImage('images/picturecontent/signboard2.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: 80, left: 58, right: 58, bottom: 10),
//                       child: Text(
//                         'SIGNBOARD',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold),
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
// }
