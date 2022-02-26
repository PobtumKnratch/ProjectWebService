import 'dart:html' as html;
import 'dart:io';
import 'dart:io' show File;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_project_web_supportandservice/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruseredit.dart';
import 'package:flutter_project_web_supportandservice/widget/headeruseredit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload2.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload3.dart';
import 'package:flutter_project_web_supportandservice/Model/fileupload4.dart';

class EditData extends StatelessWidget {
  // const UserEditPersonal({Key? key}) : super(key: key);
  static const String routeName = '/editdata';
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
  Upload? model1;
  Upload2? model2;
  Upload3? model3;
  Upload4? model4;
  Body({Key? key, this.model1, this.model2, this.model3, this.model4})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Widget> itemPhotosWidgetList = <Widget>[];
  Upload? model;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? photo = <XFile>[];
  List<XFile> itemImagesList = <XFile>[];
  List<String> downloadUrl = <String>[];
  bool uploading = false;
  double _scrollPosition = 0;
  double _opacity = 0;
  File? file;
  String? image;
  late String name, tag, description;

  FilePickerResult? result;
  PlatformFile? platformFile;
  Dio dio = Dio();
  List<int>? _selectedFile;
  Uint8List? _bytesData;

  String? user_id;
  String? topic_id;
  String? token;
  int selectIndex = 0;
  List<Upload> showModel = [];

  Future<void> initData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? topic_ic = preferences.getString('topic_id');
    if (topic_ic == '1') {
      // List<Upload2> models2 = await editTravelupload2();
      // print('length ===>>>> ${models2.length}');
      // for (var item in models2) {
      //   setState(() {
      //     nameController.text = model!.name;
      //     descriptionController.text = model!.description;
      //     tagController.text = model!.name;
      //   });
      List<Upload2> models;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String id = preferences.getString('id')!;
      final url =
          'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/EditData/getdata2.php?id=$id';
      final response = await http.get(Uri.parse(url));
      print(response);
      if (response.statusCode == 200) {
        // return upload2FromJson(response.body);
        // print(response.body);
        for (var item in json.decode(response.body)) {
          setState(() {
            models = Upload2.fromMap(item) as List<Upload2>;
            nameController.text = model!.name;
            descriptionController.text = model!.description;
            tagController.text = model!.name;
          });
        }
      } else {
        throw Exception(response.hashCode);
      }
      // showModel.add(Upload(
      //     title: 'หมวดหมู่การท่องเที่ยว',
      //     id: item.id,
      //     user_id: item.user_id,
      //     name: item.name,
      //     description: item.description,
      //     image: 'fileupload2/${item.image}',
      //     date: item.date,
      //     tag: item.tag));
      // }
    } else if (topic_ic == '2') {
      List<Upload> models;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String id = preferences.getString('id')!;
      final url =
          'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/EditData/getdata.php?id=$id';
      final response = await http.get(Uri.parse(url));
      print(response);
      if (response.statusCode == 200) {
        // return upload2FromJson(response.body);
        // print(response.body);
        for (var item in json.decode(response.body)) {
          setState(() {
            models = Upload.fromMap(item) as List<Upload>;
            nameController.text = model!.name;
            descriptionController.text = model!.description;
            tagController.text = model!.name;
          });
        }
      } else {
        throw Exception(response.hashCode);
      }
      // List<Upload> models = await editFoodupload();
      // print('length ===>>>> ${models.length}');
      // for (var item in models) {
      //   setState(() {
      //     nameController.text = model!.name;
      //     descriptionController.text = model!.description;
      //     tagController.text = model!.name;
      //   });
      // showModel.add(Upload(
      //     title: 'หมวดหมู่อาหาร',
      //     id: item.id,
      //     user_id: item.user_id,
      //     name: item.name,
      //     description: item.description,
      //     image: 'fileupload/${item.image}',
      //     date: item.date,
      //     tag: item.tag));
      // }
    } else if (topic_ic == '3') {
      List<Upload3> models;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String id = preferences.getString('id')!;
      final url =
          'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/EditData/getdata3.php?id=$id';
      final response = await http.get(Uri.parse(url));
      print(response);
      if (response.statusCode == 200) {
        // return upload2FromJson(response.body);
        // print(response.body);
        for (var item in json.decode(response.body)) {
          setState(() {
            models = Upload3.fromMap(item) as List<Upload3>;
            nameController.text = model!.name;
            descriptionController.text = model!.description;
            tagController.text = model!.name;
          });
        }
      } else {
        throw Exception(response.hashCode);
      }
      // List<Upload3> models3 = await editSignboardupload3();
      // print('length ===>>>> ${models3.length}');
      // for (var item in models3) {
      //   setState(() {
      //     nameController.text = model!.name;
      //     descriptionController.text = model!.description;
      //     tagController.text = model!.name;
      //   });
      // showModel.add(Upload(
      //     title: 'ป้ายสถานที่ท่องเที่ยวต่างๆ',
      //     id: item.id,
      //     user_id: item.user_id,
      //     name: item.name,
      //     description: item.description,
      //     image: 'fileupload3/${item.image}',
      //     date: item.date,
      //     tag: item.tag));
      // }
    } else if (topic_ic == '4') {
      List<Upload4> models;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String id = preferences.getString('id')!;
      final url =
          'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/EditData/getdata4.php?id=$id';
      final response = await http.get(Uri.parse(url)).then((value) {
        print('valur 4 ===> $value');
        for (var item in json.decode(value.body)) {
          setState(() {
            model = Upload4.fromMap(item) as Upload?;
            nameController.text = model!.name;
            descriptionController.text = model!.description;
            tagController.text = model!.name;
          });
        }
      });
      // print(response);
      // if (response.statusCode == 200) {
      // return upload2FromJson(response.body);
      // print(response.body);

      // } else {
      //   throw Exception(response.hashCode);
      // }
      // List<Upload4> models4 = await editScenarioupload4();
      // print('length ===>>>> ${models4.length}');
      // for (var item in models4) {
      //   setState(() {
      //     nameController.text = model!.name;
      //     descriptionController.text = model!.description;
      //     tagController.text = model!.name;
      //   });
      // showModel.add(Upload(
      //     title: 'หมวดหมู่ตามสถานการณ์',
      //     id: item.id,
      //     user_id: item.user_id,
      //     name: item.name,
      //     description: item.description,
      //     image: 'fileupload4/${item.image}',
      //     date: item.date,
      //     tag: item.tag));
      // }
    }
  }

  @override
  void initState() {
    if (widget.model1 != null) {
      model = Upload(
          title: 'หมวดหมู่อาหาร',
          id: widget.model1!.id,
          user_id: widget.model1!.user_id,
          name: widget.model1!.name,
          description: widget.model1!.description,
          image: 'fileupload2/${widget.model1!.image}',
          date: widget.model1!.date,
          tag: widget.model1!.tag);
    } else if (widget.model2 != null) {
      model = Upload(
          title: 'หมวดหมู่การท่องเที่ยว',
          id: widget.model2!.id,
          user_id: widget.model2!.user_id,
          name: widget.model2!.name,
          description: widget.model2!.description,
          image: 'fileupload/${widget.model2!.image}',
          date: widget.model2!.date,
          tag: widget.model2!.tag);
    } else if (widget.model3 != null) {
      model = Upload(
          title: 'หมวดหมู่ป้ายสถานที่',
          id: widget.model3!.id,
          user_id: widget.model3!.user_id,
          name: widget.model3!.name,
          description: widget.model3!.description,
          image: 'fileupload3/${widget.model3!.image}',
          date: widget.model3!.date,
          tag: widget.model3!.tag);
    } else {
      model = Upload(
          title: 'หมวดหมู่ตามสถานการณ์',
          id: widget.model4!.id,
          user_id: widget.model4!.user_id,
          name: widget.model4!.name,
          description: widget.model4!.description,
          image: 'fileupload4/${widget.model4!.image}',
          date: widget.model4!.date,
          tag: widget.model4!.tag);
    }
    super.initState();
    findUser();
    initData();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        user_id = preferences.getString('user_id');
        topic_id = preferences.getString('topic_id');
        token = preferences.getString('token');
      },
    );
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();
      // print(file);
      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result!);
        // print(reader.result!);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData =
          const Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  Future<void> ApiaddData(
    Uint8List _bytesImgData,
  ) async {
    String name = nameController.text;
    String tag = tagController.text;
    String description = descriptionController.text;
    print('Topic ID : $topic_id');
    print('User ID : $user_id');
    // print('Token : ${token}');
    if (topic_id == "1") {
      print('### topic id ==> 1 ##### ');
      print('## name ==> 1 ## : $name');
      print('## tag ==> 1 ## : $tag');
      print('## image_description ==> 1 ## : $description');
      String path = '${hostInsert}/savefileImage2.php';

      String pathUser =
          '${hostlogin}/getuserwhereuser.php?isAdd=true&user_id=$user_id';
      await dio.get(pathUser).then(
        (value) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String? user_id = preferences.getString('user_id');
          int i = Random().nextInt(100000000);
          String fileName = '$i.jpg';
          Map<String, dynamic> map = Map();
          map['file'] =
              MultipartFile.fromBytes(_bytesImgData, filename: fileName);
          FormData data = FormData.fromMap(map);
          await dio
              .post(
            path,
            data: data,
          )
              .then(
            (value) {
              dio.options.headers['content-Type'] = 'text/plain; charset=UTF-8';
              dio.options.headers['Access-Control-Allow-Origin'] = '*';
              dio.options.headers['Access-Control-Allow-Methods'] =
                  'GET , POST';
              print('Path Data ==> $fileName');
              // image = 'Backend/server/Data/fileupload2/$fileName';
              image = fileName;
              print('image ==> $image');
              String apiInsertData =
                  '${hostInsert}/insert2.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=$image';
              dio.get(apiInsertData).then(
                (value) {
                  if (value.toString() == 'true') {
                    print('insert true');
                    Navigator.pop(context);
                  } else {
                    print('fail upload');
                  }
                },
              );
            },
          );
        },
      );
    } else if (topic_id == "2") {
      print('topic id ==> 2 : ');
      print('### topic id ==> 2 ##### ');
      print('## name ==> 2 ## : $name');
      print('## tag ==> 2 ## : $tag');
      print('## image_description ==> 2 ## : $description');
      String path = '${hostInsert}/savefileImage.php';

      String pathUser =
          '${hostlogin}/getuserwhereuser.php?isAdd=true&user_id=$user_id';
      await dio.get(pathUser).then(
        (value) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String? user_id = preferences.getString('user_id');
          int i = Random().nextInt(100000000);
          String fileName = '$i.jpg';
          Map<String, dynamic> map = Map();
          map['file'] =
              MultipartFile.fromBytes(_bytesImgData, filename: fileName);
          FormData data = FormData.fromMap(map);
          await dio
              .post(
            path,
            data: data,
          )
              .then(
            (value) {
              dio.options.headers['content-Type'] = 'text/plain; charset=UTF-8';
              dio.options.headers['Access-Control-Allow-Origin'] = '*';
              dio.options.headers['Access-Control-Allow-Methods'] =
                  'GET , POST';
              print('Path Data ==> $fileName');
              // image = 'Backend/server/Data/fileupload/$fileName';
              image = fileName;
              print('image ==> $image');
              String apiInsertData =
                  '${hostInsert}/insert.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=$image';
              dio.get(apiInsertData).then(
                (value) {
                  if (value.toString() == 'true') {
                    print('insert true');
                  } else {
                    print('fail upload');
                  }
                },
              );
            },
          );
        },
      );
    } else if (topic_id == "3") {
      print('topic id ==> 3 : ');
      print('### topic id ==> 3 ##### ');
      print('## name ==> 3 ## : $name');
      print('## tag ==> 3 ## : $tag');
      print('## image_description ==> 3 ## : $description');
      String path = '${hostInsert}/savefileImage3.php';

      String pathUser =
          '${hostlogin}/getuserwhereuser.php?isAdd=true&user_id=$user_id';
      await dio.get(pathUser).then(
        (value) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String? user_id = preferences.getString('user_id');
          int i = Random().nextInt(100000000);
          String fileName = '$i.jpg';
          Map<String, dynamic> map = Map();
          map['file'] =
              MultipartFile.fromBytes(_bytesImgData, filename: fileName);
          FormData data = FormData.fromMap(map);
          await dio
              .post(
            path,
            data: data,
          )
              .then(
            (value) {
              dio.options.headers['content-Type'] = 'text/plain; charset=UTF-8';
              dio.options.headers['Access-Control-Allow-Origin'] = '*';
              dio.options.headers['Access-Control-Allow-Methods'] =
                  'GET , POST';
              print('Path Data ==> $fileName');
              // image = 'Backend/server/Data/fileupload3/$fileName';
              image = fileName;
              print('image ==> $image');
              String apiInsertData =
                  '${hostInsert}/insert3.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=$image';
              dio.get(apiInsertData).then(
                (value) {
                  if (value.toString() == 'true') {
                    print('insert true');
                  } else {
                    print('fail upload');
                  }
                },
              );
            },
          );
        },
      );
    } else if (topic_id == "4") {
      print('topic id ==> 4 : ');
      print('### topic id ==> 4 ##### ');
      print('## name ==> 4 ## : $name');
      print('## tag ==> 4 ## : $tag');
      print('## image_description ==> 4 ## : $description');
      String path = '$hostInsert/savefileImage4.php';

      String pathUser =
          '${hostlogin}/getuserwhereuser.php?isAdd=true&user_id=$user_id';
      await dio.get(pathUser).then(
        (value) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String? user_id = preferences.getString('user_id');
          int i = Random().nextInt(100000000);
          String fileName = '$i.jpg';
          Map<String, dynamic> map = Map();
          map['file'] =
              MultipartFile.fromBytes(_bytesImgData, filename: fileName);
          FormData data = FormData.fromMap(map);
          await dio
              .post(
            path,
            data: data,
          )
              .then(
            (value) {
              dio.options.headers['content-Type'] = 'text/plain; charset=UTF-8';
              dio.options.headers['Access-Control-Allow-Origin'] = '*';
              dio.options.headers['Access-Control-Allow-Methods'] =
                  'GET , POST';
              print('Path Data ==> $fileName');
              // image = 'Backend/server/Data/fileupload4/$fileName';
              image = fileName;
              print('image ==> $image');
              String apiInsertData =
                  '$hostInsert/insert4.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=$image';
              dio.get(apiInsertData).then(
                (value) {
                  if (value.toString() == 'true') {
                    print('insert true');
                  } else {
                    print('fail upload');
                  }
                },
              );
            },
          );
        },
      );
    }
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
              child: Image.memory(
                _bytesData!,
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
        top: size.height * 0.04,
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
                  'แก้ไขข้อมูลรูปภาพ',
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
                  top: size.height * 0.01,
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
                                          controller: nameController,
                                          onChanged: (value) =>
                                              name = value.trim(),
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
                                          controller: descriptionController,
                                          onChanged: (value) =>
                                              description = value.trim(),
                                          autocorrect: true,
                                          keyboardType: TextInputType.multiline,
                                          textAlign: TextAlign.start,
                                          maxLines: 10,
                                          decoration: InputDecoration(
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
                                    onPressed: () => startWebFilePicker(),
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
                                        if (name == null ||
                                            name.isEmpty ||
                                            tag == null ||
                                            tag.isEmpty ||
                                            description == null ||
                                            description.isEmpty ||
                                            _selectedFile == null ||
                                            _selectedFile!.isEmpty) {
                                          normalDialog(
                                              context,
                                              'ไม่สามารถบันทึกข้อมูลได้',
                                              'กรุณากรอกข้อมูลของท่านให้ครบถ้วน');
                                        } else if (_selectedFile == null) {
                                          normalDialog(
                                              context,
                                              'ไม่สามารถอัพโหลดได้',
                                              'กรุณากรอกข้อมูลให้ครบถ้วน');
                                        } else {
                                          ApiaddData(_bytesData!);
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
