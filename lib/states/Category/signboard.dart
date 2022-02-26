import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload2.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload4.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';
import 'package:flutter_project_web_supportandservice/widget/search_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload3.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Signboard extends StatefulWidget {
  List<Upload3> models;
  Signboard({
    Key? key,
    required this.models,
  }) : super(key: key);

  @override
  _SignboardState createState() => _SignboardState();
}

class _SignboardState extends State<Signboard> {
  List<String> upload3 = [];
  bool loading = false, allLoaded = false;
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  List<Upload> models = [];
  List<Upload2> models2 = [];
  List<Upload3> models3 = [];
  List<Upload4> models4 = [];
  List<Upload> showModel = [];
  List<Upload2> showModel2 = [];
  List<Upload3> showModel3 = [];
  List<Upload4> showModel4 = [];
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

  mockFetch() async {
    if (allLoaded) {
      return;
    }
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    List<String> newData = upload3.length >= 60
        ? []
        : List.generate(20, (index) => "List Upload ${index + upload3.length}");
    if (newData.isNotEmpty) {
      upload3.addAll(newData);
    }
    setState(() {
      loading = false;
      allLoaded = newData.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    getStart();
    mockFetch();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        mockFetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Responsive(
      mobile: Container(
        margin: EdgeInsets.only(top: size.height * 0.03),
        child: widget.models.isEmpty
            ? Center(
                child: Text(
                  'ไม่พบข้อมูล',
                  style: GoogleFonts.kanit(fontSize: size.width * 0.05),
                ),
              )
            : Column(
                children: [
                  Container(
                    height: size.height,
                    child: FutureBuilder<List<Upload3>>(
                      future: getupload3(),
                      builder: (context, snapshot) {
                        if (upload3.isNotEmpty) {
                          return StaggeredGridView.countBuilder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            shrinkWrap: true,
                            primary: false,
                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            itemCount: widget.models.length,
                            itemBuilder: (context, index) {
                              final upload = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  showDialogSignboard(context, upload.image,
                                      upload.name, upload.date);
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.02),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.loose,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                clipBehavior: Clip.antiAlias,
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  imageUrl:
                                                      '$hostpic/fileupload3/${widget.models[index].image}',
                                                  fit: BoxFit.cover,
                                                  width: size.width,
                                                  height: size.height,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    'images/picturecontent/travel.jpg',
                                                    fit: BoxFit.fill,
                                                    width: size.width,
                                                    height: size.height,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.02),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: AppConst.padding),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                  width: AppConst.padding),
                                              Text(
                                                widget.models[index].name,
                                                style: GoogleFonts.kanit(
                                                    fontSize: 14),
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                      width:
                                                          AppConst.padding / 2),
                                                  const SizedBox(
                                                      width: AppConst.padding),
                                                  const Icon(
                                                    Icons
                                                        .chat_bubble_outline_rounded,
                                                    color: Colors.black,
                                                    size: 10,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (index) => index % 8 == 2
                                ? StaggeredTile.count(2, 1.5)
                                : StaggeredTile.count(2, 2.5),
                            // new StaggeredTile.count(2, index.isEven ? 2 : 1.5 ),
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            controller: _scrollController,
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
      tablet: Container(
        margin: EdgeInsets.only(top: size.height * 0.03),
        child: widget.models.isEmpty
            ? Center(
                child: Text(
                  'ไม่พบข้อมูล',
                  style: GoogleFonts.kanit(fontSize: size.width * 0.05),
                ),
              )
            : Column(
                children: [
                  Container(
                    height: size.height,
                    child: FutureBuilder<List<Upload3>>(
                      future: getupload3(),
                      builder: (context, snapshot) {
                        if (upload3.isNotEmpty) {
                          return StaggeredGridView.countBuilder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            shrinkWrap: true,
                            primary: false,
                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 8,
                            itemCount: widget.models.length,
                            itemBuilder: (context, index) {
                              final upload = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  showDialogSignboard(context, upload.image,
                                      upload.name, upload.date);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.loose,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                clipBehavior: Clip.antiAlias,
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  imageUrl:
                                                      '$hostpic/fileupload3/${widget.models[index].image}',
                                                  fit: BoxFit.cover,
                                                  width: size.height,
                                                  height: 400,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    'images/picturecontent/travel.jpg',
                                                    fit: BoxFit.fill,
                                                    width: size.width,
                                                    height: size.height,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                            height: AppConst.padding),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: AppConst.padding),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                  width: AppConst.padding),
                                              Text(
                                                widget.models[index].name,
                                                style: GoogleFonts.kanit(
                                                    fontSize: 14),
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                      width:
                                                          AppConst.padding / 2),
                                                  const SizedBox(
                                                      width: AppConst.padding),
                                                  const Icon(
                                                    Icons
                                                        .chat_bubble_outline_rounded,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(
                                                      width:
                                                          AppConst.padding / 2),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                            height: AppConst.padding),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (index) => index % 8 == 0
                                ? StaggeredTile.count(2, 1.5)
                                : StaggeredTile.count(2, 1.5),
                            // new StaggeredTile.count(2, index.isEven ? 2 : 1.5 ),
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            controller: _scrollController,
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
      desktop: Container(
        margin: EdgeInsets.only(top: size.height * 0.03),
        child: Column(
          children: [
            Container(
              height: size.height,
              child: widget.models.isEmpty
                  ? Center(
                      child: Text(
                        'ไม่พบข้อมูล',
                        style: GoogleFonts.kanit(fontSize: size.width * 0.05),
                      ),
                    )
                  : FutureBuilder<List<Upload3>>(
                      future: getupload3(),
                      builder: (context, snapshot) {
                        if (upload3.isNotEmpty) {
                          return StaggeredGridView.countBuilder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            shrinkWrap: true,
                            primary: false,
                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 8,
                            itemCount: widget.models.length,
                            itemBuilder: (context, index) {
                              final upload = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  showDialogSignboard(context, upload.image,
                                      upload.name, upload.date);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.loose,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                clipBehavior: Clip.antiAlias,
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  imageUrl:
                                                      '$hostpic/fileupload3/${widget.models[index].image}',
                                                  fit: BoxFit.cover,
                                                  width: size.height,
                                                  height: 400,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    'images/picturecontent/travel.jpg',
                                                    fit: BoxFit.fill,
                                                    width: size.width,
                                                    height: size.height,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                            height: AppConst.padding),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: AppConst.padding),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                  width: AppConst.padding),
                                              Text(
                                                widget.models[index].name,
                                                style: GoogleFonts.kanit(
                                                    fontSize: 18),
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                      width:
                                                          AppConst.padding / 2),
                                                  const SizedBox(
                                                      width: AppConst.padding),
                                                  const Icon(
                                                    Icons
                                                        .chat_bubble_outline_rounded,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(
                                                      width:
                                                          AppConst.padding / 2),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                            height: AppConst.padding),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (index) => index % 8 == 0
                                ? StaggeredTile.count(2, 1.5)
                                : StaggeredTile.count(2, 1.5),
                            // new StaggeredTile.count(2, index.isEven ? 2 : 1.5 ),
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            controller: _scrollController,
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  showDialogSignboard(context, uploadimage, uploadname, uploaddate) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.6,
                height: 800,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "ข้อมูลการท่องเที่ยว",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload3/${uploadimage}',
                          fit: BoxFit.fill,
                          width: 500,
                          height: 450,
                          alignment: Alignment.center,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'images/picturecontent/travel.jpg',
                            fit: BoxFit.fill,
                            width: 500,
                            height: 450,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ชื่อของรูปภาพ : ",
                            style: TextStyle(
                                fontSize: 20,
                                // fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            uploadname,
                            style: TextStyle(
                                fontSize: 20,
                                // fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "วันที่ : ",
                            style: TextStyle(
                                fontSize: 18,
                                // fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            uploaddate.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String cutWord(String name) {
    String result = name;
    if (result.length > 5) {
      result = result.substring(0, 5);
      result = '$result ..ดูข้อมูลเพิ่มเติม';
    }
    return result;
  }
}
