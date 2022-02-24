import 'dart:html' as html;
import 'dart:io';
import 'dart:io' show File;
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_project_web_supportandservice/widget/constants.dart';

import 'package:image_picker_web/image_picker_web.dart';
import 'package:open_file/open_file.dart';
import 'package:mime_type/mime_type.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as Path;
import 'package:async/async.dart';

import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';
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
  Provider? provider;
  bool kIsWeb = identical(0, 0.0);
  Uint8List webImage = Uint8List(10);

  FilePickerResult? result;
  PlatformFile? platformFile;

  Dio dio = Dio();
  // late html.File _cloudFile;
  // var _fileBytes;
  // late Uint8List _imageWidget;
  // PlatformFile? objFile = null;
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
  //TextEditingController useridController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  addImage() {
    for (var bytes in photo!) {
      itemPhotosWidgetList.add(
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: 90.0,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                child: kIsWeb
                    ? Image.network(File(bytes.path).path)
                    : Image.file(
                        File(bytes.path),
                      ),
              ),
            ),
          ),
        ),
      );
    }
  }

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
      // print(_selectedFile);
    });
  }

  // Future addCategory() async {
  //   final urldata = Uri.parse(
  //       "http://localhost/flutter_project_web_supportandservice/Backend/server/uptravel.php");
  //   String pathUser =
  //       'http://localhost/flutter_project_web_supportandservice/Backend/server/getuserwhereuser.php?isAdd=true&user_id=$user_id';
  //   await http.get(Uri.parse(pathUser)).then(
  //     (value) async {
  //       SharedPreferences preferences = await SharedPreferences.getInstance();
  //       String? user_id = preferences.getString('user_id');
  //       print('user_id ==> ${user_id}');
  //       print('name ==> ${name}');
  //       print('tag ==> ${tag}');
  //       print('description ==> ${description}');
  //       print('image ==> ${_imageWidget}');

  //       var data = {
  //         "user_id": user_id,
  //         "name": nameController.text,
  //         "tag": tagController.text,
  //         "description": descriptionController.text,

  //       };
  //       var response = await http.post(urldata, body: data);
  //       if (response.statusCode == 200) {
  //         print('Response Success ==> ${response.body}');
  //       } else {
  //         print('Error Status Code ${response.statusCode}');
  //       }
  //     },
  //   );
  // }

  // Future<void> insertPicture(Uint8List _bytesImgData,
  //     {String dirName = 'img1'}) async {
  //   String name = nameController.text;
  //   String tag = tagController.text;
  //   String description = descriptionController.text;
  //   //flutter_project_web_supportandservice/Backend/server/backendlastversion/pictur_data/saveFile.php
  //   String path = '$hosttravel/saveFile.php?dirName=$dirName';
  //   print('path ==>> $path');

  //   int i = Random().nextInt(100000000);
  //   String fileName = 'img1_$i.jpg';
  //   Map<String, dynamic> map = Map();
  //   map['file'] = MultipartFile.fromBytes(_bytesImgData, filename: fileName);
  //   FormData data = FormData.fromMap(map);
  //   await dio
  //       .post(
  //     path,
  //     data: data,
  //   )
  //       .then(
  //     (value) {
  //       dio.options.headers['content-Type'] = 'text/plain; charset=UTF-8';
  //       dio.options.headers['Access-Control-Allow-Origin'] = '*';
  //       dio.options.headers['Access-Control-Allow-Methods'] = 'GET , POST';
  //       // print('Path Data ==> $fileName');
  //       // image = 'Backend/server/Data/fileupload2/$fileName';
  //       // image = fileName;
  //       // print('image ==> $image');
  //       String apiInsertData =
  //           '$hostInsert/insertPicture.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=/$dirName/$fileName';
  //       dio.get(apiInsertData).then(
  //         (value) {
  //           if (value.toString() == 'true') {
  //             print('insert true');
  //             Navigator.pop(context);
  //           } else {
  //             print('fail upload');
  //           }
  //         },
  //       );
  //     },
  //   );
  // }

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
      String path = '${hostInsert}/savefileImage4.php';

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
                  '${hostInsert}/insert4.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=$image';
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

        // if (result != null) platformFile = result!.files.first;

        // Uint8List? fileBytes = result!.files.first.bytes;
        // String fileName =
        //     // basename(file.path!);
        //     result!.files.first.name;
        // final contentType = mimeType != null ? MediaType.parse(mimeType) : null;

        // final stream = http.ByteStream.fromBytes(fileBytes!);

        // print('Name : ${fileName}');
        // print('Bytes : ${fileBytes}');
        // print('Size : ${platformFile!.size}');
        // print('Extension : ${platformFile!.extension}');
        // // print('Path : ${platformFile!.path}');

        // print('picture ==> ${fileName}');

        //print('# user_id ==> $user_id');
        processInsertMySQL(
          name: name,
          tag: tag,
          description: description,
        );
        // print('Image ==> ${platformFile!.path}');
        // if (value.toString() != 'null') {
        //   print('## success');
        //   processInsertMySQL(
        //     name: name,
        //     tag: tag,
        //     description: description,
        //   );

        // if (file == null) {
        //   //No image
        //   processInsertMySQL(
        //       name: name,
        //       tag: tag,
        //       description: description);
        // } else {
        // have image
        // print('process upload image');
        // print('Picture ==>$file ');
        // String apiSaveImage =
        //     'http://localhost/flutter_project_web_supportandservice/Backend/server/uptravel.php?isAdd=true&image=$stream';
        // print('API Save Image ==> $apiSaveImage');
        // int i = Random().nextInt(100000);
        // String nameImage = '$i.jpg';

        // Map<String, dynamic> map = Map();
        // map['file'] =  http.MultipartFile.fromBytes(
        //     'image', File.fromUri(Uri.parse(apiSaveImage)).readAsBytesSync(),
        //     filename: file!.path, contentType: new MediaType('image', 'jpeg'));
        // // map['file'] = await http.MultipartFile.fromBytes(file!.path,
        // //     File.fromUri(Uri.parse(apiSaveImage)).readAsBytesSync(),
        // //     filename: nameImage);
        // var request = http.MultipartRequest('POST', Uri.parse(apiSaveImage));
        // request.headers['Access-Control-Allow-Origin'] = "*";
        // request.headers['Access-Control-Allow-Methods'] = "POST";
        // request.headers['Access-Control-Allow-Headers'] = "Content-Type";
        // request.fields['name'] = nameController.text;
        // request.fields['tag'] = tagController.text;
        // request.fields['description'] = descriptionController.text;
        // map['file'] = http.MultipartFile(
        //   'file',
        //   stream,
        //   platformFile!.size,
        //   filename: fileName,
        //   contentType: contentType,
        // );
        // request.files.add(multipartFile);
        // FormData data = FormData(map);
        // print('Data Form ==> ${data}');
        // await http.post(
        //   Uri.parse(apiSaveImage),
        //   body: data,
        //   encoding: Encoding.getByName("utf-8"),
        //   headers: {"Content-Type": "multipart/form-data"},
        // ).then(
        //   (value) {
        //     image = 'Backend/server/Data/fileupload2/$file';
        //     print('image ==> $image');
        //     processInsertMySQL(
        //       name: name,
        //       tag: tag,
        //       description: description,
        //       image: image,
        //     );
        //   },
        // );
        // }
        // // }
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

  Future<Null> upload() async {
    // String name = nameController.text;
    // String tag = tagController.text;
    // String description = descriptionController.text;
    String apiSaveImage =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/savefileImage.php';
    // File? file;

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? user_id = preferences.getString('user_id');
    // print('Picture ==>$user_id ');
    // print('process upload image');
    // print('Picture ==>${file!.path}} ');

    // print('API Save Image ==> $apiSaveImage');
    int i = Random().nextInt(100000);
    String nameImage = '$i.jpg';

    Map<String, dynamic> map = Map();
    map['file'] = await MultipartFile.fromFile(
      file!.path,
      filename: nameImage,
    );
    FormData data = FormData.fromMap(map);
    // print('Data Form ==> ${data}');
    await Dio().post(apiSaveImage, data: data).then((value) {
      print(value);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title:
                    Column(children: [Text(value.data["message"].toString())]),
              ));
      // image = 'Backend/server/Data/fileupload2/$nameImage';
      // print('image ==> $image');
      // processInsertMySQL(
      //   name: name,
      //   tag: tag,
      //   description: description,
      //   image: image,
      // );
    });
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
                                      // if (provider.file == null) return;
                                      // provider.
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
                                          // } else if (file == null) {
                                          //   normalDialog(
                                          //       context,
                                          //       'ไม่สามารถอัพโหลดได้',
                                          //       'กรุณากรอกข้อมูลให้ครบถ้วน');
                                        } else {
                                          // String dirName = 'img1';
                                          // if (topic_id == '1') {
                                          //   dirName = 'Food';
                                          // } else if (topic_id == '2') {
                                          //   dirName = 'Travel';
                                          // } else if (topic_id == '3') {
                                          //   dirName = 'Signboard';
                                          // } else {
                                          //   dirName = 'Senario';
                                          // }
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
