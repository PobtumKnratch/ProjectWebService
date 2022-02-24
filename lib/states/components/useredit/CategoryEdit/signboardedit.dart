import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:flutter_project_web_supportandservice/widget/max_width_contanier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload3.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SignboardEdit extends StatefulWidget {
  const SignboardEdit({Key? key}) : super(key: key);

  @override
  _SignboardEditState createState() => _SignboardEditState();
}

class _SignboardEditState extends State<SignboardEdit> {
  List<String> upload3 = [];
  bool loading = false, allLoaded = false;
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

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
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.02, left: size.height * 0.05),
                child: Text(
                  " หมวดข้อมูลป้ายสถานที่ ",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      color: Colors.greenAccent.shade700,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.02,
                    left: size.height * 0.1,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    " ยอดนิยม ",
                    // textAlign: TextAlign.end,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.greenAccent.shade700,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
               padding: EdgeInsets.only(
                      top: size.height * 0.02,
                      // left: size.height * 0.05,
                      right: size.height * 0.02),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    " แนะนำ ",
                    // textAlign: TextAlign.end,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.greenAccent.shade700,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
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
                    itemCount: snapshot.data!.length,
                    itemBuilder: (Upload3, index) {
                      final upload = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          showDialogSignboard(
                              context, upload.image, upload.name, upload.date);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.loose,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        clipBehavior: Clip.antiAlias,
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          imageUrl:
                                              'http://localhost/flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/fileupload3/${upload.image}',
                                          fit: BoxFit.fill,
                                          width: size.width,
                                          height: size.height,
                                          errorWidget: (context, url, error) =>
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
                                      //       backgroundColor: Colors.transparent,
                                      //       title: Text(
                                      //         cutWord('${upload.name}'),
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
                                SizedBox(height: size.height * 0.02),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppConst.padding),
                                    child: Row(
                                      children: [
                                        // CircleAvatar(
                                        //   radius: 14,
                                        //   backgroundImage: AssetImage(post.userImg),
                                        // ),
                                        const SizedBox(width: AppConst.padding),
                                        Text('${upload.name}',
                                            style: GoogleFonts.kanit(
                                                fontSize: 10)),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            // const Icon(
                                            //   Icons.thumb_up_alt_outlined,
                                            //   color: Colors.blue,
                                            // ),
                                            const SizedBox(
                                                width: AppConst.padding / 2),
                                            // Text(post.likes.toString()),
                                            const SizedBox(
                                                width: AppConst.padding),
                                            const Icon(
                                              Icons.chat_bubble_outline_rounded,
                                              color: Colors.black,
                                              size: 10,
                                            ),
                                            // const SizedBox(
                                            //     width: AppConst.padding / ),
                                            // Text(post.comments.toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // const SizedBox(height: AppConst.padding),
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
