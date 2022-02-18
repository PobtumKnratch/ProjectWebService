// import 'dart:html';
import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:azblob/azblob.dart';
import 'package:open_file/open_file.dart';
// import 'package:mime/mime.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';
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
  double _scrollPosition = 0;
  double _opacity = 0;
  File? file;
  // Path? path;
  String image = '';
  // String? selectName;
  // ignore: deprecated_member_use
  // List topic = [];
  late String name, tag, description;
  // ImagePicker picker = ImagePicker();
  Provider? provider;
  bool kIsWeb = identical(0, 0.0);
  // late PickedFile file;
  Uint8List webImage = Uint8List(10);

  FilePickerResult? result;
  PlatformFile? platformFile;

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

  Future add(File file) async {
    String name = nameController.text;
    String tag = tagController.text;
    String description = descriptionController.text;
    print(
        '## userid = $user_id, namepicture = $name, tag = $tag, name = $description,');
    print('picture ==> $file');
    String pathUser =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/getuserwhereuser.php?isAdd=true&user_id=$user_id';
    await http.get(Uri.parse(pathUser)).then((value) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? user_id = preferences.getString('user_id');

// ignore: deprecated_member_use
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var uri =
          "http://localhost/flutter_project_web_supportandservice/Backend/server/insert.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=$image";

      String apiSaveImage =
          'http://localhost/flutter_project_web_supportandservice/Backend/server/savefileImage.php?isAdd=true&image=$file';
      print('API Save Image ==> $apiSaveImage');

      var request = new http.MultipartRequest("POST", Uri.parse(uri));

      var multipartFile = new http.MultipartFile.fromBytes(
          apiSaveImage, File.fromUri(Uri.parse(apiSaveImage)).readAsBytesSync(),
          filename: file.path, contentType: new MediaType('image', 'jpeg'));

      // var multipartFile = new http.MultipartFile("image", stream, length,
      //     filename: basename(file.path));

      await http.post(
        Uri.parse(apiSaveImage),
        body: multipartFile,
        encoding: Encoding.getByName("utf-8"),
        headers: {"Content-Type": "multipart/form-data"},
      ).then(
        (value) {
          image = '/Backend/server/Data/fileupload2/$file';
          print('image ==> $image');
          request.files.add(multipartFile);
          // request.fields['name'] = nameController.text;
          // request.fields['tag'] = tagController.text;
          // request.fields['description'] = descriptionController.text;
        },
      );

      var respond = await request.send();
      await http.get(
        Uri.parse(uri),
        headers: {"Content-Type": "multipart/form-data"},
      ).then((value) {
        if (respond.statusCode == 200) {
          print("Image Uploaded");
        } else {
          print("Upload Failed");
        }
      });
    });
  }

  Future ApiaddData(PlatformFile? platformFile
      // {
      // String? name,
      // String? tag,
      // String? description,
      // File? file,
      // }
      ) async {
    String name = nameController.text;
    String tag = tagController.text;
    String description = descriptionController.text;

    if (result != null) platformFile = result!.files.first;

    final fileBytes = result!.files.first.bytes;
    String fileName =
        // basename(file.path!);
        result!.files.first.name;

    final contentType = mimeType != null ? MediaType.parse(mimeType) : null;

    final stream = http.ByteStream.fromBytes(fileBytes!);

    print('Name : ${fileName}');
    print('Bytes : ${fileBytes}');
    print('Size : ${platformFile!.size}');
    print('Extension : ${platformFile.extension}');
    // print('Path : ${platformFile!.path}');

    print('picture ==> ${fileName}');

    print('name : ${name}');
    print('tag : ${tag}');
    print('image_description : ${description}');
    print('file : ${file}');
    print('Topic ID : ${topic_id}');
    print('User ID : ${user_id}');
    // print('Token : ${token}');
    if (topic_id == "1") {
      print('### topic id ==> 1 ##### ');
      print('## name ==> 1 ## : ${name}');
      print('## tag ==> 1 ## : ${tag}');
      print('## image_description ==> 1 ## : ${description}');
      print('## file ==> 1 ## : ${fileName}');
      print('## file ==> 1 ## : ${stream}');

      final urldata = Uri.parse(
          "http://localhost/flutter_project_web_supportandservice/Backend/server/uptravel.php");
      var request = http.MultipartRequest('POST', urldata);
      request.headers['Access-Control-Allow-Origin'] = "*";
      request.headers['Access-Control-Allow-Methods'] = "POST";
      request.headers['Access-Control-Allow-Headers'] = "Content-Type";
      request.fields['name'] = nameController.text;
      request.fields['tag'] = tagController.text;
      request.fields['description'] = descriptionController.text;
      final multipartFile = http.MultipartFile(
        'file',
        stream,
        platformFile.size,
        filename: fileName,
        contentType: contentType,
      );
      request.files.add(multipartFile);

      print('Insert Request : ${request}');
      await request.send().then(
        (response) async {
          print('Rsponse Status Code ==> ${response.statusCode}');
        },
      ).catchError(
        (e) {
          print(e);
        },
      );
    } else if (topic_id == "2") {
      print('topic id ==> 2 : ');
    } else if (topic_id == "3") {
      print('topic id ==> 3 : ');
    } else if (topic_id == "4") {
      print('topic id ==> 4 : ');
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

        if (result != null) platformFile = result!.files.first;

        Uint8List? fileBytes = result!.files.first.bytes;
        String fileName =
            // basename(file.path!);
            result!.files.first.name;
        final contentType = mimeType != null ? MediaType.parse(mimeType) : null;

        final stream = http.ByteStream.fromBytes(fileBytes!);

        print('Name : ${fileName}');
        print('Bytes : ${fileBytes}');
        print('Size : ${platformFile!.size}');
        print('Extension : ${platformFile!.extension}');
        // print('Path : ${platformFile!.path}');

        print('picture ==> ${fileName}');

        //print('# user_id ==> $user_id');
        processInsertMySQL(
          name: name,
          tag: tag,
          description: description,

          // image: image,
          // file: file,
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
        //have image
        print('process upload image');
        print('Picture ==>$file ');
        String apiSaveImage =
            'http://localhost/flutter_project_web_supportandservice/Backend/server/uptravel.php?isAdd=true&image=$stream';
        print('API Save Image ==> $apiSaveImage');
        // int i = Random().nextInt(100000);
        // String nameImage = '$i.jpg';

        Map<String, dynamic> map = Map();
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
        map['file'] = http.MultipartFile(
          'file',
          stream,
          platformFile!.size,
          filename: fileName,
          contentType: contentType,
        );
        // request.files.add(multipartFile);
        FormData data = FormData(map);
        print('Data Form ==> ${data}');
        await http.post(
          Uri.parse(apiSaveImage),
          body: data,
          encoding: Encoding.getByName("utf-8"),
          headers: {"Content-Type": "multipart/form-data"},
        ).then(
          (value) {
            image = 'Backend/server/Data/fileupload2/$file';
            print('image ==> $image');
            processInsertMySQL(
              name: name,
              tag: tag,
              description: description,
              image: image,
            );
          },
        );
        // }
        // }
      },
    );
  }

  Future<Null> processInsertMySQL({
    String? name,
    String? tag,
    String? description,
    String? image,
    // File? file,
  }) async {
    print('processInsertMySQL Work and Image ==> $file');
    String apiInsertData =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/insert.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=$image';
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

  Future upload() async {
    String name = nameController.text;
    String tag = tagController.text;
    String description = descriptionController.text;
    // File? file;
    print(
        '## userid = $user_id, namepicture = $name, tag = $tag, name = $description,');
    print('picture ==> $file');
    String urlupload =
        'http://localhost/flutter_project_web_supportandservice/Backend/server/uploadimage.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=$image';

    // List<int> imageBytes = file!.readAsBytesSync();
    // String baseimage = base64Encode(imageBytes);
    //convert file image to Base64 encoding
    var response = await http.post(
      Uri.parse(urlupload),
      body: {
        'image': file.toString(),
      },
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body); //decode json data
      if (jsondata["error"]) {
        //check error sent from server
        print(jsondata["msg"]);
        //if error return from server, show message from server
      } else {
        print("Upload successful");
      }
    } else {
      print("Error during connection to server");
      //there is error during connecting to server,
      //status code might be 404 = url not found
    }
  }

  // Future uploadImage() async {
  //   String name = nameController.text;
  //   String tag = tagController.text;
  //   String description = descriptionController.text;
  //   print(
  //       '## userid = $user_id, namepicture = $name, tag = $tag, name = $description,');
  //   print('picture ==> $file');
  //   // try {
  //   String apiInsertData =
  //       'http://localhost/flutter_project_web_supportandservice/Backend/server/insert.php?isAdd=true&user_id=$user_id&name=$name&tag=$tag&description=$description&image=$image';
  //   String fileName = basename(file!.path);
  //   // read file as Uint8List
  //   Uint8List content = await file!.readAsBytes();
  //   var request = new http.MultipartRequest("POST", Uri.parse(apiInsertData));
  //   request.headers['X-MS-BLOB-TYPE'] = 'BlockBlob';
  //   request.headers['Content-Type'] = 'image/jpeg';
  //   request.files.add(
  //     new http.MultipartFile.fromBytes(
  //       'file',
  //       await file!.readAsBytes(),
  //     ),
  //   );
  //   request.send().then(
  //     (response) {
  //       // request.add(response.statusCode);
  //     },
  //     onError: (err) {
  //       print(err);
  //     },
  //   );
  // }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  Future pickerimage() async {
    //  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    //   if (result == null) return;
    //   file = result.files.first;
    //   setState(() {});
    // try {
    // final PickedFile? myfile = await ImagePicker().getImage(
    //   source: source,
    //   maxHeight: 50.0,
    //   maxWidth: 50.0,
    // );
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
      allowMultiple: true,
      withReadStream: false,
      lockParentWindow: true,
    );

    if (result != null) {
      platformFile = result!.files.first;
      // openFile(file);
      Uint8List? fileBytes = result!.files.first.bytes;
      String fileName =
          // basename(file.path!);
          result!.files.first.name;

    //   print('Name:${fileName}');
    //   print('Bytes:${fileBytes}');
    //   print('Size:${platformFile!.size}');
    //   print('Extension:${platformFile!.extension}');
      // print('Path:${platformFile!.path}');
      // uploadImageAndInsertData(platformFile);
      // final newFile = await saveFilePermanently(file);
      // print('From Path : ${file.path}');
      // print('To Path : ${newFile.path}');
    }
    // setState(
    //   () {
    //     // if (myfile != null) {
    //     file = File(myfile!.path);
    //     // file = Image.network(myfile!.path) as File?;
    //     // String filename = basename(myfile.path);
    //     // uploadFile(filename, image);
    //     print('Selected image = $file');
    //     // } else {
    //     //   print('No image selected.');
    //     // }
    //   },
    // );
    // } catch (e) {}
    //  });
  }

  // Future pickerimage(ImageSource imageSource) async {
  // FilePickerResult? result = await FilePicker.platform.pickFiles(
  //   type: FileType.image,
  //   withData: true,
  //   allowMultiple: true,
  //   withReadStream: false,
  //   lockParentWindow: true,
  // );
  // ignore: deprecated_member_use
    // final PickedFile? myfile = await ImagePicker().getImage(
    //   source: imageSource,
    //   maxHeight: 50.0,
    //   maxWidth: 50.0,
    // );
  //   // if (result != null) {
  //   //   PlatformFile _file = result.files.first;
  //   //   // openFile(file);
  //   //   Uint8List? fileBytes = result.files.first.bytes;
  //   //   String fileName =
  //   //       // basename(file.path!);
  //   //       result.files.first.name;

  //   //   print('Name:${fileName}');
  //   //   print('Bytes:${fileBytes}');
  //   //   print('Size:${_file.size}');
  //   //   print('Extension:${_file.extension}');
  //   //   // print('Path:${file!.path}');
  //   //   // final newFile = await saveFilePermanently(file);
  //   //   // print('From Path : ${file.path}');
  //   //   // print('To Path : ${newFile.path}');
  //   // }
  //   setState(
  //     () {
  //       if (myfile != null) {
  //         file = File(myfile.path);
  //         print('Selected image = $file');
  //         // String filename = basename(myfile.path);
  //         // uploadFile(filename, image);
  //       } else {
  //         print('No image selected.');
  //       }
  //     },
  //   );
  // }

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
                      // child: Image.network(file!.path),
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
                              // if (file != null) fileDetails(file!),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // if (file != null)
                                  MaterialButton(
                                    onPressed: () async {
                                      // FilePickerResult? result =
                                      //     await FilePicker.platform.pickFiles(
                                      //   type: FileType.image,
                                      //   withData: true,
                                      //   allowMultiple: true,
                                      //   withReadStream: true,
                                      //   lockParentWindow: true,
                                      // );

                                      // if (result != null) {
                                      //   PlatformFile file = result.files.first;
                                      //   // openFile(file);
                                      //   Uint8List? fileBytes =
                                      //       result.files.first.bytes;
                                      //   String fileName =
                                      //       // basename(file.path!);
                                      //       result.files.first.name;

                                      //   print('Name:${fileName}');
                                      //   print('Bytes:${fileBytes}');
                                      //   print('Size:${file.size}');
                                      //   print('Extension:${file.extension}');
                                      //   // print('Path:${file.path}');

                                      //   final newFile =
                                      //       await saveFilePermanently(file);
                                      //   // print('From Path : ${file.path}');
                                      //   print('To Path : ${newFile.path}');
                                      // }
                                      // pickerimage(ImageSource.gallery);
                                      pickerimage();
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
                                        if (name == null ||
                                                name.isEmpty ||
                                                // ignore: unnecessary_null_comparison
                                                tag == null ||
                                                tag.isEmpty ||
                                                description == null ||
                                                description.isEmpty
                                            // file == null ||
                                            // file!.isAbsolute
                                            ) {
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
                                          ApiaddData(platformFile);
                                          // uploadImageAndInsertData(
                                          //     platformFile);
                                          // add(file!);
                                          // upload();
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

  Widget fileDetails(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('File Name: ${file.name}'),
          Text('File Size: $size'),
          Text('File Extension: ${file.extension}'),
          Text('File Path: ${file.path}'),
        ],
      ),
    );
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = '/Backend/server/Data/fileupload2/';
    // ignore: unnecessary_brace_in_string_interps
    final newFile = File('${appStorage}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }

  // void openFiles(PlatformFile files)=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>));
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
              controller: descriptionController, autocorrect: true,
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
              controller: nameController, autocorrect: true,
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
