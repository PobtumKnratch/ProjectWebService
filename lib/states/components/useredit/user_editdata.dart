import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/card_dataedit.dart';
import 'package:flutter_project_web_supportandservice/states/components/useredit/title_headeredit.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruseredit.dart';
import 'package:flutter_project_web_supportandservice/widget/headeruseredit.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';

class UserEditData extends StatelessWidget {
  UserEditData({Key? key}) : super(key: key);
  static const String routeName = '/usereditdata';
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
        child: HeaderBarEdit(_opacity),
      ),
      drawer: createDraweredit(context),
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
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.2),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                clipBehavior: Clip.antiAlias,
                elevation: 16,
                semanticContainer: size.height.isFinite,
                shape: RoundedRectangleBorder(
                    // side: BorderSide(),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleHeaderEdit(),
                    // CardDataEdit(),
                  ],
                ),
              ),
            ),
            // UserEditPage(),
            // Categories(),
          ],
        ),
      ),
    );
  }
}
