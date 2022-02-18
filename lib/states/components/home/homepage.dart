import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/widget/search.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({ Key? key }) : super(key: key);
    double _scrollPosition = 0;
  double _opacity = 0;
  // final Size screenSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
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
                        'images/picturebackground/backgroundhome.jpg'),
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
                            'เครื่องมือสนับสนุนและบริการข้อมูลคลังข้อมูลรูปภาพ',
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
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.42),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Searchandservice(),
                    // Categories(),
                  ],
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
                        'images/picturebackground/backgroundhome.jpg'),
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
                            'เครื่องมือสนับสนุนและบริการข้อมูล',
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
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Searchandservice(),
                    // Categories(),
                  ],
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
                        'images/picturebackground/backgroundhome.jpg'),
                    fit: BoxFit.cover,
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
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // width: size.width *0.3,
                        // height: size.height *0.3,
                        child: FittedBox(
                          child: Text(
                            'เครื่องมือสนับสนุนและบริการข้อมูล \n',
                            maxLines: 2,
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
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
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.68),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Searchandservice(),
                    // Categories(),
                  ],
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
