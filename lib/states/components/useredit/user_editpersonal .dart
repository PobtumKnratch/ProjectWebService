import 'package:flutter/material.dart';
import 'package:flutter_project_web_supportandservice/widget/headeruseredit.dart';
import 'package:google_fonts/google_fonts.dart';

class UserEditPersonal extends StatelessWidget {
  // const UserEditPersonal({Key? key}) : super(key: key);
  static const String routeName = '/usereditpersonal';
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
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/picturebackground/usereditpersonal.jpg'),
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(
            //     Colors.black87.withOpacity(0.65), BlendMode.dstATop),
          ),
        ),
        child: ListView(
          children: [
            HeaderBarEdit(_opacity),
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.40
        ? _scrollPosition / (size.height * 0.40)
        : 1;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Container(
            height: size.height * 0.70,
            width: size.width * 0.60,
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'แก้ไขข้อมูลส่วนตัว',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // Container(
                //   width: size.width * 0.20,
                //   child: Form(
                //     key: formKey,
                //     child: Column(
                //       children: [
                // buildFirstname(),
                // buildLastname(),
                // SizedBox(
                //   width: 30,
                // ),
                //       ],
                //     ),
                //   ),
                // ),
                // buildFirstname(),
                // buildFirstname(),
                SizedBox(
                  width: 30,
                ),
                // Container(
                //   width: size.width * 0.20,
                //   child: Form(
                //     key: formKey,
                //     child: Column(
                //       children: [
                //         buildLastname(),
                //         SizedBox(
                //           width: 30,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // buildLastname(),
                // buildLastname(),
                SizedBox(
                  height: 20,
                ),
                buildEmail(),
                buildPhone(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildPhone() {
  return Container();
}

Widget buildEmail() {
  return Container();
}

Widget buildFirstname() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ชื่อของผู้ใช้',
          style: GoogleFonts.kanit(
            textStyle: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            errorStyle: GoogleFonts.kanit(
              textStyle: TextStyle(
                color: Colors.red.shade400,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            labelText: "Enter your password :",
            labelStyle: GoogleFonts.kanit(
              textStyle: TextStyle(fontSize: 18),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
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

Widget buildLastname() {
  return Container(
    child: Column(
      children: [
        Text(
          'นามสกุล',
          style: GoogleFonts.kanit(
            textStyle: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            errorStyle: GoogleFonts.kanit(
              textStyle: TextStyle(
                color: Colors.red.shade400,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            labelText: "Enter your password :",
            labelStyle: GoogleFonts.kanit(
              textStyle: TextStyle(fontSize: 18),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
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
