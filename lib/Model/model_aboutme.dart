import 'package:flutter/material.dart';

class Aboutme {
  final int id;
  final String title, image;
  final Color color;

 

  Aboutme(
      {required this.id,
      required this.title,
      required this.image,
      required this.color, });
}

// For demo list of service
List<Aboutme> aboutme = [
  Aboutme(
    id: 1,
    title: "สามารถทำการค้นหาสถานที่ท่องเที่ยว",
    image: "images/pictureicon/searchdata.png",
    color: Color(0xFFD9FFFC),
  ),
  Aboutme(
    id: 2,
    title: "สามารถดูข้อมูลจากคลังข้อมูลรูปภาพ",
    image: "images/pictureicon/location.png",
    color: Color(0xFFE4FFC7),
  ),
  Aboutme(
    id: 3,
    title: "สามารถเข้าสู่ระบบผู้ใช้งานเพื่อทำการ\nจัดการข้อมูลคลังรูปภาพ",
    image: "images/pictureicon/usereditor.png",
    color: Color(0xFFFFF3DD),
  ),
  Aboutme(
    id: 4,
    title: "สามารถตรวจสอบข้อมูลรูปภาพ\nได้จากการเข้าสู่ระบบ",
    image: "images/pictureicon/anno.png",
    color: Color(0xFFFFE0E0),
  ),
];
