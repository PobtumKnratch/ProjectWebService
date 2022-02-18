import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/user_anno.dart';
import 'package:flutter_project_web_supportandservice/widget/bottom_bar.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruseranno.dart';
import 'package:flutter_project_web_supportandservice/widget/featured_heading.dart';
import 'package:flutter_project_web_supportandservice/widget/featured_tiles.dart';
import 'package:flutter_project_web_supportandservice/widget/herderuseranno.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';

class HomeUserAnno extends StatelessWidget {
  static const String routeName = '/homeuseranno';
  double _scrollPosition = 0;
  double _opacity = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, 70),
        child: HeaderBarAnno(_opacity),
      ),
      drawer: createDraweranno(context),
      extendBodyBehindAppBar: true,
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: createDraweranno(context),
      ),
      body: MaxWidthCintainer(
        child: Responsive(
          mobile: isMobileContent(),
          tablet: isTabletContent(),
          desktop: isDesktopContent(),
        ),
      ),
      // Container(
      //   color: Colors.white,
      //   width: size.width,
      //   height: size.height,
      //   child: SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: <Widget>[
      //         Detail(),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class isMobileContent extends StatelessWidget {
  isMobileContent({Key? key}) : super(key: key);
  double _scrollPosition = 0;
  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Container();
  }
}

class isTabletContent extends StatelessWidget {
  isTabletContent({Key? key}) : super(key: key);
  double _scrollPosition = 0;
  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Container();
  }
}

class isDesktopContent extends StatelessWidget {
  isDesktopContent({Key? key}) : super(key: key);
  double _scrollPosition = 0;
  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // _opacity = _scrollPosition < size.height * 0.40
    //     ? _scrollPosition / (size.height * 0.40)
    //     : 1;
    return Container(
      color: Colors.greenAccent.shade100,
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            UserAnnoPage(),
            FeaturedHeading(
              screenSize: size,
            ),
            FeaturedTiles(
              screenSize: size,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}
