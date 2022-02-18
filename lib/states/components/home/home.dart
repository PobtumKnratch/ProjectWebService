// import 'package:flutter/material.dart';
// import 'package:flutter_project_web_supportandservice/responsive.dart';
// import 'package:flutter_project_web_supportandservice/states/components/home/homepage.dart';
// import 'package:flutter_project_web_supportandservice/widget/bottom_bar.dart';
// import 'package:flutter_project_web_supportandservice/widget/drawhome.dart';
// import 'package:flutter_project_web_supportandservice/widget/featured_heading.dart';
// import 'package:flutter_project_web_supportandservice/widget/featured_tiles.dart';
// import 'package:flutter_project_web_supportandservice/widget/headerhome.dart';
// import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';

// class Home extends StatelessWidget {
//   static const String routeName = '/home';
//   double _scrollPosition = 0;
//   double _opacity = 0;
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
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
//       body: MaxWidthCintainer(
//         child: Responsive(
//           mobile: isMobileContent(),
//           tablet: isTabletContent(),
//           desktop: isDesktopContent(),
//         ),
//       ),
//       // Container(
//       //   color: Colors.white,
//       //   width: size.width,
//       //   height: size.height,
//       //   child: SingleChildScrollView(
//       //     child: Column(
//       //       crossAxisAlignment: CrossAxisAlignment.start,
//       //       mainAxisAlignment: MainAxisAlignment.start,
//       //       children: <Widget>[
//       //         Detail(),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }

// class isMobileContent extends StatelessWidget {
//   isMobileContent({Key? key}) : super(key: key);
//   double _scrollPosition = 0;
//   double _opacity = 0;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
//     return Container(
//       color: Colors.white,
//       width: size.width,
//       height: size.height,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             // Detail(),
//             // FeaturedHeading(screenSize: size,),
//             // FeaturedTiles(screenSize: size,),
//             // // FeaturedList(screenSize: size,),
//             // MainHeading(screenSize: size,),
//             // Carousel(),
//             // // Categories(),
//             // BottomBar(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class isTabletContent extends StatelessWidget {
//   isTabletContent({Key? key}) : super(key: key);
//   double _scrollPosition = 0;
//   double _opacity = 0;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     _opacity = _scrollPosition < size.height * 0.40
//         ? _scrollPosition / (size.height * 0.40)
//         : 1;
//     return Container(
//       color: Colors.white,
//       width: size.width,
//       height: size.height,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             // Detail(),
//             // FeaturedHeading(screenSize: size,),
//             // FeaturedTiles(screenSize: size,),
//             // // FeaturedList(screenSize: size,),
//             // MainHeading(screenSize: size,),
//             // Carousel(),
//             // // Categories(),
//             // BottomBar(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class isDesktopContent extends StatelessWidget {
//   isDesktopContent({Key? key}) : super(key: key);
//   double _scrollPosition = 0;
//   double _opacity = 0;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // _opacity = _scrollPosition < size.height * 0.40
//     //     ? _scrollPosition / (size.height * 0.40)
//     //     : 1;
//     return Container(
//       color: Colors.white,
//       width: size.width,
//       height: size.height,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             HomePage(),
//             FeaturedHeading(
//               screenSize: size,
//             ),
//             FeaturedTiles(
//               screenSize: size,
//             ),
//             // // FeaturedList(screenSize: size,),
//             // MainHeading(screenSize: size,),
//             // Carousel(),
//             // Categories(),
//             SizedBox(
//               height: size.height * 0.1,
//             ),
//             BottomBar(),
//           ],
//         ),
//       ),
//     );
//   }
// }
