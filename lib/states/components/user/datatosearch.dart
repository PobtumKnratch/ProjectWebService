import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload2.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/search/foodsearch.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/search/scenariosearch.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/search/signboardsearch.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/search/travelsearch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/js.dart';

class DatatoSearch extends StatefulWidget {
  const DatatoSearch({Key? key}) : super(key: key);

  @override
  _DatatoSearchState createState() => _DatatoSearchState();
}

class _DatatoSearchState extends State<DatatoSearch> {
  List<Widget> search = [
    TeavelSearch(),
    ScenarioSearch(),
    FoodStateSearch(),
    SignboardSearch(),
  ];
  final controller = TextEditingController();
  String query = '';

  int selectIndex = 0;
  double _scrollPosition = 0;
  double _opacity = 0;
  final formKey = GlobalKey<FormState>();
  List upload2 = [];

  String? searchStatus;

  Future getupload2() async {
    final url =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/ShowData/fileupload2.php';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response);
    if (response.statusCode == 200) {
      print('Status 200 complete');
      // return upload2FromJson(response.body);
      var jsonData = json.decode(response.body);
      for (var i = 0; i < jsonData.length; i++) {
        upload2.add(jsonData[i]['name']);
      }
      print('Data Json ==> ${jsonData}');
      print('Data Upload2 ==> ${upload2}');
    } else {
      print('Error Status Code ${response.statusCode}');
    }
  }

  // return jsonData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getupload2();
  }

  // void funSearch({String? value}) {
  //   List show = upload2;
  //   setState(() {
  //     show = show
  //         .where((element) => element.Status.toLowerCase()
  //             .contains(searchStatus!.toLowerCase()))
  //         .toList();
  //     if (value == null ? false : true && value != '') {
  //       value = value!.toLowerCase();
  //       show = show.where((element) => element.Name.toLowerCase().contains(value!) || 
  //       element.Feature.toLowerCase().contains(value!) || 
  //       (element.upload2 == ''))
  //     }
  //   });
  // }

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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.02,
                            bottom: size.height * 0.02,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                key: formKey,
                                child: SizedBox(
                                  width: 450,
                                  // height: size.height * 0.05,
                                  child: TextFormField(
                                      controller: controller,
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(fontSize: 14),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกข้อมูลสำหรับค้นหา';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                            color: Colors.red.shade400,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        prefixIcon:
                                            Icon(Icons.search, size: 16),
                                        hintText:
                                            'โปรดระบุข้อมูลที่ต้องการสืบค้น',
                                        hintStyle: GoogleFonts.kanit(
                                          textStyle: TextStyle(fontSize: 14),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Colors.black54, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Colors.black54, width: 1),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      onChanged: searchupload),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    children: [
                                      FlatButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            // showSearch(
                                            //   context: context,
                                            //   delegate: Search(),
                                            // );
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => DataSearch(),
                                            //   ),
                                            // );
                                            // searchupload(query);
                                            Search();
                                          }
                                        },
                                        color: Colors.greenAccent.shade400,
                                        height: 40,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          'ค้นหา',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: size.height * 1.05,
                          width: size.width * 0.78,
                          child: search[selectIndex],
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

class Search extends SearchDelegate<String> {
  List<dynamic>? list;
  Search({this.list});
  List<String> upload2 = [];

  // List searchupload2 = List();
  Future showAllPost() async {
    final url =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/search.php';
    final response = await http.post(Uri.parse(url), body: {'name': query});
    print(response);
    if (response.statusCode == 200) {
      print('Status 200 complete');
      // return upload2FromJson(response.body);
      var jsonData = json.decode(response.body);
      return jsonData;
    } else {
      print('Error Status Code ${response.statusCode}');
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = " ";
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            FlatButton(
              onPressed: () {
                // if (formKey.currentState!
                //     .validate()) {
                //   showSearch(
                //       context: context,
                //       delegate: Search());
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => DataSearch(),
                //   ),
                // );
                // }
                // close(context, null);
              },
              color: Colors.greenAccent.shade400,
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'ค้นหา',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //     ],
    //   ),
    // ),
    // return IconButton(
    //   icon: AnimatedIcon(
    //     icon: AnimatedIcons.menu_arrow,
    //     progress: transitionAnimation,
    //   ),
    //   onPressed: () {
    // close(context, null);
    //   },
    // );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
    // return FutureBuilder<List<Upload2>>(
    //   future: showAllPost(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return ListView.builder(
    //         itemCount: snapshot.data!.length,
    //         itemBuilder: (context, index) {
    //           var list = snapshot.data![index];
    //           return Padding(
    //             padding: EdgeInsets.all(8.0),
    //             child: Text(
    //               list['name'],
    //               style: GoogleFonts.kanit(fontSize: 10),
    //             ),
    //           );
    //         },
    //       );
    //     }
    //     return CircularProgressIndicator();
    //   },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var listData = query.isEmpty
        ? list
        : list!.where((element) => element.contains(query)).toList();
    return ListView.builder(
      itemCount: list!.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            query = upload2[index];
            showResults(context);
          },
        );
      },
    );
    // final suggestions = query.isEmpty
    //     ? list
    //     : upload2.where((upload2) {
    //         final upload2Lower = upload2.toLowerCase();
    //         final queryLower = query.toLowerCase();
    //       }).toList();
    // return buildSuggestionsSuccess(suggestions);
  }

  // Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
  //       itemCount: suggestions.length,
  //       itemBuilder: (context, index) {
  //         final suggestion = suggestions[index];
  //         return ListTile(
  //           leading: Icon(Icons.travel_explore),
  //           title: Text(suggestion),
  //         );
  //       },
  //     );
}
