import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class UserAnnoPage extends StatefulWidget {
  const UserAnnoPage({Key? key}) : super(key: key);
  static const String routeName = '/userannopage';

  @override
  _UserAnnoPageState createState() => _UserAnnoPageState();
}

class _UserAnnoPageState extends State<UserAnnoPage> {
  double _scrollPosition = 0;
  double _opacity = 0;
  final String imagePath = 'images/picturecontent/';

  final CarouselController _controller = CarouselController();

  List _isHovering = [false, false, false, false, false, false, false];
  List _isSelected = [true, false, false, false, false, false, false];

  int _current = 0;

  final List<String> images = [
    'images/picturecontent/wat.jpg',
    'images/picturecontent/waterfall.jpg',
    'images/picturecontent/khaoyai.jpg',
    'images/picturecontent/food4.jpg',
    'images/picturecontent/monjam.jpg',
    'images/picturecontent/skywalkbaythong.jpeg',
  ];

  final List<String> places = [
    'วัฒนธรรม',
    'แหล่งท่องเที่ยวน้ำตก',
    'แหล่งท่องเที่ยวภูเขา',
    'อาหารไทย',
    'ป้ายสถานที่สำคัญ',
    'สถานการณ์ต่างๆ',
  ];

  List<Widget> generateImageTiles(screenSize) {
    var screenSize = MediaQuery.of(context).size;
    return images
        .map(
          (element) => ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              element,
              width: screenSize.width,
              fit: BoxFit.cover,
            ),
          ),
        )
        .toList();
  }

  @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   _opacity = _scrollPosition < size.height * 0.40
  //       ? _scrollPosition / (size.height * 0.40)
  //       : 1;
  //   var screenSize = MediaQuery.of(context).size;
  //   var imageSliders = generateImageTiles(screenSize);
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       top: screenSize.height * 0.09,
  //     ),
  //     child: Stack(
  //       children: [
  //         CarouselSlider(
  //           items: imageSliders,
  //           options: CarouselOptions(
  //               enlargeCenterPage: true,
  //               aspectRatio: 12 / 5,
  //               autoPlay: true,
  //               onPageChanged: (index, reason) {
  //                 setState(() {
  //                   _current = index;
  //                   for (int i = 0; i < imageSliders.length; i++) {
  //                     if (i == index) {
  //                       _isSelected[i] = true;
  //                     } else {
  //                       _isSelected[i] = false;
  //                     }
  //                   }
  //                 });
  //               }),
  //           carouselController: _controller,
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(
  //             top: screenSize.height / 3,
  //           ),
  //           child: AspectRatio(
  //             aspectRatio: 15 / 4,
  //             child: Center(
  //               child: Text(
  //                 places[_current],
  //                 style: GoogleFonts.kanit(
  //                   textStyle: TextStyle(
  //                     // letterSpacing: 5,
  //                     // fontFamily: 'Electrolize',
  //                     fontSize: screenSize.width / 45,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         AspectRatio(
  //           aspectRatio: 15 / 6,
  //           child: Center(
  //             heightFactor: 10,
  //             child: Align(
  //               alignment: Alignment.bottomCenter,
  //               child: Padding(
  //                 padding: EdgeInsets.only(
  //                   left: screenSize.width / 8,
  //                   right: screenSize.width / 8,
  //                 ),
  //                 child: Card(
  //                   elevation: 5,
  //                   child: Padding(
  //                     padding: EdgeInsets.only(
  //                       top: screenSize.height / 50,
  //                       bottom: screenSize.height / 50,
  //                     ),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         for (int i = 0; i < places.length; i++)
  //                           Column(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               InkWell(
  //                                 splashColor: Colors.transparent,
  //                                 hoverColor: Colors.transparent,
  //                                 onHover: (value) {
  //                                   setState(() {
  //                                     value
  //                                         ? _isHovering[i] = true
  //                                         : _isHovering[i] = false;
  //                                   });
  //                                 },
  //                                 onTap: () {
  //                                   _controller.animateToPage(i);
  //                                 },
  //                                 child: Padding(
  //                                   padding: EdgeInsets.only(
  //                                       top: screenSize.height / 80,
  //                                       bottom: screenSize.height / 90),
  //                                   child: Text(
  //                                     places[i],
  //                                     style: TextStyle(
  //                                       color: _isHovering[i]
  //                                           ? Colors.blueGrey[900]
  //                                           : Colors.greenAccent.shade700,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               Visibility(
  //                                 maintainSize: true,
  //                                 maintainAnimation: true,
  //                                 maintainState: true,
  //                                 visible: _isSelected[i],
  //                                 child: AnimatedOpacity(
  //                                   duration: Duration(milliseconds: 400),
  //                                   opacity: _isSelected[i] ? 1 : 0,
  //                                   child: Container(
  //                                     height: 4,
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.greenAccent.shade100,
  //                                       borderRadius: BorderRadius.all(
  //                                         Radius.circular(12),
  //                                       ),
  //                                     ),
  //                                     width: screenSize.width / 10,
  //                                   ),
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    var screenSize = MediaQuery.of(context).size;
    var imageSliders = generateImageTiles(screenSize);
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
                        'images/picturebackground/backgroundmain.jpg'),
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
                        'images/picturebackground/backgroundmain.jpg'),
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
                          'เครื่องมือตรวจสอบข้อมูลคลังรูปภาพ อว.',
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
                        'เครื่องมือตรวจสอบข้อมูลรูปภาพโดยใช้เครื่องมือที่ได้จัดทำขึ้นคือตัวเครื่องมือคำอธิบายรูปภาพ \n โดยให้ผู้ใช้ที่มีหน้าที่ตรวจสอบข้อมูลรูปจากคลังข้อมูลรูปภาพ อว.',
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
