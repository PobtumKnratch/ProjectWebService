// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchView extends StatelessWidget {
  void Function(String) onChanged;
  bool showBtnSearch = false;

  SearchView({Key? key, required this.onChanged, required this.showBtnSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var formKey;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 450,
          // height: size.height * 0.05,
          child: TextFormField(
              style: GoogleFonts.kanit(
                textStyle: TextStyle(fontSize: 14),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณากรอกข้อมูลสำหรับค้นหา';
                }
              },
              decoration: InputDecoration(
                errorStyle: TextStyle(
                    color: Colors.red.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                prefixIcon: Icon(Icons.search, size: 16),
                hintText: 'โปรดระบุข้อมูลที่ต้องการสืบค้น',
                hintStyle: GoogleFonts.kanit(
                  textStyle: TextStyle(fontSize: 14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black54, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black54, width: 1),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: this.onChanged),
        ),
      ],
    );
  }
}
