// import 'dart:html';
import 'dart:convert';
import 'dart:io';
// import 'dart:convert';
import 'dart:math';
// import 'dart:typed_data';
import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:path/path.dart';
// import 'package:async/async.dart';
import 'package:provider/provider.dart';
// import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project_web_supportandservice/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruseredit.dart';
import 'package:flutter_project_web_supportandservice/widget/headeruseredit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertData extends StatelessWidget {
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
  File? file;
  String image = '';
  late String namepicture, tag, image_description;
  ImagePicker picker = ImagePicker();
  Provider? provider;
  bool kIsWeb = identical(0, 0.0);

  String? user_id;
  String? topic_id;
  String? token;

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //TextEditingController useridController = TextEditingController();
  TextEditingController namepictureController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController image_descriptionController = TextEditingController();

  Future pickerimage(ImageSource imageSource) async {
    // ignore: deprecated_member_use
    final myfile = await picker.getImage(
      source: imageSource,
      maxHeight: 50.0,
      maxWidth: 50.0,
    );

    if (myfile != null) {
      setState(
        () {
          file = File(myfile.path);
        },
      );
    }
  }

  Future<Null> uploadPictureAndInsertData() async {
    String namepicture = namepictureController.text;
    String tag = tagController.text;
    String image_description = image_descriptionController.text;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username')!;

    print(
        ' namepicture = $namepicture, tag = $tag, image = $image_description');
    String path =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/getuserwhereuser.php?isAdd=true&username=$username';
    await Dio().get(path).then((value) async {
      print('value ==> $value');
      if (value.toString() != 'null') {
        print('user ok');
        if (file == null) {
          processInsertToMySQL();
        } else {
          String apiSaveImage =
              'http://localhost/flutter_project_web_supportandservice/Backend/server/savefileImage.php?isAdd=true&image=$file';
          int i = Random().nextInt(100000);
          String nameImage = '$i.jpg';
          Map<String, dynamic> map = Map();
          // map['file'] =
          //     await MultipartFile.fromFile(file!.path, filename: nameImage);
          map['file'] = http.MultipartFile.fromBytes(file!.path,
              File.fromUri(Uri.parse(apiSaveImage)).readAsBytesSync(),
              filename: nameImage);
          FormData data = FormData.fromMap(map);
          print('Data Form ==> ${data}');
          await Dio().post(apiSaveImage,data: data).then(
            (value) {
              image = '/Backend/server/Data/fileupload2/$nameImage';
              print('image ==> $image');
              processInsertToMySQL(
                namepicture: namepicture,
                tag: tag,
                image_description: image_description,
                image: image,
              );
            },
          );
        }
      } else {}
    });
  }

  Future<Null> processInsertToMySQL({
    String? namepicture,
    String? tag,
    String? image_description,
    String? image,
    File? file,
  }) async {
    print('processInsertMySQL Work and Image ==> $image');
    String apiInsertData =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/insert.php?isAdd=true&user_id=$user_id&namepicture=$namepicture&tag=$tag&image_description=$image_description&image=$image';
    await http.get(
      Uri.parse(apiInsertData),
      headers: {"Content-Type": "multipart/form-data"},
    ).then(
      (value) {
        if (value.toString() == 'true') {
          // Navigator.pop(context);
          print('insert true');
        } else {
          // normalDialog(context, 'ข้อมูลไม่ถูกต้อง ', 'ไม่สามารถอัพโหลดข้อมูลได้');
          print('fail upload');
        }
      },
    );
  }

  Widget showImage(BuildContext context) {
    // ignore: unused_local_variable
    double size = MediaQuery.of(context).size.height * 0.4;
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 7,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                border: Border.all(color: Colors.black45, width: 1.2),
              ),
              child: file == null
                  ? Text(
                      "กรุณากดปุ่ม"
                      "อัพโหลด"
                      "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent.shade200,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(color: Colors.black45, width: 1),
                      ),
                      child: Image.network(file!.path),
                    ),
            ),
          ),
        ],
      ),
    );
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
                              showImage(context),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      pickerimage(ImageSource.gallery);
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
                                      // if (provider.file == null) return;
                                      // provider.
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
                                        } else if (file == null) {
                                          normalDialog(
                                              context,
                                              'ไม่สามารถอัพโหลดได้',
                                              'กรุณากรอกข้อมูลให้ครบถ้วน');
                                        } else {
                                          uploadPictureAndInsertData();
                                        }
                                      }
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
}
