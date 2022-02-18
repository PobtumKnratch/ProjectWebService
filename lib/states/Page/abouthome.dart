// import 'package:flutter/material.dart';
// import 'package:flutter_project_web_supportandservice/Model/model_aboutme.dart';
// import 'package:flutter_project_web_supportandservice/states/components/about/aboutme_card.dart';
// import 'package:flutter_project_web_supportandservice/states/components/about/aboutme_carousel.dart';
// import 'package:flutter_project_web_supportandservice/widget/bottom_bar.dart';
// import 'package:flutter_project_web_supportandservice/widget/drawhome.dart';
// import 'package:flutter_project_web_supportandservice/widget/headerhome.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AboutHome extends StatelessWidget {
//    AboutHome({ Key? key }) : super(key: key);
//   static const String routeName = '/abouthome';
//   late double _opacity = 0;

//   final icon = [
//     Icons.travel_explore_outlined,
//     Icons.fastfood_rounded,
//     Icons.bedroom_parent_outlined,
//     Icons.schedule_send_outlined,
//   ];

//   final List<String> titlehead = [
//     'หมวดท่องเที่ยว',
//     'หมวดอาหาร',
//     'หมวดป้ายสถานที่',
//     'หมวดสถานการณ์',
//   ];

//   final List<String> titlesub = [
//     'ข้อมูลพิกัดสถานที่ภายในรูปภาพ',
//     'คำอธิบายรูปภาพประกอบ',
//     'วันเวลาของข้อมูลรูปภาพ',
//     'รูปแบบของข้อมูลที่มีความหลากหลาย',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size(size.width, 70),
//         child: HeaderHome(_opacity),
//       ),
//       drawer: createDrawerhome(context),
//       extendBodyBehindAppBar: true,
//       endDrawer: ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: 300),
//         child: createDrawerhome(context),
//       ),
//       body: Container(
//         color: Colors.greenAccent.shade100,
//         width: size.width,
//         height: size.height,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               // Padding(
//               //   padding: EdgeInsets.only(top: size.height * 0.1),
//               //   child: Card(
//               //     clipBehavior: Clip.antiAlias,
//               //     elevation: 16,
//               //     semanticContainer: size.height.isFinite,
//               //     shape: RoundedRectangleBorder(
//               //         // side: BorderSide(),
//               //         borderRadius: BorderRadius.circular(15)),
//               //     child: Text('sjdmfkvm'),
//               //   ),
//               // ),
//               Padding(
//                 padding: EdgeInsets.only(top: size.height * 0.09),
//                 child: Container(
//                   height: size.height / 1.8,
//                   width: size.width,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: size.width * 0.14),
//                     child: Padding(
//                       padding: EdgeInsets.only(top: size.height * 0.03),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'เกี่ยวกับเรา',
//                             style: GoogleFonts.kanit(
//                               textStyle: TextStyle(
//                                 fontSize: screenSize.width / 65,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: size.height * 0.03),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Card(
//                                   child: Image.asset(
//                                     'images/picturecontent/wat.jpg',
//                                     fit: BoxFit.fill,
//                                     height: size.height * 0.37,
//                                     width: size.width * 0.3,
//                                   ),
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                         top: size.height * 0.02,
//                                         left: size.width * 0.02,
//                                       ),
//                                       child: Text(
//                                         'ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ',
//                                         style: GoogleFonts.kanit(
//                                           textStyle: TextStyle(
//                                             fontSize: screenSize.width / 75,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           left: size.width * 0.02,
//                                           top: size.height * 0.01),
//                                       child: Text(
//                                         '"ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" เป็นระบบส่วนเสริมที่มีการนำข้อมูลของคลังข้อมูล\nรูปภาพ อว. หรือกระทรวงการอุดมศึกษา วิทยาศาสตร์วิจัยและนวัตกรรม เป็นระบบที่เป็นการนำ\nข้อมูลมาใช้ในการของการบริการข้อมูลให้กับประชาชนในการค้นหาหรือดูข้อมูลจากคลังข้อมูลของ\nโครงการโดยทางโครงการได้มีข้อมูลทั้งหมด 4 หมวด ประกอบด้วย ',
//                                         style: GoogleFonts.kanit(
//                                           textStyle: TextStyle(
//                                             fontSize: screenSize.width / 100,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           left: size.width * 0.02,
//                                           top: size.height * 0.02),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                               width: screenSize.width / 15),
//                                           ...Iterable<int>.generate(icon.length)
//                                               .map(
//                                             (int index) => Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Icon(
//                                                   icon[index],
//                                                   color: Colors
//                                                       .greenAccent.shade700,
//                                                   size: 18,
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                       left: size.width * 0.004),
//                                                   child: Text(
//                                                     titlehead[index],
//                                                     style: GoogleFonts.kanit(
//                                                       textStyle: TextStyle(
//                                                         fontSize:
//                                                             screenSize.width /
//                                                                 100,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: size.height / 1.6,
//                 width: size.width,
//                 decoration: BoxDecoration(
//                     // color: Colors.blue,
//                     ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: size.width * 0.14),
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       top: size.height * 0.05,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   top: size.height * 0.1,
//                                   left: size.width * 0.02),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'เนื้อหาของคลังข้อมูลรูปภาพ อว.',
//                                     style: GoogleFonts.kanit(
//                                       textStyle: TextStyle(
//                                         fontSize: screenSize.width / 75,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: size.height * 0.01,
//                                   ),
//                                   Text(
//                                     'ข้อมูลของคลังข้อมูลรูปภาพ อว. เป็นข้อมูลที่ได้จากการ\nเก็บรวบรวมโดยเป็นความร่วมมือระหว่างนักวิจัยกับประชาชน\nโดยมีประชาชนเป็นผู้เก็บรวบรวมข้อมูลดังกล่าวบันทึกลงบน\nคลังข้อมูลรูปภาพซึ่งรายละเอียดของข้อมูลต่างๆที่ถูกบันทึก\nลงจะประกอบด้วย',
//                                     style: GoogleFonts.kanit(
//                                       textStyle: TextStyle(
//                                         fontSize: screenSize.width / 100,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: size.height * 0.01,
//                                   ),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(width: screenSize.width / 15),
//                                       ...Iterable<int>.generate(icon.length)
//                                           .map(
//                                         (int index) => Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Icon(
//                                               Icons.check,
//                                               color:
//                                                   Colors.greenAccent.shade700,
//                                               size: 18,
//                                             ),
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: size.width * 0.004),
//                                               child: Text(
//                                                 titlesub[index],
//                                                 style: GoogleFonts.kanit(
//                                                   textStyle: TextStyle(
//                                                     fontSize:
//                                                         screenSize.width / 100,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: size.width * 0.01),
//                               child: Container(
//                                 height: 400,
//                                 width: 650,
//                                 child: AboutMeCarousel(),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: size.height / 1.5,
//                 width: size.width,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: size.width * 0.14),
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       top: size.height * 0.05,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Text(
//                             'รูปแบบการใช้งาน',
//                             style: GoogleFonts.kanit(
//                               textStyle: TextStyle(
//                                 fontSize: screenSize.width / 65,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: size.height * 0.01,
//                         ),
//                         Center(
//                           child: Text(
//                             'การใช้งาน "ระบบชุดเครื่องมือสำหรับคลังข้อมูลรูปภาพ" มีขั้นตอนดังนี้',
//                             style: GoogleFonts.kanit(
//                               textStyle: TextStyle(
//                                 fontSize: screenSize.width / 85,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: size.height * 0.02),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: List.generate(aboutme.length,
//                                 (index) => AboutMeCard(index: index)),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               BottomBar(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }