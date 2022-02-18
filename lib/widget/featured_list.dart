// import 'package:flutter_project_web_supportandservice/responsive.dart';
// import 'package:flutter/material.dart';

// class FeaturedList extends StatelessWidget {
//   FeaturedList({
//     Key? key,
//     required this.screenSize,
//   }) : super(key: key);

//   final Size screenSize;

//   final List<String> assets = [
//     'images/wat1.jpg',
//     'images/food2.jpg',
//     'images/signboard2.jpg',
//     'images/sea ​​of ​​fog.jpeg',
//   ];

//   final List<String> title = [
//     'ท่องเที่ยว',
//     'อาหาร',
//     'ป้ายสถานที่',
//     'สถานการณ์',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Responsive.isMobileContent(context)
//         ? Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         children: [
//           ...Iterable<int>.generate(assets.length).map(
//                   (int pageIndex) =>
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Text(
//                   title[pageIndex],
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 height: assets.isEmpty ? 500.0 : 220.0,
//                 child: ListView.builder(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 12.0,
//                     horizontal: 16.0,
//                   ),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: assets.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final AssetImage content = assets[index] as AssetImage;
//                     return GestureDetector(
//                       // onTap: () => print(content.assetName), 
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                         height: assets.isEmpty ? 400.0 : 200.0,
//                         width: assets.isEmpty ? 200.0 : 130.0,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage(content.assetName),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         ],
//       ),
//         );
//   }
// }
