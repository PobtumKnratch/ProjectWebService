import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/widget/draweruseredit.dart';
import 'package:flutter_project_web_supportandservice/widget/headeruseredit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

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
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formKey = GlobalKey<FormState>();
  double _scrollPosition = 0;
  double _opacity = 0;
  File? file;
  String image = '';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController useridController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController image_tagController = TextEditingController();
  TextEditingController image_descriptionController = TextEditingController();

  // Future ApiaddData() async {
  //   var apiurl =
  //       "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insert.php";

  //   http.Response response = await http.post(
  //     Uri.parse(apiurl),
  //     body: jsonEncode(
  //       <String, String>{
  //         "userid": useridController.text,
  //         "name": nameController.text,
  //         "tag": image_tagController.text,
  //         "description": image_descriptionController.text,
  //       },
  //     ),
  //   );
  //   print(response.body);
  //   var data = jsonDecode(response.body);
  // }

  Future ApiaddData() async {
    var apiurl = Uri.parse(
        "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insert.php");
    final request = http.MultipartRequest('POST', apiurl);
    request.fields['userid'] = useridController.text;
    request.fields['name'] = nameController.text;
    request.fields['image_tag'] = image_tagController.text;
    request.fields['image_description'] = image_descriptionController.text;
    // request.fields['name'] = nameController.text;
    var pic = await http.MultipartFile.fromPath("image", file!.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Upload');
    } else {
      print('Image Not Upload');
    }

    // http.Response response = await http.post(
    //   Uri.parse(apiurl),
    //   body: jsonEncode(
    //     <String, String>{
    //       "userid": useridController.text,
    //       "name": nameController.text,
    //       "tag": image_tagController.text,
    //       "description": image_descriptionController.text,
    //     },
    //   ),
    // );
    // print(response.body);
    // var data = jsonDecode(response.body);
  }

  Future ApiaddDataPic() async {
    var apiurl =
        "http://localhost/flutter_project_web_supportandservice/Backend/server/api_insert_pic.php";

    http.Response response = await http.post(
      Uri.parse(apiurl),
      body: jsonEncode(
        <String, String>{
          "userid": useridController.text,
          "name": nameController.text,
          "tag": image_tagController.text,
          "description": image_descriptionController.text,
          'file': image,
        },
      ),
    );
    print(response.body);
    var data = jsonDecode(response.body);
  }

  Future<void> pickerimage(ImageSource imageSource) async {
    try {
      var myfile = await ImagePicker().getImage(
        source: imageSource,
        maxHeight: 50.0,
        maxWidth: 50.0,
      );
      setState(() {
        file = File(myfile!.path);
      });
    } catch (e) {}
  }

  Widget showImage() {
    double size = MediaQuery.of(context).size.height * 0.4;
    return Container(
      // color: Colors.blueAccent.shade200,
      // width: MediaQuery.of(context).size.width * 0.4,
      // height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              // left: 30,
              top: 7,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.5,
              // width: 600,
              // height: size*0.4,
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
                      // width: 500,
                      // height: size*0.4,
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
                  key: formKey,
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
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              buildFirstname(context),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              buildLastname(context),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              buildDescription(context),
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
                                    onPressed: () {
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
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        ApiaddData();
                                        Navigator.pop(context);
                                      } else {
                                        print(errorPropertyTextConfiguration);
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

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [

              //   ],
              // ),
            ],
          ),
        ),
      ),
      // Container(
      //   height: size.height * 0.80,
      //   width: size.width * 0.90,
      //   decoration: BoxDecoration(
      //     color: Colors.white60,
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       SizedBox(
      //         height: 30,
      //       ),
      //       Center(
      //         child: Text(
      //           'เพิ่มข้อมูลรูปภาพ',
      //           style: GoogleFonts.mali(
      //             textStyle: TextStyle(
      //               color: Colors.black,
      //               fontSize: 24,
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 30,
      //       ),
      //       buildFirstname(),
      //       buildLastname(),
      //       // Row(
      //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       //   crossAxisAlignment: CrossAxisAlignment.start,
      //       //   children: [
      //       //     // buildFirstname(),
      //       //     // buildLastname(),
      //       //   ],
      //       // ),
      //       // Container(
      //       //   width: size.width * 0.20,
      //       //   child: Form(
      //       //     key: formKey,
      //       //     child: Column(
      //       //       children: [
      //       // buildFirstname(),
      //       // buildLastname(),
      //       // SizedBox(
      //       //   width: 30,
      //       // ),
      //       //       ],
      //       //     ),
      //       //   ),
      //       // ),
      //       // buildFirstname(),
      //       // buildFirstname(),
      //       SizedBox(
      //         width: 30,
      //       ),
      //       // Container(
      //       //   width: size.width * 0.20,
      //       //   child: Form(
      //       //     key: formKey,
      //       //     child: Column(
      //       //       children: [
      //       //         buildLastname(),
      //       //         SizedBox(
      //       //           width: 30,
      //       //         ),
      //       //       ],
      //       //     ),
      //       //   ),
      //       // ),
      //       // buildLastname(),
      //       // buildLastname(),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       buildEmail(),
      //       buildPhone(),
      //     ],
      //   ),
      // ),
    );
  }

  Widget buildPhone() {
    return Container();
  }

  Widget buildDescription(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.28,
      // height: size.height * 0.1,
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
            controller: image_descriptionController,
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
    );
  }

  Widget buildFirstname(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
            controller: nameController,
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
    );
  }

  Widget buildLastname(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
            controller: image_tagController,
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
    );
  }
}
