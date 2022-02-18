import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutMeCarousel extends StatefulWidget {
  const AboutMeCarousel({Key? key}) : super(key: key);

  @override
  _AboutMeCarouselState createState() => _AboutMeCarouselState();
}

class _AboutMeCarouselState extends State<AboutMeCarousel> {
  final String imagePath = 'images/picturecontent/';

  // ignore: unused_field
  final CarouselController _controller = CarouselController();

  List _isHovering = [false, false, false, false, false, false, false];
  List _isSelected = [true, false, false, false, false, false, false];
  int _current = 0;

  final List<String> images = [
    'images/picturecontent/wat2.jpg',
    'images/picturecontent/wat3.jpg',
    'images/picturecontent/food5.jpg',
    'images/picturecontent/food6.jpg',
    'images/picturecontent/signboard3.jpg',
    'images/picturecontent/signboard4.jpg',
    'images/picturecontent/scenario2.jpeg',
    'images/picturecontent/scenario3.jpeg',
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
              // height: 200,
              // width: 850,
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
        mobile: Stack(
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                enlargeCenterPage: true,height: 180,
                aspectRatio: 6 / 4,
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
          ],
        ),
        tablet: Stack(
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 6 / 4,
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
          ],
        ),
        desktop: Stack(
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 6 / 4,
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
          ],
        ));
  }
}
