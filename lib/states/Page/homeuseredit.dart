import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/Category/Categories.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/user_editpage.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruseredit.dart';
import 'package:flutter_project_web_supportandservice/widget/headeruseredit.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class HomeUserEdit extends StatelessWidget {
  static const String routeName = '/homeuseredit';
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
              child: HeaderBarEdit(_opacity),
            ),
      // drawer: createDrawer(context),
      extendBodyBehindAppBar: true,
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: createDraweredit(context),
      ),
      body: MaxWidthCintainer(
        child: Responsive(
          mobile: isMobileContent(),
          tablet: isTabletContent(),
          desktop: isDesktopContent(),
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class isMobileContent extends StatelessWidget {
  isMobileContent({Key? key}) : super(key: key);
  double _scrollPosition = 0;
  // ignore: unused_field
  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Container(
      color: Colors.greenAccent.shade100,
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            UserEditPage(),
            Categories(),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class isTabletContent extends StatelessWidget {
  isTabletContent({Key? key}) : super(key: key);
  double _scrollPosition = 0;
  // ignore: unused_field
  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Container(
      color: Colors.greenAccent.shade100,
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            UserEditPage(),
            Categories(),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class isDesktopContent extends StatelessWidget {
  isDesktopContent({Key? key}) : super(key: key);
  // ignore: unused_field
  double _scrollPosition = 0;
  // ignore: unused_field
  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.greenAccent.shade100,
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            UserEditPage(),
            Categories(),
          ],
        ),
      ),
    );
  }
}
