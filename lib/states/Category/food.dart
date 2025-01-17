// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/picture_components.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';

class FoodState extends StatefulWidget {
  List<Upload> models;
  FoodState({
    Key? key,
    required this.models,
  }) : super(key: key);

  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<FoodState> {
  List<String> upload = [];
  bool loading = false, allLoaded = false;
  final ScrollController _scrollController = ScrollController();
  // ignore: unused_field
  double _scrollPosition = 0;
  DateTime? date;

  mockFetch() async {
    if (allLoaded) {
      return;
    }
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    List<String> newData = upload.length >= 60
        ? []
        : List.generate(20, (index) => "List Upload ${index + upload.length}");
    if (newData.isNotEmpty) {
      upload.addAll(newData);
    }
    setState(() {
      loading = false;
      allLoaded = newData.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
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
                    child: FutureBuilder<List<Upload>>(
                      future: getupload(),
                      builder: (context, snapshot) {
                        if (upload.isNotEmpty) {
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
                                                      '$hostpic/fileupload/${widget.models[index].image}',
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
                    child: FutureBuilder<List<Upload>>(
                      future: getupload(),
                      builder: (context, snapshot) {
                        if (upload.isNotEmpty) {
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
                                                      '$hostpic/fileupload/${widget.models[index].image}',
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
                    child: FutureBuilder<List<Upload>>(
                      future: getupload(),
                      builder: (context, snapshot) {
                        if (upload.isNotEmpty) {
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
                                                      '$hostpic/fileupload/${widget.models[index].image}',
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

  showDialogTravel(context, uploadimage, tag, uploadname, date, description) {
    var size = MediaQuery.of(context).size;
    var _opacity = _scrollPosition < size.height * 0.40
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
                                'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload/${uploadimage}',
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
                              child: FutureBuilder<List<Upload>>(
                                future: getupload(),
                                builder: (context, snapshot) {
                                  if (upload.isNotEmpty) {
                                    return StaggeredGridView.countBuilder(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 30,
                                      ),
                                      shrinkWrap: true,
                                      primary: false,
                                      physics: BouncingScrollPhysics(),
                                      crossAxisCount: 4,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (Upload, index) {
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
                                                              'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload/${upload.image}',
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
                              'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload/${uploadimage}',
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
                            child: FutureBuilder<List<Upload>>(
                              future: getupload(),
                              builder: (context, snapshot) {
                                if (upload.isNotEmpty) {
                                  return StaggeredGridView.countBuilder(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30,
                                    ),
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: BouncingScrollPhysics(),
                                    crossAxisCount: 5,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (Upload, index) {
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
                                                              'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload/${upload.image}',
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
                    width: size.width * 0.61,
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
                              'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload/${uploadimage}',
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
                            child: FutureBuilder<List<Upload>>(
                              future: getupload(),
                              builder: (context, snapshot) {
                                if (upload.isNotEmpty) {
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
                                                              'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload/${upload.image}',
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
                                                          cutWord(upload.name)),
                                                      const Spacer(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .chat_bubble_outline_rounded,
                                                            color: Colors.black,
                                                          ),
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
  //   Responsive(
  //     mobile: Container(
  //       child: widget.models.isEmpty
  //           ? Center(
  //               child: Text(
  //                 'ไม่พบข้อมูล',
  //                 style: GoogleFonts.kanit(fontSize: size.width * 0.05),
  //               ),
  //             )
  //           : Column(
  //               children: [
  //                 Container(
  //                   height: size.height,
  //                   child: FutureBuilder<List<Upload>>(
  //                     future: getupload(),
  //                     builder: (context, snapshot) {
  //                       if (upload.isNotEmpty) {
  //                         return StaggeredGridView.countBuilder(
  //                           padding: EdgeInsets.symmetric(
  //                             horizontal: 30,
  //                           ),
  //                           shrinkWrap: true,
  //                           primary: false,
  //                           physics: BouncingScrollPhysics(),
  //                           crossAxisCount: 2,
  //                           itemCount: widget.models.length,
  //                           itemBuilder: (context, index) {
  //                             final upload = snapshot.data![index];
  //                             return GestureDetector(
  //                               onTap: () {
  //                                 showDialogFood(context, upload.image,
  //                                     upload.name, upload.date);
  //                               },
  //                               child: Padding(
  //                                 padding:
  //                                     EdgeInsets.only(top: size.height * 0.02),
  //                                 child: Container(
  //                                   alignment: Alignment.center,
  //                                   child: Column(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.start,
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Flexible(
  //                                         flex: 1,
  //                                         fit: FlexFit.loose,
  //                                         child: Stack(
  //                                           children: [
  //                                             ClipRRect(
  //                                               borderRadius:
  //                                                   BorderRadius.circular(15),
  //                                               clipBehavior: Clip.antiAlias,
  //                                               child: CachedNetworkImage(
  //                                                 placeholder: (context, url) =>
  //                                                     Center(
  //                                                   child:
  //                                                       CircularProgressIndicator(),
  //                                                 ),
  //                                                 imageUrl:
  //                                                     '$hostpic/fileupload/${widget.models[index].image}',
  //                                                 fit: BoxFit.cover,
  //                                                 width: size.width,
  //                                                 height: size.height,
  //                                                 errorWidget:
  //                                                     (context, url, error) =>
  //                                                         Image.asset(
  //                                                   'images/picturecontent/travel.jpg',
  //                                                   fit: BoxFit.fill,
  //                                                   width: size.width,
  //                                                   height: size.height,
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       SizedBox(height: size.height * 0.02),
  //                                       Padding(
  //                                         padding: const EdgeInsets.symmetric(
  //                                             horizontal: AppConst.padding),
  //                                         child: Row(
  //                                           children: [
  //                                             const SizedBox(
  //                                                 width: AppConst.padding),
  //                                             Text(
  //                                               widget.models[index].name,
  //                                               style: GoogleFonts.kanit(
  //                                                   fontSize: 20),
  //                                             ),
  //                                             const Spacer(),
  //                                             Row(
  //                                               children: [
  //                                                 const SizedBox(
  //                                                     width:
  //                                                         AppConst.padding / 2),
  //                                                 const SizedBox(
  //                                                     width: AppConst.padding),
  //                                                 const Icon(
  //                                                   Icons
  //                                                       .chat_bubble_outline_rounded,
  //                                                   color: Colors.black,
  //                                                   size: 10,
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                           staggeredTileBuilder: (index) =>
  //                               // new StaggeredTile.fit(1),
  //                               index % 8 == 2
  //                                   ? StaggeredTile.count(2, 1.5)
  //                                   : StaggeredTile.count(2, 2.5),
  //                           // new StaggeredTile.count(2, index.isEven ? 2 : 1.5 ),
  //                           mainAxisSpacing: 8,
  //                           crossAxisSpacing: 8,
  //                           controller: _scrollController,
  //                         );
  //                       } else {
  //                         return Center(
  //                           child: CircularProgressIndicator(),
  //                         );
  //                       }
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //     ),
  //     tablet: Container(
  //       child: widget.models.isEmpty
  //           ? Center(
  //               child: Text(
  //                 'ไม่พบข้อมูล',
  //                 style: GoogleFonts.kanit(fontSize: size.width * 0.05),
  //               ),
  //             )
  //           : Column(
  //               children: [
  //                 Container(
  //                   height: size.height,
  //                   child: FutureBuilder<List<Upload>>(
  //                     future: getupload(),
  //                     builder: (context, snapshot) {
  //                       if (upload.isNotEmpty) {
  //                         return StaggeredGridView.countBuilder(
  //                           padding: EdgeInsets.symmetric(
  //                             horizontal: 30,
  //                           ),
  //                           shrinkWrap: true,
  //                           primary: false,
  //                           physics: BouncingScrollPhysics(),
  //                           crossAxisCount: 7,
  //                           itemCount: widget.models.length,
  //                           itemBuilder: (context, index) {
  //                             final upload = snapshot.data![index];
  //                             return GestureDetector(
  //                               onTap: () {
  //                                 showDialogFood(context, upload.image,
  //                                     upload.name, upload.date);
  //                               },
  //                               child: Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Container(
  //                                   alignment: Alignment.center,
  //                                   child: Column(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.start,
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Flexible(
  //                                         flex: 1,
  //                                         fit: FlexFit.loose,
  //                                         child: Stack(
  //                                           children: [
  //                                             ClipRRect(
  //                                               borderRadius:
  //                                                   BorderRadius.circular(15),
  //                                               clipBehavior: Clip.antiAlias,
  //                                               child: CachedNetworkImage(
  //                                                 placeholder: (context, url) =>
  //                                                     Center(
  //                                                   child:
  //                                                       CircularProgressIndicator(),
  //                                                 ),
  //                                                 imageUrl:
  //                                                     '$hostpic/fileupload/${widget.models[index].image}',
  //                                                 fit: BoxFit.cover,
  //                                                 width: size.width,
  //                                                 height: size.height,
  //                                                 errorWidget:
  //                                                     (context, url, error) =>
  //                                                         Image.asset(
  //                                                   'images/picturecontent/travel.jpg',
  //                                                   fit: BoxFit.cover,
  //                                                   width: size.width,
  //                                                   height: size.height,
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       const SizedBox(
  //                                           height: AppConst.padding),
  //                                       Padding(
  //                                         padding: const EdgeInsets.symmetric(
  //                                             horizontal: AppConst.padding),
  //                                         child: Row(
  //                                           children: [
  //                                             const SizedBox(
  //                                                 width: AppConst.padding),
  //                                             Text('${upload.name}'),
  //                                             const Spacer(),
  //                                             Row(
  //                                               children: [
  //                                                 const SizedBox(
  //                                                     width:
  //                                                         AppConst.padding / 2),
  //                                                 const SizedBox(
  //                                                     width: AppConst.padding),
  //                                                 const Icon(
  //                                                   Icons
  //                                                       .chat_bubble_outline_rounded,
  //                                                   color: Colors.black,
  //                                                 ),
  //                                                 const SizedBox(
  //                                                     width:
  //                                                         AppConst.padding / 2),
  //                                               ],
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       const SizedBox(
  //                                           height: AppConst.padding),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                           staggeredTileBuilder: (index) => index % 8 == 2
  //                               ? StaggeredTile.count(1, 1.5)
  //                               : StaggeredTile.count(2, 1.5),
  //                           // new StaggeredTile.count(2, index.isEven ? 2 : 1.5 ),
  //                           mainAxisSpacing: 8,
  //                           crossAxisSpacing: 8,
  //                           controller: _scrollController,
  //                         );
  //                       } else {
  //                         return Center(
  //                           child: CircularProgressIndicator(),
  //                         );
  //                       }
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //     ),
  //     desktop: Container(
  //       child: widget.models.isEmpty
  //           ? Center(
  //               child: Text(
  //                 'ไม่พบข้อมูล',
  //                 style: GoogleFonts.kanit(fontSize: size.width * 0.05),
  //               ),
  //             )
  //           : Column(
  //               children: [
  //                 Container(
  //                   height: size.height,
  //                   child: FutureBuilder<List<Upload>>(
  //                     future: getupload(),
  //                     builder: (context, snapshot) {
  //                       if (upload.isNotEmpty) {
  //                         return StaggeredGridView.countBuilder(
  //                           padding: EdgeInsets.symmetric(
  //                             horizontal: 30,
  //                           ),
  //                           shrinkWrap: true,
  //                           primary: false,
  //                           physics: BouncingScrollPhysics(),
  //                           crossAxisCount: 7,
  //                           itemCount: widget.models.length,
  //                           itemBuilder: (context, index) {
  //                             final upload = snapshot.data![index];
  //                             return GestureDetector(
  //                               onTap: () {
  //                                 showDialogFood(context, upload.image,
  //                                     upload.name, upload.date);
  //                               },
  //                               child: Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Container(
  //                                   alignment: Alignment.center,
  //                                   child: Column(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.start,
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Flexible(
  //                                         flex: 1,
  //                                         fit: FlexFit.loose,
  //                                         child: Stack(
  //                                           children: [
  //                                             ClipRRect(
  //                                               borderRadius:
  //                                                   BorderRadius.circular(15),
  //                                               clipBehavior: Clip.antiAlias,
  //                                               child: CachedNetworkImage(
  //                                                 placeholder: (context, url) =>
  //                                                     Center(
  //                                                   child:
  //                                                       CircularProgressIndicator(),
  //                                                 ),
  //                                                 imageUrl:
  //                                                     '$hostpic/fileupload/${widget.models[index].image}',
  //                                                 fit: BoxFit.cover,
  //                                                 width: size.width,
  //                                                 height: size.height,
  //                                                 errorWidget:
  //                                                     (context, url, error) =>
  //                                                         Image.asset(
  //                                                   'images/picturecontent/travel.jpg',
  //                                                   fit: BoxFit.cover,
  //                                                   width: size.width,
  //                                                   height: size.height,
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       const SizedBox(
  //                                           height: AppConst.padding),
  //                                       Padding(
  //                                         padding: const EdgeInsets.symmetric(
  //                                             horizontal: AppConst.padding),
  //                                         child: Row(
  //                                           children: [
  //                                             const SizedBox(
  //                                                 width: AppConst.padding),
  //                                             Text(
  //                                               widget.models[index].name,
  //                                               style: GoogleFonts.kanit(
  //                                                   fontSize:
  //                                                       18),
  //                                             ),
  //                                             const Spacer(),
  //                                             Row(
  //                                               children: [
  //                                                 const SizedBox(
  //                                                     width:
  //                                                         AppConst.padding / 2),
  //                                                 const SizedBox(
  //                                                     width: AppConst.padding),
  //                                                 const Icon(
  //                                                   Icons
  //                                                       .chat_bubble_outline_rounded,
  //                                                   color: Colors.black,
  //                                                 ),
  //                                                 const SizedBox(
  //                                                     width:
  //                                                         AppConst.padding / 2),
  //                                               ],
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       const SizedBox(
  //                                           height: AppConst.padding),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                           staggeredTileBuilder: (index) => index % 8 == 2
  //                               ? StaggeredTile.count(1, 1.5)
  //                               : StaggeredTile.count(2, 1.5),
  //                           // new StaggeredTile.count(2, index.isEven ? 2 : 1.5 ),
  //                           mainAxisSpacing: 8,
  //                           crossAxisSpacing: 8,
  //                           controller: _scrollController,
  //                         );
  //                       } else {
  //                         return Center(
  //                           child: CircularProgressIndicator(),
  //                         );
  //                       }
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //     ),
  //   );
  // }

  // showDialogFood(context, uploadimage, uploadname, uploaddate) {
  //   // ignore: unused_local_variable
  //   Size size = MediaQuery.of(context).size;
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         child: Center(
  //           child: Material(
  //             type: MaterialType.transparency,
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: Colors.white,
  //               ),
  //               padding: EdgeInsets.all(15),
  //               width: MediaQuery.of(context).size.width * 0.6,
  //               height: 800,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 15),
  //                     child: Text(
  //                       "ข้อมูลการท่องเที่ยว",
  //                       style: TextStyle(
  //                           fontSize: 30, fontWeight: FontWeight.bold),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 20),
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(10),
  //                       child: Image.network(
  //                         'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload/${uploadimage}',
  //                         fit: BoxFit.fill,
  //                         width: 500,
  //                         height: 450,
  //                         alignment: Alignment.center,
  //                         errorBuilder: (context, error, stackTrace) =>
  //                             Image.asset(
  //                           'images/picturecontent/travel.jpg',
  //                           fit: BoxFit.fill,
  //                           width: 500,
  //                           height: 450,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 20,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 50),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "ชื่อของรูปภาพ : ",
  //                           style: TextStyle(
  //                               fontSize: 20,
  //                               // fontWeight: FontWeight.bold,
  //                               color: Colors.black),
  //                           textAlign: TextAlign.left,
  //                         ),
  //                         SizedBox(
  //                           width: 15,
  //                         ),
  //                         Text(
  //                           uploadname,
  //                           style: TextStyle(
  //                               fontSize: 20,
  //                               // fontWeight: FontWeight.bold,
  //                               color: Colors.black),
  //                           textAlign: TextAlign.left,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 50),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "วันที่ : ",
  //                           style: TextStyle(
  //                               fontSize: 18,
  //                               // fontWeight: FontWeight.bold,
  //                               color: Colors.black),
  //                           textAlign: TextAlign.left,
  //                         ),
  //                         SizedBox(
  //                           width: 3,
  //                         ),
  //                         Text(
  //                           uploaddate.toString(),
  //                           style: TextStyle(fontSize: 18),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 50),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "คำอธิบายรูปภาพ",
  //                           style: TextStyle(
  //                               fontSize: 18,
  //                               // fontWeight: FontWeight.bold,
  //                               color: Colors.black),
  //                           textAlign: TextAlign.left,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 50),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "ร้านนี้ตั้งอยู่ซอยอารีย์ ต้นๆซอยค่ะ บรรยากาศร่มรื่น ใครทำงานแถวนั้นช่วงกลางวันก็แวะเวียนไปได้ กิมมิคอยู่ที่ข้าวถาดหลุมที่เหมือนเราได้ย้อนวัยนี่ล่ะ ",
  //                           textAlign: TextAlign.left,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  String cutWord(String name) {
    String result = name;
    if (result.length > 5) {
      result = result.substring(0, 5);
      result = '$result ..เพิ่มเติม';
    }
    return result;
  }
}
