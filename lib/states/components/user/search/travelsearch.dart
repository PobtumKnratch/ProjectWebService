import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/states/components/user/picture_components.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload2.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:universal_html/html.dart';

import '../../../../widget/constants.dart';

class TeavelSearch extends StatefulWidget {
  List<Upload2> models;
  TeavelSearch({
    required this.models,
    Key? key,
  }) : super(key: key);
  @override
  _TravelState createState() => _TravelState();
}

class _TravelState extends State<TeavelSearch> {
  // late Future<List<Upload2>> upload2;
  List<String> upload2 = [];
  bool loading = false, allLoaded = false;
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;
  String query = '';
  // List<Upload2> upload2 = [];

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

  // @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;

  //   return Container(
  //     child: widget.models.isEmpty
  //         ? Center(
  //             child: Text(
  //               'ไม่พบข้อมูล',
  //               style: GoogleFonts.kanit(fontSize: size.width * 0.01),
  //             ),
  //           )
  //         : GridView.builder(
  //             itemCount: widget.models.length,
  //             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
  //                 mainAxisExtent: 250,
  //                 mainAxisSpacing: 1,
  //                 crossAxisSpacing: 1,
  //                 maxCrossAxisExtent: 400),
  //             itemBuilder: (context, index) => ClipRRect(
  //               borderRadius: BorderRadius.circular(15),
  //               clipBehavior: Clip.antiAlias,
  //               child: Column(
  //                 children: [
  //                   SizedBox(
  //                     width: 250,
  //                     height: 250,
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(15),
  //                       clipBehavior: Clip.antiAlias,
  //                       child: CachedNetworkImage(
  //                         placeholder: (context, url) => Center(
  //                           child: CircularProgressIndicator(),
  //                         ),
  //                         imageUrl:
  //                             '$hostpic/fileupload2/${widget.models[index].image}',
  //                         fit: BoxFit.cover,
  //                         width: size.width,
  //                         height: size.height,
  //                         errorWidget: (context, url, error) => Image.asset(
  //                           'images/picturecontent/travel.jpg',
  //                           fit: BoxFit.cover,
  //                           width: size.width,
  //                           height: size.height,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Text(
  //                     widget.models[index].name,
  //                     style: GoogleFonts.kanit(
  //                       textStyle: TextStyle(
  //                         color: Colors.greenAccent.shade700,
  //                         fontSize: 14,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //   );
  // }

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
    return Container(
      height: size.height,
      // width: size.width * 0.2,
      child: widget.models.isEmpty
          ? Center(
              child: Text(
                'ไม่พบข้อมูล',
                style: GoogleFonts.kanit(fontSize: size.width * 0.01),
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
                                showDialogTravel(context, upload.image,
                                    upload.name, upload.date);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                      const SizedBox(height: AppConst.padding),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppConst.padding),
                                        child: Row(
                                          children: [
                                            // CircleAvatar(
                                            //   radius: 14,
                                            //   backgroundImage: AssetImage(post.userImg),
                                            // ),
                                            const SizedBox(
                                                width: AppConst.padding),
                                            Text(
                                              widget.models[index].name,
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                // const Icon(
                                                //   Icons.thumb_up_alt_outlined,
                                                //   color: Colors.blue,
                                                // ),
                                                const SizedBox(
                                                    width:
                                                        AppConst.padding / 2),
                                                // Text(post.likes.toString()),
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
                                                // Text(post.comments.toString()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: AppConst.padding),
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
    );
  }

  showDialogTravel(context, uploadimage, uploadname, uploaddate) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
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
                            child: Text(
                              uploadname,
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    // fontSize: 35,
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
                              // onPressed: () async {
                              //   SharedPreferences preferences =
                              //       await SharedPreferences.getInstance();
                              //   preferences.clear().then(
                              //         (value) =>
                              //             Navigator.pushNamedAndRemoveUntil(
                              //                 context,
                              //                 '/picturecomponents',
                              //                 (route) => false),
                              //       );
                              // },
                              // onPressed: () => Navigator.of(context).pop(null),
                              // onPressed: () {
                              //   Navigator.of(context).maybePop();
                              // },
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.001, left: size.height * 0.02),
                        child: Text(
                          'Golfy.theerawee@gmail.com',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                // fontSize: 35,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.009, left: size.height * 0.25),
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
                              uploaddate.toString(),
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
                                        showDialogTravel(context, upload.image,
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
                                                          BorderRadius.circular(
                                                              15),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      child: CachedNetworkImage(
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
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(
                                                    //       top: size.height * 0.25),
                                                    //   child: GridTile(
                                                    //     footer: Material(
                                                    //       color: Colors.transparent,
                                                    //       shape: RoundedRectangleBorder(
                                                    //         borderRadius:
                                                    //             BorderRadius.vertical(
                                                    //           bottom: Radius.circular(15),
                                                    //         ),
                                                    //       ),
                                                    //       clipBehavior: Clip.antiAlias,
                                                    //     ),
                                                    //     child: GridTileBar(
                                                    //       // backgroundColor: Colors.black12,
                                                    //       title: Text(
                                                    // cutWord('${upload.name}'),
                                                    //         textAlign: TextAlign.center,
                                                    //         softWrap: true,
                                                    //         style: TextStyle(
                                                    //           fontSize: 18,
                                                    //         ),
                                                    //       ),
                                                    //       subtitle: Text(
                                                    //         '${upload.date}',
                                                    //         textAlign: TextAlign.center,
                                                    //         softWrap: true,
                                                    //         style: TextStyle(fontSize: 18),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                  height: AppConst.padding),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
