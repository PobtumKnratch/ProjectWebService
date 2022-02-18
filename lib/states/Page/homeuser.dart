import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/Category/Categories.dart';
import 'package:flutter_project_web_supportandservice/states/components/home/carousel.dart';
import 'package:flutter_project_web_supportandservice/states/components/home/detail.dart';
import 'package:flutter_project_web_supportandservice/widget/bottom_bar.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruser.dart';
import 'package:flutter_project_web_supportandservice/widget/featured_heading.dart';
import 'package:flutter_project_web_supportandservice/widget/featured_list.dart';
import 'package:flutter_project_web_supportandservice/widget/featured_tiles.dart';
import 'package:flutter_project_web_supportandservice/widget/headeruser.dart';
import 'package:flutter_project_web_supportandservice/widget/main_heading.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeUser extends StatelessWidget {
  static const String routeName = '/homeuser';
  double _scrollPosition = 0;
  double _opacity = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Scaffold(
      appBar: size.width < 1200
          ? AppBar(
              iconTheme: IconThemeData(color: Colors.black, size: 20),
              elevation: 0,
              backgroundColor: Colors.greenAccent.shade700,
              title: Row(
                children: [
                  Image(
                    image: AssetImage('images/pictureicon/logo.png'),
                    width: 25,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    'NAVANURAK',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : PreferredSize(
              preferredSize: Size(size.width, 70),
              child: HeaderBar(_opacity),
            ),
      // drawer: createDrawer(context),
      extendBodyBehindAppBar: true,
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: createDrawer(context),
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
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Detail(),
            FeaturedHeading(
              screenSize: size,
            ),
            FeaturedTiles(
              screenSize: size,
            ),
            // FeaturedList(screenSize: size,),
            MainHeading(
              screenSize: size,
            ),
            Carousel(),
            // SizedBox(height: size.height*0.02,),
            // Categories(),
            BottomBar(),
          ],
        ),
      ),
    );
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
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Detail(),
            FeaturedHeading(
              screenSize: size,
            ),
            FeaturedTiles(
              screenSize: size,
            ),
            // FeaturedList(screenSize: size,),
            MainHeading(
              screenSize: size,
            ),
            Carousel(),
            // Categories(),
            // SizedBox(height: size.height*0.02,),
            BottomBar(),
          ],
        ),
      ),
    );
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
      color: Colors.white,
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Detail(),
            FeaturedHeading(
              screenSize: size,
            ),
            FeaturedTiles(
              screenSize: size,
            ),
            // FeaturedList(screenSize: size,),
            MainHeading(
              screenSize: size,
            ),
            Carousel(),
            // Categories(),
            // SizedBox(height: size.height*0.02,),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}
