import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
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
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.03),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.grey[200],
        elevation: 10,
        margin:
            EdgeInsets.symmetric(horizontal: sizeWidth * 0.08, vertical: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: size.width*0.03),
                child: Container(
                  margin: EdgeInsets.all(15),
                  width: sizeWidth * 0.25,
                  height: sizeWidth * 0.15,
                  child: ClipRRect(borderRadius: BorderRadius.circular(15),
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
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'ชื่อรูปภาพ : ',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: sizeWidth*0.01,
                          ),
                        ),
                      ),
                      Text(
                        widget.model.name,
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: sizeWidth*0.01,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'คำอธิบายรูปภาพ : ',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: sizeWidth*0.01,
                          ),
                        ),
                      ),
                      Text(
                        widget.model.description,
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: sizeWidth*0.01,
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
                            fontSize: sizeWidth*0.01,
                          ),
                        ),
                      ),
                      Text(
                        '${date!.day} ${allMonth[date!.month - 1]} ${date!.year + 543}',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: sizeWidth*0.01,
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
                            fontSize: sizeWidth*0.01,
                          ),
                        ),
                      ),
                      Text(
                        '${date!.hour.toString().padLeft(2, '0')} : ${date!.minute.toString().padLeft(2, '0')}',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: sizeWidth*0.01,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ]),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   var size = MediaQuery.of(context).size;
  //   _opacity = _scrollPosition < size.height * 0.40
  //       ? _scrollPosition / (size.height * 0.40)
  //       : 1;
  //   Size sized = MediaQuery.of(context).size;
  //   return Column(
  //     children: [
  //       Container(
  //         // width: 200,
  //         child: Padding(
  //           padding: EdgeInsets.only(top: size.height * 0.07),
  //           child: Card(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(15.0),
  //             ),
  //             color: Colors.grey[200],
  //             elevation: 10,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               // mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 Padding(
  //                   padding: EdgeInsets.only(
  //                       top: size.height * 0.02,
  //                       left: size.width * 0.02,
  //                       bottom: size.height * 0.02),
  //                   child: Container(
  //                     width: size.width * 0.25,
  //                     height: size.height * 0.25,
  //                     decoration: BoxDecoration(
  //                       color: const Color(0xff7c94b6),
  //                       image: const DecorationImage(
  //                         image: AssetImage('images/picturecontent/food1.jpg'),
  //                         fit: BoxFit.cover,
  //                       ),
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(
  //                       top: size.height * 0.02, left: size.width * 0.02),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       // ListTile(
  //                       //   leading: Text(
  //                       //     'ชื่อรูปภาพ : ',
  //                       //     style: GoogleFonts.kanit(
  //                       //       textStyle: TextStyle(
  //                       //         fontSize: 20,
  //                       //       ),
  //                       //     ),
  //                       //   ),
  //                       // ),
  //                       // Row(
  //                       //   mainAxisAlignment: MainAxisAlignment.start,
  //                       //   crossAxisAlignment: CrossAxisAlignment.start,
  //                       //   children: [
  //                       //     Text(
  //                       //       'ชื่อรูปภาพ : ',
  //                       //       style: GoogleFonts.kanit(
  //                       //         textStyle: TextStyle(
  //                       //           fontSize: 20,
  //                       //         ),
  //                       //       ),
  //                       //     ),
  //                       //     Text(
  //                       //       'ข้าวสอย',
  //                       //       style: GoogleFonts.kanit(
  //                       //         textStyle: TextStyle(
  //                       //           fontSize: 20,
  //                       //         ),
  //                       //       ),
  //                       //     ),
  //                       //   ],
  //                       // ),
  //                       Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             'คำอธิบายรูปภาพ : ',
  //                             style: GoogleFonts.kanit(
  //                               textStyle: TextStyle(
  //                                 fontSize: 20,
  //                               ),
  //                             ),
  //                           ),
  //                           Text(
  //                             'เป็นอาหารพื้นเมืองของทางภาคเหนือ',
  //                             style: GoogleFonts.kanit(
  //                               textStyle: TextStyle(
  //                                 fontSize: 20,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 // Spacer(),
  //                 // Padding(
  //                 //   padding: EdgeInsets.only(
  //                 //       bottom: size.height * 0.01, top: size.height * 0.31),
  //                 //   child: ButtonTheme(
  //                 //     child: ButtonBar(
  //                 //       children: <Widget>[
  //                 // FlatButton(
  //                 //   child: Text(
  //                 //     'Edit',
  //                 //     style: GoogleFonts.kanit(
  //                 //       textStyle: TextStyle(
  //                 //           fontSize: 20, color: Colors.black),
  //                 //     ),
  //                 //   ),
  //                 //   onPressed: () => {
  //                 //     Navigator.push(
  //                 //       context,
  //                 //       MaterialPageRoute(
  //                 //         builder: (context) => EditData(),
  //                 //       ),
  //                 //     ),
  //                 //   },
  //                 // ),
  //                 // Padding(
  //                 //   padding: EdgeInsets.only(
  //                 //     left: size.width * 0.01,
  //                 //     // right: size.width * 0.05,
  //                 //   ),
  //                 //   child: FlatButton(
  //                 //     child: Text(
  //                 //       'Delete',
  //                 //       style: GoogleFonts.kanit(
  //                 //         textStyle: TextStyle(
  //                 //             fontSize: 20, color: Colors.black),
  //                 //       ),
  //                 //     ),
  //                 //     onPressed: () {},
  //                 //   ),
  //                 // ),
  //                 //       ],
  //                 //     ),
  //                 //   ),
  //                 // ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       // Container(
  //       //   // width: 200,
  //       //   child: Card(
  //       //     shape: RoundedRectangleBorder(
  //       //       borderRadius: BorderRadius.circular(15.0),
  //       //     ),
  //       //     color: Colors.pink,
  //       //     elevation: 10,
  //       //     child: Row(
  //       //       // mainAxisSize: MainAxisSize.min,
  //       //       children: <Widget>[
  //       //         Padding(
  //       //           padding: EdgeInsets.only(
  //       //               top: size.height * 0.01,
  //       //               left: size.width * 0.01,
  //       //               bottom: size.height * 0.01),
  //       //           child: Column(
  //       //             children: [
  //       //               Container(
  //       //                 width: size.width * 0.35,
  //       //                 height: size.height * 0.35,
  //       //                 decoration: BoxDecoration(
  //       //                   color: const Color(0xff7c94b6),
  //       //                   image: const DecorationImage(
  //       //                     image:
  //       //                         AssetImage('images/picturecontent/food1.jpg'),
  //       //                     fit: BoxFit.cover,
  //       //                   ),
  //       //                   borderRadius: BorderRadius.circular(12),
  //       //                 ),
  //       //               ),
  //       //               // Image.asset(
  //       //               //   'images/picturecontent/food1.jpg',
  //       //               //   width: size.width * 0.35,
  //       //               //   height: size.height * 0.35,
  //       //               //   fit: BoxFit.fill,
  //       //               // ),

  //       //               // ListTile(
  //       //               //   // leading: Icon(Icons.album, size: 70),
  //       //               //   title:
  //       //               //       Text('Heart Shaker', style: TextStyle(color: Colors.white)),
  //       //               //   subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
  //       //               // ),
  //       //             ],
  //       //           ),
  //       //         ),
  //       //         ButtonTheme(
  //       //           child: ButtonBar(
  //       //             children: <Widget>[
  //       //               FlatButton(
  //       //                 child: const Text('Edit',
  //       //                     style: TextStyle(color: Colors.white)),
  //       //                 onPressed: () {},
  //       //               ),
  //       //               FlatButton(
  //       //                 child: const Text('Delete',
  //       //                     style: TextStyle(color: Colors.white)),
  //       //                 onPressed: () {},
  //       //               ),
  //       //             ],
  //       //           ),
  //       //         ),
  //       //       ],
  //       //     ),
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }
}
