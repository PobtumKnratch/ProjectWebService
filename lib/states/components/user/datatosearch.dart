import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload2.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload3.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload4.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/search/foodsearch.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/search/scenariosearch.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/search/signboardsearch.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/search/travelsearch.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:flutter_project_web_supportandservice/widget/search_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/js.dart';

class DatatoSearch extends StatefulWidget {
  const DatatoSearch({Key? key}) : super(key: key);

  @override
  _DatatoSearchState createState() => _DatatoSearchState();
}

class _DatatoSearchState extends State<DatatoSearch> {
  List<Upload> models = [];
  List<Upload2> models2 = [];
  List<Upload3> models3 = [];
  List<Upload4> models4 = [];
  List<Upload> showModel = [];
  List<Upload2> showModel2 = [];
  List<Upload3> showModel3 = [];
  List<Upload4> showModel4 = [];

  final controller = TextEditingController();
  String query = '';

  int selectIndex = 0;
  double _scrollPosition = 0;
  double _opacity = 0;
  final formKey = GlobalKey<FormState>();
  List<Upload2> upload2 = [];

  bool isLoading = true;

  String? searchStatus;

  Future<Null> getStart() async {
    models = await getupload();
    showModel = models;
    models2 = await getupload2();
    showModel2 = models2;
    models3 = await getupload3();
    showModel3 = models3;
    models4 = await getupload4();
    showModel4 = models4;
    // print(models2);
    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  // return jsonData;
  @override
  void initState() {
    getStart();
    super.initState();
  }

  Widget travel(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Center(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              selectIndex = 0;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Ink.image(
                    height: size.height * 0.1,
                    width: size.width * 0.12,
                    image: AssetImage('images/picturecontent/wat.jpg'),
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.04, left: size.height * 0.09),
                    child: Text(
                      'TRAVEL',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget scenario(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                selectIndex = 1;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Ink.image(
                      height: size.height * 0.1,
                      width: size.width * 0.12,
                      image: AssetImage('images/picturecontent/scenario1.jpg'),
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.04, left: size.height * 0.085),
                      child: Text(
                        'SCENARIO',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget food(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                selectIndex = 2;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Ink.image(
                      height: size.height * 0.1,
                      width: size.width * 0.12,
                      image: AssetImage('images/picturecontent/food1.jpg'),
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.04, left: size.height * 0.09),
                      child: Text(
                        'FOOD',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signboard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                selectIndex = 3;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Ink.image(
                      height: size.height * 0.1,
                      width: size.width * 0.12,
                      image: AssetImage('images/picturecontent/signboard2.jpg'),
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.04, left: size.height * 0.085),
                      child: Text(
                        'SIGNBOARD',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.black12,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.06,
                bottom: size.height * 0.01,
                top: size.height * 0.1),
            child: Text('สำหรับการสืบค้นข้อมูลรูปภาพ',
                style: GoogleFonts.kanit(fontSize: 25)),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.02, left: size.width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: Colors.black38,
                          width: 2,
                        ),
                      ),
                      width: size.width * 0.16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              'ข้อมูลรูปภาพ',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Padding(
                                // padding: const EdgeInsets.all(10.0),
                                // child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    travel(context),
                                    scenario(context),
                                    food(context),
                                    signboard(context),
                                  ],
                                ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    isLoading
                        ? CircularProgressIndicator()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.02,
                                  bottom: size.height * 0.02,
                                ),
                                child: SearchView(
                                  showBtnSearch: true,
                                  onChanged: (value) async {
                                    setState(
                                      () {
                                        showModel = models
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                        showModel2 = models2
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                        showModel3 = models3
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                        showModel4 = models4
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(value
                                                    .toLowerCase()
                                                    .toString()))
                                            .toList();
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                height: size.height * 1.05,
                                width: size.width * 0.78,
                                child: [
                                  TeavelSearch(models: showModel2),
                                  ScenarioSearch(models: showModel4),
                                  FoodStateSearch(models: showModel),
                                  SignboardSearch(models: showModel3),
                                ][selectIndex],
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void searchupload(String query) {
    final suggestions = upload2.where((upload) {
      final uploadname = upload.name.toLowerCase();
      final input = query.toLowerCase();

      return uploadname.contains(input);
    }).toList();
    setState(() => upload2 = suggestions);
  }
}
