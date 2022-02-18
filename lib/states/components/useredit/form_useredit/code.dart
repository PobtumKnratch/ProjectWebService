      // 1 ######
      // var stream = new http.ByteStream(image!.openRead());
      // stream.cast();

      // var length = await image.length();

      // var urldata = Uri.parse(
      //     "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insert.php");

      // var request = new http.MultipartRequest('POST', urldata);
      // request.fields['namepicture'] = namepictureController.text;
      // request.fields['tag'] = tagController.text;
      // request.fields['image_description'] = image_descriptionController.text;

      // var multiport = new http.MultipartFile('image', stream, length);
      // request.files.add(multiport);

      // var response = await request.send();
      // print(response.stream.toString());
      // if (response.statusCode == 200) {
      //   print('image upload');
      // } else {
      //   print('failed');
      // }

      // 2 ######
      // var urldata = Uri.parse(
      // "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insertdata.php");
      // // final mineTypeData = lookupM

      // final imageUploadRequest = http.MultipartRequest('POST', urldata);
      //    final urlPathImage =
      //     '/flutter_project_web_supportandservice/Backend/server/Data/fileupload2/$image';

      // final file = new http.MultipartFile.fromBytes(
      //     'file', await File.fromUri(Uri.parse(urlPathImage)).readAsBytesSync(),
      //     filename: image!.path.split("/").last,
      //     contentType: new MediaType('image', 'jpeg'));

      // imageUploadRequest.files.add(file);
      // imageUploadRequest.fields['namepicture'] = namepicture.toString();
      // imageUploadRequest.fields['tag'] = tag.toString();
      // imageUploadRequest.fields['image_description'] =
      //     image_description.toString();

      // final Streamresponse = await imageUploadRequest.send();
      // final response = await http.Response.fromStream(Streamresponse);
      // if (response.statusCode != 200) {
      //   return null;
      // }
      // final Map<String, dynamic> responseData = json.decode(response.body);
      // return responseData;


      // 3 ######
      // final urldata = Uri.parse(
      //     "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insertdata.php");
      // String? filename = image!.path.split("/").last;

      // Map<String, dynamic> requestHeader = {
      //   'Content-Type': 'image/jpeg',
      //   'Content-Desposition': 'attachment: filename=$filename',
      // };
      // List<int> imageBytes = File(image.path).readAsBytesSync();

      // var request = http.Request('POST', urldata);
      // request.bodyFields['namepicture'] = namepictureController.text;
      // request.bodyFields['tag'] = tagController.text;
      // request.bodyFields['image_description'] =
      //     image_descriptionController.text;
      // request.bodyBytes = imageBytes;

      // var res = await request.send();
      // print('Insert Request : ${res}');



      // 4 ######
      // Random random = Random();
      // int i = Random().nextInt(10000000);
      // String nameFile = '$i.jpg';
      // final urlPathImage =
      //     '/flutter_project_web_supportandservice/Backend/server/Data/fileupload2/$image';
      // print('urlPathImage = ${urlPathImage}');
      // final urldata = Uri.parse(
      //     "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insertdata.php");
      // var request = new http.MultipartRequest('POST', urldata);
      // request.fields['namepicture'] = namepictureController.text;
      // request.fields['tag'] = tagController.text;
      // request.fields['image_description'] = image_descriptionController.text;
      // request.files.add(new http.MultipartFile.fromBytes(
      //     'file', await File.fromUri(Uri.parse(urlPathImage)).readAsBytesSync(),
      //     filename: image!.path.split("/").last,
      //     contentType: new MediaType('image', 'jpeg')));
      // var response = await request.send();
      // print('Insert Request : ${request}');
      // request.send().then(
      //   (response) {
      //     if (response.statusCode == 200) {
      //       print("Uploaded!");
      //     } else {
      //       print('Image Not Upload');
      //     }
      //   },
      // );


      // 5 ######
      // String urlUpload =
      //     'http://localhost/flutter_project_web_supportandservice/Backend/server/api_insert_pic.php';
      // Random random = Random();
      // int i = Random().nextInt(10000000);
      // String nameFile = '$i.jpg';

      // // try {
      // Map<String, dynamic> mapimg = Map();
      // mapimg['flie'] = await http.MultipartFile.fromPath('image', file!.path,
      //     filename: nameFile, contentType: new MediaType('image', 'jpeg'));
      // FormData form = FormData(mapimg);

      // await http.post(Uri.parse(urlUpload), body: form).then(
      //   (value) async {
      //     final urlPathImage =
      //         '/flutter_project_web_supportandservice/Backend/server/Data/fileupload2/$file';
      //     print('urlPathImage = ${urlPathImage}');

      //     SharedPreferences preferences = await SharedPreferences.getInstance();
      //     String? user_id = preferences.getString('user_id');

      //     String urlInsert =
      //         'http://localhost/flutter_project_web_supportandservice/Backend/server/api_insertdata.php?isAdd=true&user_id=$user_id&namepicture=$namepicture&image_description=$image_description&tag=$tag&image=$urlPathImage';
      //     await http
      //         .get(Uri.parse(urlInsert))
      //         .then((value) => Navigator.pop(context));
      //   },
      // );
      // } catch (e) {}

      // Uint8List responseData = await response.stream.toBytes();

      // if (response.statusCode == 200) {
      //   print('Image Upload');
      // } else {
      // print('Image Not Upload');
      // }



      // 6 ######

      // final urlupload = Uri.parse(
  //     "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insert_pic.php");
  //Random random = Random();
  // int i = Random().nextInt(100000);
  // String nameFile = 'name$i.jpg';
  // Map<String, dynamic> map = Map();
  // map['file'] = await http.MultipartFile.fromPath(file!.path,nameFile ,filename: nameFile);
  // FormData formData = FormData(map);
  // await http.post(Uri.parse(urlupload), body: {
  //   'namepicture': '$namepicture',
  //   'tag' : '$tag',
  //   'image_description': '$image_description',
  // }).then(
  //   (value) {
  // String urlPathImage = '/Backend/server/Data/fileupload2/$nameFile';
  //     print('urlPathImage = ${urlPathImage}');
  //   },
  // );


  // 7 ######
  // var apiurl = Uri.parse(
  //     "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insertdata.php");
  // final request = new http.MultipartRequest('POST', apiurl);
  // request.files.add(await http.MultipartFile.fromPath(nameFile, file.path));
  // // var pic = await http.MultipartFile.fromPath(file.path, nameFile);
  // // request.headers.addAll({'Authorization': '${token}'});
  // request.fields['userid'] = useridController.text;
  // request.fields['Authorization'] = "";
  // request.fields['namepicture'] = namepictureController.text;
  // request.fields['tag'] = tagController.text;
  // request.fields['image_description'] = image_descriptionController.text;
  // // var pic = await http.MultipartFile.fromPath(file.path, nameFile);
  // // print('Picture ${pic}');
  // // request.files.add(pic);
  // var response = await request.send();
  // print('Response : ${response}');

  // Uint8List responseData = await response.stream.toBytes();
  // if (response.statusCode == 200) {
  //   print('Image Upload');
  // } else {
  //   print('Image Not Upload');
  // }


  // 8 ######

  //   var apiurl = Uri.parse(
  //       "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insert.php");
  //   final request = http.MultipartRequest('POST', apiurl);
  //   request.fields['userid'] = useridController.text;
  //   request.fields['Authorization'] = "";
  //   request.fields['namepicture'] = namepictureController.text;
  //   request.fields['tag'] = tagController.text;
  //   request.fields['image_description'] = image_descriptionController.text;
  //   var pic = await http.MultipartFile.fromPath("imagepic", file!.path);
  //   request.files.add(pic);
  //   var response = await request.send();

  //   var responseData = await response.stream.toBytes();

  //   if (response.statusCode == 200) {
  //     print('Image Upload');

  //   } else {
  //     print('Image Not Upload');
  //   }

  // @override
  // void initState() {
  //   super.initState();
  //   topicdata();
  // }

  // Future topicdata() async {
  //   var url =
  //       "http://localhost/flutter_project_web_supportandservice/Backend/server/Data/ShowData/topic.php";
  //   var response = await http.get(Uri.parse(url), headers: {
  //     'Accept': 'application/json',
  //   });
  //   // print(response);
  //   if (response.statusCode == 200) {
  //     var jsonData = json.decode(response.body);
  //     setState(() {
  //       topic = jsonData;
  //     });
  //     print(topic);
  //   }
  // }


  // 8 ######

  // ignore: non_constant_identifier_names
  // Future ApiaddDataPic() async {
  //   String bytes = base64Encode(image!.readAsBytesSync());
  //   var apiurl =
  //       "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insert.php";

  //   http.Response response = await http.post(
  //     Uri.parse(apiurl),
  //     body: jsonEncode(
  //       <String, String>{
  //         "userid": useridController.text,
  //         "namepicture": namepicture.toString(),
  //         "tag": tag.toString(),
  //         "image_description": image_description.toString(),
  //         'file': bytes,
  //       },
  //     ),
  //   );
  //   print(response.body);
  //   // var data = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     print('Image Upload');
  //   } else {
  //     print('Image Not Upload');
  //   }
  // }

  // 9 #####
  // var stream =
  //         new http.ByteStream(DelegatingStream.typed(image!.openRead()));
  //     stream.cast();

  //     var length = await image.length();

  //     var urldata = Uri.parse(
  //         "http://localhost/flutter_project_web_supportandservice/Backend/server/insert.php");

  //     var request = new http.MultipartRequest('POST', urldata);
  //     request.fields['namepicture'] = namepictureController.text;
  //     request.fields['tag'] = tagController.text;
  //     request.fields['image_description'] = image_descriptionController.text;

  //     var multiport = new http.MultipartFile('image', stream, length,
  //         filename: basename(image.path));
  //     request.files.add(multiport);

  //     var response = await request.send();
  //     print(response.stream.toString());

  //  10 ###

  // var stream =
  //         new http.ByteStream(DelegatingStream.typed(image!.openRead()));
  //     // get file length
  //     var length = await image.length(); //imageFile is your image file
  //     Map<String, String> headers = {
  //       "Accept": "application/json",
  //       "Authorization": "Bearer  $token"
  //     }; // ignore this headers if there is no authentication

  //     // string to uri
  //     var urldata = Uri.parse(
  //         "http://localhost/flutter_project_web_supportandservice/Backend/server/insert.php");

  //     // create multipart request
  //     var request = new http.MultipartRequest("POST", urldata);

  //     // multipart that takes file
  //     var multipartFileSign = new http.MultipartFile('image', stream, length,
  //         filename: basename(image.path));

  //     // add file to multipart
  //     request.files.add(multipartFileSign);

  //     //add headers
  //     request.headers.addAll(headers);

  //     //adding params

  //     request.fields['namepicture'] = namepictureController.text;
  //     request.fields['tag'] = tagController.text;
  //     request.fields['image_description'] = image_descriptionController.text;

  //     // send
  //     var response = await request.send();

  //     print(response.statusCode);

  //     // listen for response
  //     response.stream.transform(utf8.decoder).listen((value) {
  //       print(value);
  //     });

  // 11 ###
   // Random random = Random();
      // int i = random.nextInt(100000);
      // String? nameImage = '$i.jpg';

      // String url =
      //     'http://localhost/flutter_project_web_supportandservice/Backend/server/savefileImage.php?isAdd=true&image=$image';

      // String apiInsertData =
      //     'http://localhost/flutter_project_web_supportandservice/Backend/server/insert.php?isAdd=true&user_id=$user_id&namepicture=$namepicture&tag=$tag&image_description=$image_description&image=$image';

      // // try {
      //   var request =
      //       new http.MultipartRequest('POST', Uri.parse(apiInsertData));
      //   request.fields['namepicture'] = namepicture;
      //   request.fields['tag'] = tag;
      //   request.fields['image_description'] = image_description;
      //   request.files.add(new http.MultipartFile.fromBytes(
      //       file!.path, File.fromUri(Uri.parse(url)).readAsBytesSync(),
      //       filename: file.path.split("/").last,
      //       contentType: new MediaType('image', 'jpeg')));
      //   var response = await request.send();
      //   print('Insert Request : ${request}');
      //   request.send().then(
      //     (response) {
      //       if (response.statusCode == 200) {
      //         print("Uploaded!");
      //       } else {
      //         print('Image Not Upload');
      //       }
      //     },
      //   );
      // } catch (e) {}

      // String uploadurl =
      //     "http://localhost/flutter_project_web_supportandservice/Backend/server/uploadimage.php";
      // //dont use http://localhost , because emulator don't get that address
      // //insted use your local IP address or use live URL
      // //hit "ipconfig" in windows or "ip a" in linux to get you local IP

      // try {
      //   Uint8List imageBytes = file!.readAsBytesSync();
      //   String baseimage = base64Encode(imageBytes);
      //   //convert file image to Base64 encoding
      //   var response = await http.post(Uri.parse(uploadurl), body: {
      //     'namepicture': namepicture,
      //     'tag': tag,
      //     'image_description': image_description,
      //     'image': baseimage,
      //   });
      //   if (response.statusCode == 200) {
      //     var jsondata = json.decode(response.body); //decode json data
      //     if (jsondata["error"]) {
      //       //check error sent from server
      //       print(jsondata["msg"]);
      //       //if error return from server, show message from server
      //     } else {
      //       print("Upload successful");
      //     }
      //   } else {
      //     print("Error during connection to server");
      //     //there is error during connecting to server,
      //     //status code might be 404 = url not found
      //   }
      // } catch (e) {
      //   print("Error during converting to Base64");
      //   //there is error during converting file image to base64 encoding.
      // }

// 10###
// if (response.statusCode == 200)
      // } );
      // var request = http.MultipartRequest('POST', urldata);
      // //Header....
      // request.headers['Authorization'] = 'bearer $token';

      // request.fields['namepicture'] = namepicture.toString();
      // request.fields['tag'] = tag.toString();
      // request.fields['image_description'] = image_description.toString();
      // request.files.add(http.MultipartFile.fromBytes(
      //   image,
      //   await File.fromUri(Uri.parse(image)).readAsBytesSync(),
      //   filename: nameFile,
      //   contentType: MediaType("image", "jpg"),
      // ));
      // var response = await request.send();
      // print(response.stream);
      // print(response.statusCode);
      // final res = await http.Response.fromStream(response);
      // print(res.body);
      // if (response.statusCode == 200) {
      //   print('image upload');
      // } else {
      //   print('failed');
      // }