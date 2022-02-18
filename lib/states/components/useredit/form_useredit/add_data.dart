import 'dart:io';
import 'dart:convert';

// import 'dart:math';
import 'package:path/path.dart';
import 'package:async/async.dart';
// import 'package:http_parser/http_parser.dart';
import 'package:flutter_project_web_supportandservice/widget/dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruseredit.dart';
import 'package:flutter_project_web_supportandservice/widget/headeruseredit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AddData extends StatelessWidget {
  // const UserEditPersonal({Key? key}) : super(key: key);
  static const String routeName = '/addpicture';
  late double opacity;
  double _scrollPosition = 0;
  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, 70),
        child: HeaderBarEdit(_opacity),
      ),
      drawer: createDraweredit(context),
      extendBodyBehindAppBar: true,
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: createDraweredit(context),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/picturebackground/usereditpersonal.jpg'),
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(
            //     Colors.black87.withOpacity(0.65), BlendMode.dstATop),
          ),
        ),
        child: Column(
          children: [
            Body(),
          ],
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double _scrollPosition = 0;
  double _opacity = 0;
  // File? image;
  late Future<File> file;
  static final String uploadEndPoint =
      'http://localhost/flutter_project_web_supportandservice/Backend/server/upload.php';
  Path? path;
  String? status = '';
  late String base64Image;
  late File tmpFile;
  String? errMessage = 'Error Upload Image';
  // String image = '';
  // String? selectName;
  // ignore: deprecated_member_use
  // List topic = [];
  late String namepicture, tag, image_description;
  ImagePicker picker = ImagePicker();
  // late PickedFile file;

  String? user_id;
  String? topic_id;
  // String? token;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString('user_id');
      topic_id = preferences.getString('topic_id');
      // token = preferences.getString('token');
    });
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController useridController = TextEditingController();
  TextEditingController namepictureController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController image_descriptionController = TextEditingController();

  Future<void> ApiaddData(
    BuildContext context, {
    String? namepicture,
    String? tag,
    String? image_description,
    File? image,
  }) async {
    print('name : ${namepicture}');
    print('tag : ${tag}');
    print('image_description : ${image_description}');
    print('file : ${image}');
    print('Topic ID : ${topic_id}');
    print('User ID : ${user_id}');
    // print('Token : ${token}');
    if (topic_id == "1") {
      print('### topic id ==> 1 ##### ');
      print('## name ==> 1 ## : ${namepicture}');
      print('## tag ==> 1 ## : ${tag}');
      print('## image_description ==> 1 ## : ${image_description}');
      print('## file ==> 1 ## : ${image}');

      var stream =
          new http.ByteStream(DelegatingStream.typed(image!.openRead()));
      stream.cast();

      var length = await image.length();

      var urldata = Uri.parse(
          "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insert1.php");

      var request = new http.MultipartRequest('POST', urldata);
      request.fields['namepicture'] = namepictureController.text;
      request.fields['tag'] = tagController.text;
      request.fields['image_description'] = image_descriptionController.text;

      var multiport = new http.MultipartFile('image', stream, length,
          filename: basename(image.path));
      request.files.add(multiport);

      var response = await request.send();
      print(response.stream.toString());
      if (response.statusCode == 200) {
        print('image upload');
      } else {
        print('failed');
      }
    } else if (topic_id == "2") {
      print('topic id ==> 2 : ');
    } else if (topic_id == "3") {
      print('topic id ==> 3 : ');
    } else if (topic_id == "4") {
      print('topic id ==> 4 : ');
    }
  }

  Future pickerimage() async {
    // ignore: deprecated_member_use
    PickedFile? myfile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 50.0,
      maxWidth: 50.0,
    );
    if (myfile != null) {
      setState(() {
        file = File(myfile.path) as Future<File>;
      });
    }
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image..');
    if (null == tmpFile) {
      setStatus(errMessage!);
      return;
    }
    String filename = tmpFile.path.split('/').last;
    upload(filename);
  }

  upload(String filename) {
    http.post(Uri.parse(uploadEndPoint), body: {
      "image": base64Image,
      "name": filename,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage!);
    }).catchError((error) {
      setStatus(error);
    });
  }

  // Widget showImage(BuildContext context) {
  //   // ignore: unused_local_variable
  //   double size = MediaQuery.of(context).size.height * 0.4;
  //   return Container(
  //     child: Stack(
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.only(
  //             top: 7,
  //           ),
  //           child: Container(
  //             width: MediaQuery.of(context).size.width * 0.4,
  //             height: MediaQuery.of(context).size.height * 0.5,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(7.0),
  //               border: Border.all(color: Colors.black45, width: 1.2),
  //             ),
  //             child: file == null
  //                 ? Text(
  //                     "กรุณากดปุ่ม"
  //                     "อัพโหลด"
  //                     "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
  //                     style: GoogleFonts.kanit(
  //                       textStyle: TextStyle(
  //                         fontSize: 16,
  //                         color: Colors.redAccent.shade200,
  //                       ),
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   )
  //                 : Container(
  //                     width: MediaQuery.of(context).size.width * 0.4,
  //                     height: MediaQuery.of(context).size.height * 0.5,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(7.0),
  //                       border: Border.all(color: Colors.black45, width: 1),
  //                     ),
  //                     child: Image.network(file.),
  //                   ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget showImage() {
    return FutureBuilder<File>(
        future: file,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              null != snapshot.data) {
            tmpFile = snapshot.data!;
            base64Image = base64Encode(snapshot.data!.readAsBytesSync());
            return Flexible(
              child: Image.file(
                snapshot.data!,
                fit: BoxFit.fill,
              ),
            );
          } else if (null != snapshot.error) {
            return Text(
              'Error Picing Image',
              textAlign: TextAlign.center,
            );
          } else {
            return Text(
              'No Image Selected',
              textAlign: TextAlign.center,
            );
          }
        },);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.05,
      ),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.9,
        padding: EdgeInsets.only(
          top: size.height * 0.1,
          left: size.width * 0.05,
          right: size.width * 0.05,
        ),
        child: Card(
          color: Colors.white60,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'เพิ่มข้อมูลรูปภาพ',
                  // textAlign: TextAlign.center,
                  style: GoogleFonts.mali(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.022,
                  left: size.width * 0.05,
                ),
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: Colors.grey.shade200,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          width: size.width * 0.3,
                          height: size.height * 0.65,
                          margin: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.02,
                            top: size.height * 0.02,
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Container(
                                    width: size.width * 0.28,
                                    // height: size.height * 0.1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ชื่อรูปภาพ',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: namepictureController,
                                          onChanged: (value) =>
                                              namepicture = value.trim(),
                                          autocorrect: true,
                                          // obscureText: true,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            isDense: true,
                                            errorStyle: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                color: Colors.red.shade400,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            labelText: "กรอกชื่อรูปภาพ",
                                            labelStyle: GoogleFonts.kanit(
                                              textStyle:
                                                  TextStyle(fontSize: 18),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Colors.black54,
                                                width: 1,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Container(
                                    width: size.width * 0.28,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'แฮชแท็ก',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: tagController,
                                          onChanged: (value) =>
                                              tag = value.trim(),
                                          autocorrect: true,
                                          // obscureText: true,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            errorStyle: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                color: Colors.red.shade400,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            labelText: "กรอกข้อมูลแฮชแท็ก",
                                            labelStyle: GoogleFonts.kanit(
                                              textStyle:
                                                  TextStyle(fontSize: 18),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Colors.black54,
                                                width: 1,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: size.height * 0.01,
                                  // ),
                                  // Text(
                                  //   'ประเภทข้อมูลรูปภาพ',
                                  //   style: GoogleFonts.kanit(
                                  //     textStyle: TextStyle(
                                  //         color: Colors.black, fontSize: 18),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: size.height * 0.01,
                                  // ),
                                  // DropdownButton(
                                  //     dropdownColor:
                                  //         Colors.white,
                                  //     items: topic.map((Topic) {
                                  //       return DropdownMenuItem(
                                  //           value: Topic['topic_name'],
                                  //           child: Text(Topic['topic_name']));
                                  //     }).toList(),
                                  //     value: selectName,
                                  //     hint: Text(
                                  //       'โปรดเลือกประเภทข้อมูลรูปภาพ',
                                  //       style: GoogleFonts.kanit(
                                  //         textStyle: TextStyle(
                                  //           fontSize: 16,
                                  //         ),
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),
                                  //     onChanged: (value) {
                                  //       setState(() {
                                  //         selectName = value as String?;
                                  //       });
                                  //     }),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Container(
                                    width: size.width * 0.28,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'คำอธิบายรูปภาพ',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller:
                                              image_descriptionController,
                                          onChanged: (value) =>
                                              image_description = value.trim(),
                                          autocorrect: true,
                                          keyboardType: TextInputType.multiline,
                                          textAlign: TextAlign.start,
                                          maxLines: 10,
                                          // obscureText: true,
                                          decoration: InputDecoration(
                                            // contentPadding: EdgeInsets.fromLTRB(10, 50, 10, 50),
                                            isDense: true,
                                            errorStyle: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                color: Colors.red.shade400,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            hintText: "กรุณากรอกคำอธิบายรูปภาพ",
                                            hintStyle: GoogleFonts.kanit(
                                              textStyle:
                                                  TextStyle(fontSize: 18),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Colors.black54,
                                                width: 1,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Card(
                        color: Colors.grey.shade200,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          width: size.width * 0.28,
                          height: size.height * 0.65,
                          margin: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.02,
                            top: size.height * 0.02,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              showImage(),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      // var files = await pickerimage(
                                      //     ImageSource.gallery);
                                      pickerimage();
                                      // processAddImage();
                                    },
                                    color: Colors.grey.shade400,
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'เลือกรูปภาพ',
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    elevation: 5.0,
                                    child: Text(
                                      'บันทึก',
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    color: Colors.greenAccent.shade400,
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (namepicture == null ||
                                                namepicture.isEmpty ||
                                                // ignore: unnecessary_null_comparison
                                                tag == null ||
                                                tag.isEmpty ||
                                                image_description == null ||
                                                image_description.isEmpty
                                            // file == null ||
                                            // file!.isAbsolute
                                            ) {
                                          normalDialog(
                                              context,
                                              'ไม่สามารถบันทึกข้อมูลได้',
                                              'กรุณากรอกข้อมูลของท่านให้ครบถ้วน');
                                        } else {
                                          startUpload();
                                          // print(errorPropertyTextConfiguration);
                                          // ApiaddData();
                                          // var res = await ApiaddData(
                                          //   file: file,
                                          //   namepicture: namepicture,
                                          //   image_description:
                                          //       image_description,
                                          //   tag: tag,
                                          // );
                                          // setState(() {
                                          //   res();
                                          //   print(res);
                                          // });
                                          // ApiaddData(
                                          //   context,
                                          //   image_description:
                                          //       image_description,
                                          //   namepicture: namepicture,
                                          //   tag: tag,
                                          //   // image: file,
                                          // );
                                          // ApiaddDataPic();
                                        }
                                      } else {}
                                    },
                                  )
                                ],
                              ),
                            ],
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
      ),
    );
  }

  // void processAddImage() async {
  //   if (_formKey.currentState!.validate()) {
  //     bool checkFile = true;
  //     for (var item in file) {
  //       if (item == null) {
  //         checkFile = false;
  //       }
  //     }
  //     if (checkFile) {
  //       print('choose image success');
  //     } else {
  //       normalDialog(context, 'More image', 'Please Choose More Image');
  //     }
  //   }
  // }

  Widget buildDescription(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        width: size.width * 0.28,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'คำอธิบายรูปภาพ',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: image_descriptionController, autocorrect: true,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.start, maxLines: 12,
              // obscureText: true,
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.fromLTRB(10, 50, 10, 50),
                isDense: true,
                errorStyle: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    color: Colors.red.shade400,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hintText: "กรุณากรอกคำอธิบายรูปภาพ",
                hintStyle: GoogleFonts.kanit(
                  textStyle: TextStyle(fontSize: 18),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black54,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildname(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        width: size.width * 0.28,
        // height: size.height * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ชื่อรูปภาพ',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: namepictureController, autocorrect: true,
              // obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                isDense: true,
                errorStyle: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    color: Colors.red.shade400,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                labelText: "กรอกชื่อรูปภาพ",
                labelStyle: GoogleFonts.kanit(
                  textStyle: TextStyle(fontSize: 18),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black54,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTag(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        width: size.width * 0.28,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'แฮชแท็ก',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: tagController, autocorrect: true,
              // obscureText: true,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                errorStyle: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    color: Colors.red.shade400,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                labelText: "กรอกข้อมูลแฮชแท็ก",
                labelStyle: GoogleFonts.kanit(
                  textStyle: TextStyle(fontSize: 18),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black54,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
