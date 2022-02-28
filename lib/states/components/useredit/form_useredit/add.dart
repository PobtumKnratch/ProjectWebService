import 'dart:html' as html;
import 'dart:io';
import 'dart:io' show File;
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_project_web_supportandservice/responsive.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project_web_supportandservice/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruseredit.dart';
import 'package:flutter_project_web_supportandservice/widget/headeruseredit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add extends StatelessWidget {
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
      appBar: size.width < 1200
          ? AppBar(
              iconTheme: IconThemeData(color: Colors.black, size: 20),
              elevation: 0,
              backgroundColor: Colors.greenAccent.shade700,
              title: Row(
                children: [
                  Image(
                    image: AssetImage('images/pictureicon/logo.png'),
                    width: 25,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    'NAVANURAK',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : PreferredSize(
              preferredSize: Size(size.width, 70),
              child: HeaderBarEdit(_opacity),
            ),
      // drawer: createDrawer(context),
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
        child: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Body(),
              ],
            ),
          ),
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
  List<Widget> itemPhotosWidgetList = <Widget>[];

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

  var mimeType;

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
      token = preferences.getString('token');
    });
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // addImage() {
  //   for (var bytes in photo!) {
  //     itemPhotosWidgetList.add(
  //       Padding(
  //         padding: const EdgeInsets.all(1.0),
  //         child: Container(
  //           height: 90.0,
  //           child: AspectRatio(
  //             aspectRatio: 16 / 9,
  //             child: Container(
  //               child: kIsWeb
  //                   ? Image.network(File(bytes.path).path)
  //                   : Image.file(
  //                       File(bytes.path),
  //                     ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }

  Future<void> insertImage(
    Uint8List _bytesImgData,
  ) async {
    String path =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/savefileImage.php';
    // print(path);
    int i = Random().nextInt(99999);
    String fileName = '$i.jpg';
    Map<String, dynamic> map = {};
    map['file'] = MultipartFile.fromBytes(_bytesImgData, filename: fileName);
    FormData data = FormData.fromMap(map);
    // print(data.files);

    await Dio()
        .post(path, data: data)
        .then(
          (value) => print(value),
        )
        .onError((error, stackTrace) {
      print('Error => $error');
      // print('StackTrack ==> $stackTrace');
      // return;
    });
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        scrollable: true,
        title: Text('เพิ่มรูปภาพสำเร็จ'),
        content: Text('เพิ่มรูปภาพสำเร็จ'),
      ),
    );

    // showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //           scrollable: true,
    //           title: Text(e.toString()),
    //         ));
  }

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

  Future<Null> uploadImageAndInsertData(PlatformFile? platformFile) async {
    String name = nameController.text;
    String tag = tagController.text;
    String description = descriptionController.text;
    // File? file;
    print(
        '## userid = $user_id, namepicture = $name, tag = $tag, name = $description,');

    String pathUser =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/getuserwhereuser.php?isAdd=true&user_id=$user_id';
    await http.get(Uri.parse(pathUser)).then(
      (value) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? user_id = preferences.getString('user_id');
        processInsertMySQL(
          name: name,
          tag: tag,
          description: description,
        );
      },
    );
  }

  Future<void> insertDataImage(
    Uint8List _bytesImgData,
  ) async {
    String name = nameController.text;
    String tag = tagController.text;
    String description = descriptionController.text;
    String path =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/insertData/savefileImage2.php';

    String pathUser =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/getuserwhereuser.php?isAdd=true&user_id=$user_id';
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
            dio.options.headers['Access-Control-Allow-Methods'] = 'GET , POST';
            print('Path Data ==> $fileName');
            image = 'Backend/server/Data/fileupload2/$fileName';
            print('image ==> $image');
            String apiInsertData =
                'http://localhost/flutter_project_web_supportandservice/Backend/server/Data/insertData/insert2.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=$image';
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
        // showDialog(
        //   context: context,
        //   builder: (context) => const AlertDialog(
        //     scrollable: true,
        //     title: Text('เพิ่มรูปภาพสำเร็จ'),
        //     content: Text('เพิ่มรูปภาพสำเร็จ'),
        //   ),
        // );

        // showDialog(
        //     context: context,
        //     builder: (context) => AlertDialog(
        //           scrollable: true,
        //           title: Text(e.toString()),
        //         ));
      },
    );
  }

  Future<Null> processInsertMySQL({
    String? name,
    String? tag,
    String? description,
  }) async {
    print('processInsertMySQL Work and Image ==> $image');
    String apiInsertData =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/insert.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=$image';
    await dio.get(apiInsertData).then(
      (value) {
        if (value.toString() == 'true') {
          print('insert true');
        } else {
          print('fail upload');
        }
      },
    );
  }

  Future pickerimage(ImageSource imageSource) async {
    try {
      var myfile = await ImagePicker().pickImage(
        source: imageSource,
        maxHeight: 50.0,
        maxWidth: 50.0,
      );

      setState(
        () {
          print(myfile);
          if (myfile != null) {
            file = File(myfile.path);
            print('Selected image = $file');
            // String filename = basename(myfile.path);
            // uploadFile(filename, image);
          } else {
            print('No image selected.');
          }
        },
      );
    } catch (e) {}
  }

  Widget showImage(BuildContext context) {
    // ignore: unused_local_variable
    double size = MediaQuery.of(context).size.height * 0.4;
    return Responsive(
      mobile: Container(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 7,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(color: Colors.black45, width: 1.2),
                ),
                child: _bytesData == null
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
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.black45, width: 1),
                        ),
                        child: Image.memory(
                          _bytesData!,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      tablet: Container(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 7,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(color: Colors.black45, width: 1.2),
                ),
                child: _bytesData == null
                    ? Text(
                        "กรุณากดปุ่ม"
                        "อัพโหลด"
                        "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent.shade200,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.black45, width: 1),
                        ),
                        child: Image.memory(
                          _bytesData!,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      desktop: Container(
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
                child: _bytesData == null
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
                        child: Image.memory(
                          _bytesData!,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Responsive(
      mobile: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.05,
        ),
        child: Container(
          width: size.width * 0.9,
          // height: size.height ,
          padding: EdgeInsets.only(
            top: size.height * 0.1,
            left: size.width * 0.05,
            right: size.width * 0.05,
            // bottom: size.height * 0.1,
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
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.022,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      bottom: size.height * 0.02),
                  child: Form(
                    key: _formKey,
                    child: Column(
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
                            // height: size.height,
                            margin: EdgeInsets.only(
                              left: size.width * 0.02,
                              right: size.width * 0.02,
                              top: size.height * 0.02,
                              bottom: size.height*0.03
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
                                      width: size.width * 0.6,
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
                                                  fontSize: 10),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            controller: nameController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกชื่อรูปภาพ';
                                              } else {
                                                return null;
                                              }
                                            },
                                            onChanged: (value) =>
                                                name = value.trim(),
                                            autocorrect: true,
                                            // minLines: 1,
                                            // obscureText: true,
                                            decoration: InputDecoration(
                                              // contentPadding:
                                              //     EdgeInsets.fromLTRB(
                                              //         20, 20, 20, 20),
                                              errorStyle: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  color: Colors.red.shade400,
                                                  fontSize: 7,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              labelText: "กรอกชื่อรูปภาพ",
                                              labelStyle: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 10,
                                                ),
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
                                      width: size.width * 0.6,
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
                                                  fontSize: 10),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            controller: tagController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกแฮชแท็กรูปภาพ';
                                              } else {
                                                return null;
                                              }
                                            },
                                            onChanged: (value) =>
                                                tag = value.trim(),
                                            autocorrect: true,
                                            // maxLines: 1,
                                            // obscureText: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      5, 5, 5, 5),
                                              errorStyle: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  color: Colors.red.shade400,
                                                  fontSize: 7,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              labelText: "กรอกข้อมูลแฮชแท็ก",
                                              labelStyle: GoogleFonts.kanit(
                                                textStyle:
                                                    TextStyle(fontSize: 10),
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
                                      width: size.width * 0.6,
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
                                                  fontSize: 10),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SingleChildScrollView(
                                            child: TextFormField(
                                              controller: descriptionController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'กรุณากรอกคำอธิบายรูปภาพ';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) =>
                                                  description = value.trim(),
                                              autocorrect: true,
                                              // maxLines: 3,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              textAlign: TextAlign.start,
                                              decoration: InputDecoration(
                                                errorStyle: GoogleFonts.kanit(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.red.shade400,
                                                      fontSize: 7,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                hintText:
                                                    "กรุณากรอกคำอธิบายรูปภาพ",
                                                hintStyle: GoogleFonts.kanit(
                                                  textStyle:
                                                      TextStyle(fontSize: 10),
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
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 7,
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    border: Border.all(
                                                        color: Colors.black45,
                                                        width: 1.2),
                                                  ),
                                                  child: _bytesData == null
                                                      ? Text(
                                                          "กรุณากดปุ่ม"
                                                          "อัพโหลด"
                                                          "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
                                                          style:
                                                              GoogleFonts.kanit(
                                                            textStyle:
                                                                TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .redAccent
                                                                  .shade200,
                                                            ),
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      : Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.3,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.0),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black45,
                                                                width: 1),
                                                          ),
                                                          child: Image.memory(
                                                            _bytesData!,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.03),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.06),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              MaterialButton(
                                                onPressed: () =>
                                                    startWebFilePicker(),
                                                color: Colors.grey.shade400,
                                                height: 25,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  'เลือกรูปภาพ',
                                                  style: GoogleFonts.kanit(
                                                    textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.03,
                                              ),
                                              MaterialButton(
                                                elevation: 5.0,
                                                child: Text(
                                                  'บันทึก',
                                                  style: GoogleFonts.kanit(
                                                    textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                color:
                                                    Colors.greenAccent.shade400,
                                                height: 25,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    if (nameController ==
                                                            null ||
                                                        tagController == null ||
                                                        descriptionController ==
                                                            null ||
                                                        _selectedFile == null) {
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
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: size.width * 0.05,
                        // ),
                        // Card(
                        //   color: Colors.grey.shade200,
                        //   elevation: 10,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(15.0),
                        //   ),
                        //   child: Container(
                        //     // height: size.height * 0.65,
                        //     margin: EdgeInsets.only(
                        //       left: size.width * 0.02,
                        //       right: size.width * 0.02,
                        //       top: size.height * 0.02,
                        //       bottom:
                        //     ),
                        //     child:
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      tablet: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.05,
        ),
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.65,
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
                            height: size.height * 0.4,
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
                                      // width: size.width * 0.28,
                                      child: SizedBox(
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
                                                    fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            TextFormField(
                                              controller: nameController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'กรุณากรอกชื่อรูปภาพ';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) =>
                                                  name = value.trim(),
                                              autocorrect: true,
                                              maxLines: 1,
                                              // obscureText: true,
                                              decoration: InputDecoration(
                                                // contentPadding: EdgeInsets.fromLTRB(
                                                //     10, 10, 10, 10),
                                                // isDense: true,
                                                // errorStyle: GoogleFonts.kanit(
                                                //   textStyle: TextStyle(
                                                //     color: Colors.red.shade400,
                                                //     fontSize: 12,
                                                //     fontWeight: FontWeight.normal,
                                                //   ),
                                                // ),
                                                labelText: "กรอกชื่อรูปภาพ",
                                                labelStyle: GoogleFonts.kanit(
                                                  textStyle:
                                                      TextStyle(fontSize: 12),
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
                                    ),
                                    SizedBox(
                                      height: size.height * 0.005,
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
                                                  fontSize: 12),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          TextFormField(
                                            controller: tagController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกแฮชแท็กรูปภาพ';
                                              } else {
                                                return null;
                                              }
                                            },
                                            onChanged: (value) =>
                                                tag = value.trim(),
                                            autocorrect: true,
                                            maxLines: 1,
                                            // obscureText: true,
                                            decoration: InputDecoration(
                                              // errorStyle: GoogleFonts.kanit(
                                              //   textStyle: TextStyle(
                                              //     color: Colors.red.shade400,
                                              //     fontSize: 12,
                                              //     fontWeight: FontWeight.normal,
                                              //   ),
                                              // ),
                                              labelText: "กรอกข้อมูลแฮชแท็ก",
                                              labelStyle: GoogleFonts.kanit(
                                                textStyle:
                                                    TextStyle(fontSize: 12),
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
                                      height: size.height * 0.005,
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
                                                  fontSize: 12),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          SingleChildScrollView(
                                            child: TextFormField(
                                              controller: descriptionController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'กรุณากรอกคำอธิบายรูปภาพ';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) =>
                                                  description = value.trim(),
                                              autocorrect: true,
                                              maxLines: 4,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              textAlign: TextAlign.start,
                                              decoration: InputDecoration(
                                                // errorStyle: GoogleFonts.kanit(
                                                //   textStyle: TextStyle(
                                                //       color: Colors.red.shade400,
                                                //       fontSize: 12,
                                                //       fontWeight:
                                                //           FontWeight.normal),
                                                // ),
                                                hintText:
                                                    "กรุณากรอกคำอธิบายรูปภาพ",
                                                hintStyle: GoogleFonts.kanit(
                                                  textStyle:
                                                      TextStyle(fontSize: 12),
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
                            height: size.height * 0.4,
                            margin: EdgeInsets.only(
                              left: size.width * 0.02,
                              right: size.width * 0.02,
                              top: size.height * 0.02,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 7,
                                        ),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            border: Border.all(
                                                color: Colors.black45,
                                                width: 1.2),
                                          ),
                                          child: _bytesData == null
                                              ? Text(
                                                  "กรุณากดปุ่ม"
                                                  "อัพโหลด"
                                                  "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
                                                  style: GoogleFonts.kanit(
                                                    textStyle: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors
                                                          .redAccent.shade200,
                                                    ),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )
                                              : Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    border: Border.all(
                                                        color: Colors.black45,
                                                        width: 1),
                                                  ),
                                                  child: Image.memory(
                                                    _bytesData!,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MaterialButton(
                                      onPressed: () => startWebFilePicker(),
                                      color: Colors.grey.shade400,
                                      height: 35,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'เลือกรูปภาพ',
                                        style: GoogleFonts.kanit(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
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
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      color: Colors.greenAccent.shade400,
                                      height: 35,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (nameController == null ||
                                              tagController == null ||
                                              descriptionController == null ||
                                              _selectedFile == null) {
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
      ),
      desktop: Padding(
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
                    style: GoogleFonts.kanit(
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
                                      // width: size.width * 0.28,
                                      child: SizedBox(
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
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'กรุณากรอกชื่อรูปภาพ';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) =>
                                                  name = value.trim(),
                                              autocorrect: true,
                                              maxLines: 1,
                                              // obscureText: true,
                                              decoration: InputDecoration(
                                                // contentPadding: EdgeInsets.fromLTRB(
                                                //     10, 10, 10, 10),
                                                // isDense: true,
                                                // errorStyle: GoogleFonts.kanit(
                                                //   textStyle: TextStyle(
                                                //     color: Colors.red.shade400,
                                                //     fontSize: 14,
                                                //     fontWeight: FontWeight.normal,
                                                //   ),
                                                // ),
                                                labelText: "กรอกชื่อรูปภาพ",
                                                labelStyle: GoogleFonts.kanit(
                                                  textStyle:
                                                      TextStyle(fontSize: 16),
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
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Container(
                                      width: size.width * 0.28,

                                      // margin: EdgeInsets.only(
                                      //     top: size.height * 0.03),
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
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกแฮชแท็กรูปภาพ';
                                              } else {
                                                return null;
                                              }
                                            },
                                            onChanged: (value) =>
                                                tag = value.trim(),
                                            autocorrect: true,
                                            maxLines: 1,
                                            // obscureText: true,
                                            decoration: InputDecoration(
                                              // errorStyle: GoogleFonts.kanit(
                                              //   textStyle: TextStyle(
                                              //     color: Colors.red.shade400,
                                              //     fontSize: 14,
                                              //     fontWeight: FontWeight.normal,
                                              //   ),
                                              // ),
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
                                          SingleChildScrollView(
                                            child: TextFormField(
                                              controller: descriptionController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'กรุณากรอกคำอธิบายรูปภาพ';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) =>
                                                  description = value.trim(),
                                              autocorrect: true,
                                              maxLines: 6,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              textAlign: TextAlign.start,
                                              decoration: InputDecoration(
                                                // errorStyle: GoogleFonts.kanit(
                                                //   textStyle: TextStyle(
                                                //       color: Colors.red.shade400,
                                                //       fontSize: 14,
                                                //       fontWeight:
                                                //           FontWeight.normal),
                                                // ),
                                                hintText:
                                                    "กรุณากรอกคำอธิบายรูปภาพ",
                                                hintStyle: GoogleFonts.kanit(
                                                  textStyle:
                                                      TextStyle(fontSize: 16),
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
                                Container(
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 7,
                                        ),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            border: Border.all(
                                                color: Colors.black45,
                                                width: 1.2),
                                          ),
                                          child: _bytesData == null
                                              ? Text(
                                                  "กรุณากดปุ่ม"
                                                  "อัพโหลด"
                                                  "เพื่อเลือกรูปสำหรับการค้นหาข้อมูลและสถานที่",
                                                  style: GoogleFonts.kanit(
                                                    textStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors
                                                          .redAccent.shade200,
                                                    ),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )
                                              : Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    border: Border.all(
                                                        color: Colors.black45,
                                                        width: 1),
                                                  ),
                                                  child: Image.memory(
                                                    _bytesData!,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                          if (nameController == null ||
                                              tagController == null ||
                                              descriptionController == null ||
                                              _selectedFile == null) {
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
      ),
    );
  }
}
