import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/carddataanno/card_dataannofood.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/carddataanno/card_dataannoscenario.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/carddataanno/card_dataannosignboard.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/carddataanno/card_dataannotravel.dart';
import 'package:flutter_project_web_supportandservice/states/components/annotation/carddataanno/title_headeranno.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruseranno.dart';
import 'package:flutter_project_web_supportandservice/widget/herderuseranno.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';

class UserAnnoData extends StatelessWidget {
  UserAnnoData({Key? key}) : super(key: key);
  static const String routeName = '/userannodata';
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
              padding: EdgeInsets.only(top: size.height * 0.15),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                clipBehavior: Clip.antiAlias,
                elevation: 16,
                semanticContainer: size.height.isFinite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleHeaderAnno(),
                    CardDataAnnoTravel(),
                    CardDataAnnoFood(),
                    CardDataAnnoSignboard(),
                    CardDataAnnoScenario(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
