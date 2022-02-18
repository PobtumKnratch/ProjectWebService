import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/model_aboutme.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutMeCard extends StatefulWidget {
  const AboutMeCard({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  _AboutMeCardState createState() => _AboutMeCardState();
}

class _AboutMeCardState extends State<AboutMeCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenSize = MediaQuery.of(context).size;
    bool isHover = false;
    Duration duration = Duration(milliseconds: 200);
    return Responsive(
      mobile: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {},
              onHover: (value) {
                setState(() {
                  isHover = value;
                });
              },
              hoverColor: Colors.transparent,
              child: AnimatedContainer(
                duration: duration,
                margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: aboutme[widget.index].color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    if (isHover)
                      BoxShadow(
                        offset: Offset(0, 20),
                        blurRadius: 50,
                        color: Colors.black.withOpacity(0.1),
                      ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: duration,
                      padding: EdgeInsets.all(kDefaultPadding * 0.81),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (!isHover)
                            BoxShadow(
                              offset: Offset(0, 20),
                              blurRadius: 30,
                              color: Colors.black.withOpacity(0.1),
                            ),
                        ],
                      ),
                      child: Image.asset(
                        aboutme[widget.index].image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: AppConst.padding * 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        aboutme[widget.index].title,
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 7,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      tablet: InkWell(
        onTap: () {},
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        hoverColor: Colors.transparent,
        child: AnimatedContainer(
          duration: duration,
          // margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: aboutme[widget.index].color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              if (isHover)
                BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 50,
                  color: Colors.black.withOpacity(0.1),
                ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: duration,
                padding: EdgeInsets.all(kDefaultPadding * 0.5),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (!isHover)
                      BoxShadow(
                        offset: Offset(0, 20),
                        blurRadius: 30,
                        color: Colors.black.withOpacity(0.1),
                      ),
                  ],
                ),
                child: Image.asset(
                  aboutme[widget.index].image,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: AppConst.padding * 2),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                  aboutme[widget.index].title,
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontSize: 9,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      desktop: InkWell(
        onTap: () {},
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        hoverColor: Colors.transparent,
        child: AnimatedContainer(
          duration: duration,
          margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
          height: 256,
          width: 256,
          decoration: BoxDecoration(
            color: aboutme[widget.index].color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              if (isHover)
                BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 50,
                  color: Colors.black.withOpacity(0.1),
                ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: duration,
                padding: EdgeInsets.all(kDefaultPadding * 1.5),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (!isHover)
                      BoxShadow(
                        offset: Offset(0, 20),
                        blurRadius: 30,
                        color: Colors.black.withOpacity(0.1),
                      ),
                  ],
                ),
                child: Image.asset(
                  aboutme[widget.index].image,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: AppConst.padding * 2),
              Text(
                aboutme[widget.index].title,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    fontSize: screenSize.width / 100,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}
