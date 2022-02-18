import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final String imagePath = 'images/picturecontent/';

  final CarouselController _controller = CarouselController();

  List _isHovering = [false, false, false, false, false, false, false];
  List _isSelected = [true, false, false, false, false, false, false];

  int _current = 0;

  final List<String> images = [
    'images/picturecontent/wat.jpg',
    'images/picturecontent/waterfall.jpg',
    'images/picturecontent/khaoyai.jpg',
    'images/picturecontent/food4.jpg',
    'images/picturecontent/monjam.jpg',
    'images/picturecontent/skywalkbaythong.jpeg',
  ];

  final List<String> places = [
    'วัฒนธรรม',
    'แหล่งท่องเที่ยวน้ำตก',
    'แหล่งท่องเที่ยวภูเขา',
    'อาหารไทย',
    'ป้ายสถานที่สำคัญ',
    'สถานการณ์ต่างๆ',
  ];

  List<Widget> generateImageTiles(screenSize) {
    return images
        .map(
          (element) => ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              element,
              fit: BoxFit.cover,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageSliders = generateImageTiles(screenSize);
    return Responsive(
      mobile: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.02,
        ),
        child: Stack(
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 10 / 6,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _current = index;
                      for (int i = 0; i < imageSliders.length; i++) {
                        if (i == index) {
                          _isSelected[i] = true;
                        } else {
                          _isSelected[i] = false;
                        }
                      }
                    },
                  );
                },
              ),
              carouselController: _controller,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.18,
              ),
              child: AspectRatio(
                aspectRatio: 15 / 4,
                child: Center(
                  child: Text(
                    places[_current],
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        // letterSpacing: 5,
                        // fontFamily: 'Electrolize',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.1),
              child: AspectRatio(
                aspectRatio: 15 / 6,
                child: Center(
                  heightFactor: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screenSize.width / 12,
                        right: screenSize.width / 12,
                      ),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: screenSize.height * 0.004,
                            bottom: screenSize.height * 0.004,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i = 0; i < places.length; i++)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onHover: (value) {
                                        setState(() {
                                          value
                                              ? _isHovering[i] = true
                                              : _isHovering[i] = false;
                                        });
                                      },
                                      onTap: () {
                                        _controller.animateToPage(i);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: screenSize.height * 0.004,
                                            bottom: screenSize.height * 0.004),
                                        child: Text(
                                          places[i],
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                              color: _isHovering[i]
                                                  ? Colors.blueGrey[900]
                                                  : Colors.greenAccent.shade700,
                                              fontSize: 6,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      visible: _isSelected[i],
                                      child: AnimatedOpacity(
                                        duration: Duration(milliseconds: 400),
                                        opacity: _isSelected[i] ? 1 : 0,
                                        child: Container(
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.greenAccent.shade100,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          width: screenSize.width * 0.06,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      tablet: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.02,
        ),
        child: Stack(
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 10 / 6,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _current = index;
                      for (int i = 0; i < imageSliders.length; i++) {
                        if (i == index) {
                          _isSelected[i] = true;
                        } else {
                          _isSelected[i] = false;
                        }
                      }
                    },
                  );
                },
              ),
              carouselController: _controller,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.25,
              ),
              child: AspectRatio(
                aspectRatio: 15 / 4,
                child: Center(
                  child: Text(
                    places[_current],
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        // letterSpacing: 5,
                        // fontFamily: 'Electrolize',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.12),
              child: AspectRatio(
                aspectRatio: 15 / 6,
                child: Center(
                  heightFactor: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screenSize.width / 12,
                        right: screenSize.width / 12,
                      ),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: screenSize.height * 0.004,
                            bottom: screenSize.height * 0.004,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i = 0; i < places.length; i++)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onHover: (value) {
                                        setState(() {
                                          value
                                              ? _isHovering[i] = true
                                              : _isHovering[i] = false;
                                        });
                                      },
                                      onTap: () {
                                        _controller.animateToPage(i);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: screenSize.height * 0.004,
                                            bottom: screenSize.height * 0.004),
                                        child: Text(
                                          places[i],
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                              color: _isHovering[i]
                                                  ? Colors.blueGrey[900]
                                                  : Colors.greenAccent.shade700,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      visible: _isSelected[i],
                                      child: AnimatedOpacity(
                                        duration: Duration(milliseconds: 400),
                                        opacity: _isSelected[i] ? 1 : 0,
                                        child: Container(
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.greenAccent.shade100,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          width: screenSize.width * 0.06,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      desktop: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height / 80,
        ),
        child: Stack(
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  aspectRatio: 15 / 5,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                      for (int i = 0; i < imageSliders.length; i++) {
                        if (i == index) {
                          _isSelected[i] = true;
                        } else {
                          _isSelected[i] = false;
                        }
                      }
                    });
                  }),
              carouselController: _controller,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenSize.height / 3,
              ),
              child: AspectRatio(
                aspectRatio: 15 / 4,
                child: Center(
                  child: Text(
                    places[_current],
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        // letterSpacing: 5,
                        // fontFamily: 'Electrolize',
                        fontSize: screenSize.width / 45,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 15 / 6,
              child: Center(
                heightFactor: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenSize.width / 8,
                      right: screenSize.width / 8,
                    ),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: screenSize.height / 50,
                          bottom: screenSize.height / 50,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 0; i < places.length; i++)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    onHover: (value) {
                                      setState(() {
                                        value
                                            ? _isHovering[i] = true
                                            : _isHovering[i] = false;
                                      });
                                    },
                                    onTap: () {
                                      _controller.animateToPage(i);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: screenSize.height / 80,
                                          bottom: screenSize.height / 90),
                                      child: Text(
                                        places[i],
                                        style: GoogleFonts.kanit(
                                          textStyle: TextStyle(
                                            color: _isHovering[i]
                                                ? Colors.blueGrey[900]
                                                : Colors.greenAccent.shade700,fontSize: 18
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    visible: _isSelected[i],
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 400),
                                      opacity: _isSelected[i] ? 1 : 0,
                                      child: Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent.shade100,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        width: screenSize.width / 10,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
