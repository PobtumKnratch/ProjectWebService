import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Detail extends StatelessWidget {
  Detail({
    Key? key,
    // required this.screenSize
  }) : super(key: key);
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
                height: size.height * 0.4,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(
                        'images/picturebackground/backgroundmain.jpg'),
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
                  padding: EdgeInsets.only(top: size.height * 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: FittedBox(
                          child: Text(
                            'เครื่องมือสนับสนุนและบริการข้อมูล',
                            maxLines: 2,
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
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
                height: size.height * 0.41,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(
                        'images/picturebackground/backgroundmain.jpg'),
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
                  padding: EdgeInsets.only(top: size.height * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: FittedBox(
                          child: Text(
                            'เครื่องมือสนับสนุนและบริการข้อมูล',
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                fontSize: 27,
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
                        width: size.width * 0.10,
                        height: size.height * 0.10,
                      ),
                    ],
                  ),
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
                        'images/picturebackground/backgroundmain.jpg'),
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
                        child: FittedBox(
                          child: Text(
                            'เครื่องมือสนับสนุนและบริการข้อมูล',
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
                        height: size.height * 0.05,
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
            ],
          ),
        ],
      ),
    );
  }
}
