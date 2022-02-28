import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/picture_components.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project_web_supportandservice/Model/fileupload2.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../widget/constants.dart';

class Travel extends StatefulWidget {
  List<Upload2> models;
  // Upload model;
  Travel({
    required this.models,
    // required this.model,
    Key? key,
  }) : super(key: key);
  @override
  _TravelState createState() => _TravelState();
}

class _TravelState extends State<Travel> {
  // late Future<List<Upload2>> upload2;
  List<String> upload2 = [];
  bool loading = false, allLoaded = false;
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;
  DateTime? date;
  mockFetch() async {
    if (allLoaded) {
      return;
    }
    setState(() {
      loading = true;
    });
    // await Future.delayed(Duration(milliseconds: 500));
    upload2 =
        List.generate(20, (index) => "List Upload ${index + upload2.length}");

    setState(() {
      loading = false;
      allLoaded = upload2.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    // date = DateTime.parse(widget.models.date);
    print(date);
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
    Responsive responsive = Responsive(
        mobile: isMobileContent(),
        tablet: isTabletContent(),
        desktop: isDesktopContent());
    return Responsive(
      mobile: Container(
        child: widget.models.isEmpty
            ? Center(
                child: Text(
                  'ไม่พบข้อมูล',
                  style: GoogleFonts.kanit(fontSize: size.width * 0.05),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height,
                    child: FutureBuilder<List<Upload2>>(
                      future: getupload2(),
                      builder: (context, snapshot) {
                        if (upload2.isNotEmpty) {
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
                              // final upload = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  showDialogTravel(
                                      context,
                                      widget.models[index].image,
                                      widget.models[index].name,
                                      widget.models[index].tag,
                                      date,
                                      widget.models[index].description);
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
                                                      '$hostpic/fileupload2/${widget.models[index].image}',
                                                  fit: BoxFit.cover,
                                                  width: size.width,
                                                  height: size.height,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    'images/picturecontent/travel.jpg',
                                                    fit: BoxFit.cover,
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
                                                    fontSize: 10),
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
                            staggeredTileBuilder: (index) =>
                                // new StaggeredTile.fit(1),
                                index % 8 == 2
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
        child: widget.models.isEmpty
            ? Center(
                child: Text(
                  'ไม่พบข้อมูล',
                  style: GoogleFonts.kanit(fontSize: size.width * 0.05),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height,
                    child: FutureBuilder<List<Upload2>>(
                      future: getupload2(),
                      builder: (context, snapshot) {
                        if (upload2.isNotEmpty) {
                          return StaggeredGridView.countBuilder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            shrinkWrap: true,
                            primary: false,
                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 7,
                            itemCount: widget.models.length,
                            itemBuilder: (context, index) {
                              final upload = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  showDialogTravel(
                                      context,
                                      widget.models[index].image,
                                      widget.models[index].name,
                                      widget.models[index].tag,
                                      widget.models[index].date,
                                      widget.models[index].description);
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
                                                      '$hostpic/fileupload2/${widget.models[index].image}',
                                                  fit: BoxFit.cover,
                                                  width: size.width,
                                                  height: size.height,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    'images/picturecontent/travel.jpg',
                                                    fit: BoxFit.cover,
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
                                              Text(widget.models[index].name,
                                                  style: GoogleFonts.kanit(
                                                      fontSize: 10)),
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
                            staggeredTileBuilder: (index) =>
                                // new StaggeredTile.fit(1),
                                index % 8 == 2
                                    ? StaggeredTile.count(1, 1.5)
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
        child: widget.models.isEmpty
            ? Center(
                child: Text(
                  'ไม่พบข้อมูล',
                  style: GoogleFonts.kanit(fontSize: size.width * 0.05),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height,
                    child: FutureBuilder<List<Upload2>>(
                      future: getupload2(),
                      builder: (context, snapshot) {
                        if (upload2.isNotEmpty) {
                          return StaggeredGridView.countBuilder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            shrinkWrap: true,
                            primary: false,
                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 7,
                            itemCount: widget.models.length,
                            itemBuilder: (context, index) {
                              final upload = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  showDialogTravel(
                                      context,
                                      widget.models[index].image,
                                      widget.models[index].name,
                                      widget.models[index].tag,
                                      widget.models[index].date,
                                      widget.models[index].description);
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
                                                      '$hostpic/fileupload2/${widget.models[index].image}',
                                                  fit: BoxFit.cover,
                                                  width: size.width,
                                                  height: size.height,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    'images/picturecontent/travel.jpg',
                                                    fit: BoxFit.cover,
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
                            staggeredTileBuilder: (index) =>
                                // new StaggeredTile.fit(1),
                                index % 8 == 2
                                    ? StaggeredTile.count(1, 1.5)
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

  showDialogTravel(context, uploadimage, uploadname, tag, date, description) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return showDialog(
      context: context,
      builder: (context) {
        return Responsive(
          mobile: SingleChildScrollView(
            clipBehavior: Clip.antiAlias,
            // shrinkWrap: true,
            primary: false,
            physics: BouncingScrollPhysics(),
            child: Container(
              // height: size.height*5,
              child: Center(
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                  // type: MaterialType.transparency,
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(15),
                      width: size.width * 0.8,
                      // height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Icon(
                                Icons.wrong_location_rounded,
                                color: Colors.greenAccent,
                                size: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Text(
                                'ชื่อรูปภาพ : ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.01),
                              child: Text(
                                uploadname,
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  right: size.height * 0.02),
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  size: 25,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PictureComponents(),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Icon(
                                Icons.tag,
                                color: Colors.greenAccent,
                                size: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  // top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Text(
                                'แฮชแท็ก : ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  // top: size.height * 0.01,
                                  left: size.height * 0.01),
                              child: Text(
                                tag,
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              // top: size.height * 0.02,
                              // left: size.height * 0.25,
                            ),
                            child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload2/${uploadimage}',
                                fit: BoxFit.fill,
                                width: 500,
                                height: 250,
                                alignment: Alignment.center,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'images/picturecontent/travel.jpg',
                                  fit: BoxFit.fill,
                                  width: 500,
                                  height: 250,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.height * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.black54,
                                  size: 10,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.height * 0.01),
                                  child: Text(
                                    "วันที่ : ",
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  date.toString(),
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.height * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.description_outlined,
                                  color: Colors.black54,
                                  size: 10,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.height * 0.01),
                                  child: Text(
                                    "คำอธิบายรูปภาพ",
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.height * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.comment,
                                  color: Colors.black54,
                                  size: 10,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.height * 0.01),
                                  child: Text(
                                    uploadname,
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.height * 0.04,
                                top: size.height * 0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ข้อมูลรูปภาพที่เกี่ยวข้อง',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Container(
                              // height: size.height,
                              child: FutureBuilder<List<Upload2>>(
                                future: getupload2(),
                                builder: (context, snapshot) {
                                  if (upload2.isNotEmpty) {
                                    return StaggeredGridView.countBuilder(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 30,
                                      ),
                                      shrinkWrap: true,
                                      primary: false,
                                      physics: BouncingScrollPhysics(),
                                      crossAxisCount: 4,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (Upload2, index) {
                                        final upload = snapshot.data![index];
                                        return GestureDetector(
                                          onTap: () {
                                            showDialogTravel(
                                                context,
                                                uploadimage,
                                                uploadname,
                                                tag,
                                                date,
                                                description);
                                          },
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
                                                            BorderRadius
                                                                .circular(5),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child:
                                                            CachedNetworkImage(
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                          imageUrl:
                                                              'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload2/${upload.image}',
                                                          fit: BoxFit.cover,
                                                          width: size.width,
                                                          height: size.height,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            'images/picturecontent/travel.jpg',
                                                            fit: BoxFit.cover,
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal:
                                                          AppConst.padding),
                                                  child: Row(
                                                    children: [
                                                      // CircleAvatar(
                                                      //   radius: 14,
                                                      //   backgroundImage: AssetImage(post.userImg),
                                                      // ),
                                                      const SizedBox(
                                                          width:
                                                              AppConst.padding),
                                                      Text(
                                                        '${upload.name}',
                                                        style:
                                                            GoogleFonts.kanit(
                                                                fontSize: 8),
                                                      ),
                                                      const Spacer(),
                                                      Row(
                                                        children: [
                                                          // const Icon(
                                                          //   Icons.thumb_up_alt_outlined,
                                                          //   color: Colors.blue,
                                                          // ),
                                                          const SizedBox(
                                                              width: AppConst
                                                                      .padding /
                                                                  2),
                                                          // Text(post.likes.toString()),
                                                          const SizedBox(
                                                              width: AppConst
                                                                  .padding),
                                                          const Icon(
                                                            Icons
                                                                .chat_bubble_outline_rounded,
                                                            color: Colors.black,
                                                            size: 8,
                                                          ),
                                                          const SizedBox(
                                                              width: AppConst
                                                                      .padding /
                                                                  2),
                                                          // Text(post.comments.toString()),
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
                                        );
                                      },
                                      staggeredTileBuilder: (index) =>
                                          // new StaggeredTile.fit(1),
                                          index % 8 == 2
                                              ? StaggeredTile.count(2, 1.7)
                                              : StaggeredTile.count(2, 1.7),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          tablet: SingleChildScrollView(
            clipBehavior: Clip.antiAlias,
            // shrinkWrap: true,
            primary: false,
            physics: BouncingScrollPhysics(),
            child: Container(
              // height: size.height*5,
              child: Center(
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                  // type: MaterialType.transparency,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(15),
                    width: size.width * 0.59,
                    // height: size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Icon(
                                Icons.wrong_location_rounded,
                                color: Colors.greenAccent,
                                size: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Text(
                                'ชื่อรูปภาพ : ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.01),
                              child: Text(
                                uploadname,
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  right: size.height * 0.02),
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  size: 25,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PictureComponents(),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Icon(
                                Icons.tag,
                                color: Colors.greenAccent,
                                size: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  // top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Text(
                                'แฮชแท็ก : ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  // top: size.height * 0.01,
                                  left: size.height * 0.01),
                              child: Text(
                                tag,
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.009,
                              left: size.height * 0.25),
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload2/${uploadimage}',
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
                          height: size.height * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: Colors.black54,
                                size: 18,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.height * 0.01),
                                child: Text(
                                  "วันที่ : ",
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                        // fontSize: 35,
                                        ),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                date.toString(),
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      // fontSize: 35,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.description_outlined,
                                color: Colors.black54,
                                size: 18,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.height * 0.01),
                                child: Text(
                                  "คำอธิบายรูปภาพ",
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                        // fontSize: 35,
                                        ),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.comment,
                                color: Colors.black54,
                                size: 18,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.height * 0.01),
                                child: Text(
                                  uploadname,
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                        // fontSize: 35,
                                        ),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.height * 0.04, top: size.height * 0.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.height * 0.01),
                                child: Text(
                                  'ข้อมูลรูปภาพที่เกี่ยวข้อง',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          child: Container(
                            // height: size.height,
                            child: FutureBuilder<List<Upload2>>(
                              future: getupload2(),
                              builder: (context, snapshot) {
                                if (upload2.isNotEmpty) {
                                  return StaggeredGridView.countBuilder(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30,
                                    ),
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: BouncingScrollPhysics(),
                                    crossAxisCount: 5,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (Upload2, index) {
                                      final upload = snapshot.data![index];
                                      return GestureDetector(
                                        onTap: () {
                                          showDialogTravel(
                                              context,
                                              uploadimage,
                                              uploadname,
                                              tag,
                                              date,
                                              description);
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
                                                            BorderRadius
                                                                .circular(15),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child:
                                                            CachedNetworkImage(
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                          imageUrl:
                                                              'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload2/${upload.image}',
                                                          fit: BoxFit.cover,
                                                          width: size.width,
                                                          height: size.height,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            'images/picturecontent/travel.jpg',
                                                            fit: BoxFit.cover,
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal:
                                                          AppConst.padding),
                                                  child: Row(
                                                    children: [
                                                      // CircleAvatar(
                                                      //   radius: 14,
                                                      //   backgroundImage: AssetImage(post.userImg),
                                                      // ),
                                                      const SizedBox(
                                                          width:
                                                              AppConst.padding),
                                                      Text('${upload.name}'),
                                                      const Spacer(),
                                                      Row(
                                                        children: [
                                                          // const Icon(
                                                          //   Icons.thumb_up_alt_outlined,
                                                          //   color: Colors.blue,
                                                          // ),
                                                          const SizedBox(
                                                              width: AppConst
                                                                      .padding /
                                                                  2),
                                                          // Text(post.likes.toString()),
                                                          const SizedBox(
                                                              width: AppConst
                                                                  .padding),
                                                          const Icon(
                                                            Icons
                                                                .chat_bubble_outline_rounded,
                                                            color: Colors.black,
                                                          ),
                                                          const SizedBox(
                                                              width: AppConst
                                                                      .padding /
                                                                  2),
                                                          // Text(post.comments.toString()),
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
                                    staggeredTileBuilder: (index) =>
                                        // new StaggeredTile.fit(1),
                                        index % 8 == 2
                                            ? StaggeredTile.count(1, 1.3)
                                            : StaggeredTile.count(2, 1.3),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          desktop: SingleChildScrollView(
            clipBehavior: Clip.antiAlias,
            primary: false,
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Center(
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(15),
                    width: size.width * 0.59,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Icon(
                                Icons.wrong_location_rounded,
                                color: Colors.greenAccent,
                                size: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Text(
                                'ชื่อรูปภาพ : ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.01),
                              child: Text(
                                uploadname,
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  right: size.height * 0.02),
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  size: 25,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PictureComponents(),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Icon(
                                Icons.tag,
                                color: Colors.greenAccent,
                                size: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  // top: size.height * 0.01,
                                  left: size.height * 0.02),
                              child: Text(
                                'แฮชแท็ก : ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  // top: size.height * 0.01,
                                  left: size.height * 0.01),
                              child: Text(
                                tag,
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Divider(
                          color: Colors.black12,
                          height: 10,
                          thickness: 2,
                          indent: 10,
                          endIndent: size.width * 0.025,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              left: size.height * 0.25),
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload2/${uploadimage}',
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
                          height: size.height * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: Colors.greenAccent,
                                size: 18,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.height * 0.01),
                                child: Text(
                                  "วันที่ : ",
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                date.toString(),
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      // fontSize: 35,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.description_outlined,
                                color: Colors.greenAccent,
                                size: 18,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.height * 0.01),
                                child: Text(
                                  "คำอธิบายรูปภาพ",
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.comment,
                                color: Colors.greenAccent,
                                size: 18,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.height * 0.01),
                                child: Flexible(
                                  child: Container(
                                    width: size.width * 0.5,
                                    child: Text(
                                      description,
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      maxLines: 5,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Divider(
                          color: Colors.black12,
                          height: 10,
                          thickness: 2,
                          indent: 10,
                          endIndent: size.width * 0.025,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.height * 0.04,
                              top: size.height * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.height * 0.01),
                                child: Text(
                                  'ข้อมูลรูปภาพที่เกี่ยวข้อง',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          child: Container(
                            // height: size.height,
                            child: FutureBuilder<List<Upload2>>(
                              future: getupload2(),
                              builder: (context, snapshot) {
                                if (upload2.isNotEmpty) {
                                  return StaggeredGridView.countBuilder(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30,
                                    ),
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: BouncingScrollPhysics(),
                                    crossAxisCount: 5,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (Upload2, index) {
                                      final upload = snapshot.data![index];
                                      return GestureDetector(
                                        onTap: () {
                                          showDialogTravel(
                                              context,
                                              uploadimage,
                                              uploadname,
                                              tag,
                                              date,
                                              description);
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
                                                            BorderRadius
                                                                .circular(15),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child:
                                                            CachedNetworkImage(
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                          imageUrl:
                                                              'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload2/${upload.image}',
                                                          fit: BoxFit.cover,
                                                          width: size.width,
                                                          height: size.height,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            'images/picturecontent/travel.jpg',
                                                            fit: BoxFit.cover,
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal:
                                                          AppConst.padding),
                                                  child: Row(
                                                    children: [
                                                      // CircleAvatar(
                                                      //   radius: 14,
                                                      //   backgroundImage: AssetImage(post.userImg),
                                                      // ),
                                                      const SizedBox(
                                                          width:
                                                              AppConst.padding),
                                                      Text('${upload.name}'),
                                                      const Spacer(),
                                                      Row(
                                                        children: [
                                                          // const Icon(
                                                          //   Icons.thumb_up_alt_outlined,
                                                          //   color: Colors.blue,
                                                          // ),
                                                          const SizedBox(
                                                              width: AppConst
                                                                      .padding /
                                                                  2),
                                                          // Text(post.likes.toString()),
                                                          const SizedBox(
                                                              width: AppConst
                                                                  .padding),
                                                          const Icon(
                                                            Icons
                                                                .chat_bubble_outline_rounded,
                                                            color: Colors.black,
                                                          ),
                                                          const SizedBox(
                                                              width: AppConst
                                                                      .padding /
                                                                  2),
                                                          // Text(post.comments.toString()),
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
                                    staggeredTileBuilder: (index) =>
                                        // new StaggeredTile.fit(1),
                                        index % 8 == 2
                                            ? StaggeredTile.count(1, 1.3)
                                            : StaggeredTile.count(2, 1.3),
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
                        ),
                      ],
                    ),
                  ),
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
    if (result.length > 6) {
      result = result.substring(0, 5);
      result = '$result ..ดูข้อมูลเพิ่มเติม';
    }
    return result;
  }
}
