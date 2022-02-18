import 'dart:convert';
import 'dart:html' as html;
// import 'dart:html';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mime_type/mime_type.dart';
// import 'package:path/path.dart' as Path;
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:universal_html/html.dart' as html;
// import 'package:provider/provider.dart';

class Insert extends StatefulWidget {
  const Insert({Key? key}) : super(key: key);
  static const String routeName = '/insert';

  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  html.File? file;
  // late html.File _cloudFile;
  // var _fileBytes;
  // late Image _imageWidget;
  // Uint8List? uploadedImage;
  String? image;
  Uint8List? byte;

  void _pickImage() async {
    html.File imageFile =
        ImagePickerWeb.getImage(outputType: ImageType.file) as html.File;
    if (imageFile != null) {
      debugPrint(imageFile.name.toString());
      setState(() {
        file = imageFile;
        image = imageFile.name.toString();
      });
      loadImage(file);
    }
  }

  void loadImage(html.File? file) {
    final reader = html.FileReader();
    reader.readAsDataUrl(file!);
    reader.onLoadEnd.listen((event) {
      var bytedata = const Base64Decoder()
          .convert(reader.result.toString().split(",").last);
      setState(() {
        byte = bytedata;
      });
    });
  }

  // _startFilePicker() async {
  //   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  //   uploadInput.multiple = true;
  //   uploadInput.draggable = true;
  //   uploadInput.click();

  //   uploadInput.onChange.listen((e) {
  //     // read file content as dataURL
  //     final files = uploadInput.files;
  //     if (files!.length == 1) {
  //       final file = files[0];
  //       html.FileReader reader = html.FileReader();

  //       reader.onLoadEnd.listen((e) {
  //         setState(() {
  //           uploadedImage = reader.result as Uint8List?;
  //         });
  //       });

  //       reader.readAsArrayBuffer(file);
  //     }
  //   });
  // }

  // _saveImage() async {
  //   html.File file = await FilePicker.getFile();

  //   if (file != null) {
  //     Uri uri = Uri.parse('$url/xxx--xxx/images/');
  //     var request = http.MultipartRequest('POST', uri);
  //     request.headers["<custom header>"] = "content";
  //     request.fields['custom test field'] = "<your text field>";
  //     request.files.add(http.MultipartFile.fromBytes(
  //         'image', (await _getHtmlFileContent(file)),
  //         filename: file.name));
  //     var resq = await request.send();
  //     print('Request => $resq');
  //   }
  // }

  // Future<Uint8List> _getHtmlFileContent(html.File blob) async {
  //   Uint8List file;
  //   final reader = html.FileReader();
  //   reader.readAsDataUrl(blob.slice(0, blob.size, blob.type));
  //   reader.onLoadEnd.listen((event) {
  //     Uint8List data =
  //         Base64Decoder().convert(reader.result.toString().split(",").last);
  //     file = data;
  //   }).onData((data) {
  //     file = Base64Decoder().convert(reader.result.toString().split(",").last);
  //     return file;
  //   });
  //   while (file == null) {
  //     await new Future.delayed(const Duration(milliseconds: 1));
  //     if (file != null) {
  //       break;
  //     }
  //   }
  //   return file;
  // }
  // html.File? imageFile = (ImagePickerWeb.getMultiImagesAsFile()) as html.File?;
  // List<html.File>? imageFiles =
  //     ImagePickerWeb.getMultiImagesAsFile() as List<html.File>?;

  // Future<void> getMultipleImageInfos() async {
  //   var mediaData = await ImagePickerWeb.getImageInfo;
  //   String? mimeType = mime(Path.basename(mediaData.fileName));
  //   html.File mediaFile =
  //       new html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

  //   if (mediaFile != null) {
  //     setState(() {
  //       _cloudFile = mediaFile;
  //       _fileBytes = mediaData.data;
  //       _imageWidget = Image.memory(mediaData.data);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   body: ChangeNotifierProvider<MyProvider>(
        //     create: (context) => MyProvider(),
        //     child: Consumer<MyProvider>(
        //       builder: (context, provider, child) {
        //         return Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             if (provider.image != null)
        //               Image.network(
        //                 provider.image.path,
        //                 height: 300,
        //                 width: 300,
        //               ),
        //             MaterialButton(
        //               onPressed: () async {
        //                 PickedFile? image = await ImagePicker()
        //                     .getImage(source: ImageSource.gallery);
        //                 provider.setImage(image);
        //               },
        //               child: Text('get image'),
        //             ),
        //             MaterialButton(
        //               onPressed: () {
        //                 if (provider.image == null) return;
        //                 provider.makePostRequest();
        //               },
        //               child: Text('make post request..'),
        //               color: Colors.redAccent,
        //               textColor: Colors.white,
        //             )
        //           ],
        //         );
        //       },
        //     ),
        //   ),
        // );
        //     Scaffold(
        //   body: Column(
        //     children: [
        //       file == null
        //           ? Placeholder(
        //               fallbackHeight: 200,
        //               fallbackWidth: 400,
        //             )
        //           : Image.network(file!.name),
        //       SizedBox(
        //         height: 30,
        //       ),
        //       RaisedButton(
        //         onPressed: () => _saveImage(),
        //         color: Colors.green,
        //         child: Text('Upload'),
        //       )
        //     ],
        //   ),
        // );
        Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 650, top: 200, right: 650, bottom: 200),
        children: [
          byte == null
              ? InkWell(
                  onTap: () {
                    _pickImage();
                  },
                  child: Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text('Add Image'),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black12,
                  child: Image.memory(
                    byte!,
                    fit: BoxFit.cover,
                  )),
        ],
      ),
    );
  }
}

class MyProvider extends ChangeNotifier {
  var image;
  Future setImage(img) async {
    this.image = img;
    this.notifyListeners();
  }

  Future makePostRequest() async {
    // print(image);
    String url =
        "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insertdata.php";
    var headers = {};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    // request.headers.addAll(headers);
    Uint8List data = await this.image.readAsBytes();
    List<int> list = data.cast();
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        list,
        filename: image,
      ),
    );
    var response = await request.send();

    response.stream.bytesToString().asStream().listen(
      (event) {
        var parsedJson = json.decode(event);
        print(parsedJson);
        print(response.statusCode);
      },
    );
  }
}

// class FileUploadWithHttp extends StatefulWidget {
//   @override
//   _FileUploadWithHttpState createState() => _FileUploadWithHttpState();
// }

// class _FileUploadWithHttpState extends State<FileUploadWithHttp> {
//   PlatformFile? objFile = null;

//   void chooseFileUsingFilePicker() async {
//     //-----pick file by file picker,

//     var result = await FilePicker.platform.pickFiles(
//       withReadStream:
//           true, // this will return PlatformFile object with read stream
//     );
//     if (result != null) {
//       setState(() {
//         objFile = result.files.single;
//       });
//     }
//   }

//   void uploadSelectedFile() async {
//     //---Create http package multipart request object
//     final request = http.MultipartRequest(
//       "POST",
//       Uri.parse("Your API URL"),
//     );
//     //-----add other fields if needed
//     request.fields["id"] = "abc";

//     //-----add selected file with request
//     request.files.add(new http.MultipartFile(
//         "Your parameter name on server side", objFile.readStream, objFile!.size,
//         filename: objFile!.name));

//     //-------Send request
//     var resp = await request.send();

//     //------Read response
//     String result = await resp.stream.bytesToString();

//     //-------Your response
//     print(result);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           //------Button to choose file using file picker plugin
//           RaisedButton(
//               child: Text("Choose File"),
//               onPressed: () => chooseFileUsingFilePicker()),
//           //------Show file name when file is selected
//           if (objFile != null) Text("File name : ${objFile!.name}"),
//           //------Show file size when file is selected
//           if (objFile != null) Text("File size : ${objFile!.size} bytes"),
//           //------Show upload utton when file is selected
//           RaisedButton(
//               child: Text("Upload"), onPressed: () => uploadSelectedFile()),
//         ],
//       ),
//     );
//   }
// }
