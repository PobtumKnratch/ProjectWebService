import 'dart:html';

import 'package:flutter/material.dart';

class RectanglePage extends StatefulWidget {
  const RectanglePage({Key? key}) : super(key: key);
  static const String routeName = '/rectangle';

  @override
  _RectanglePageState createState() => _RectanglePageState();
}

class _RectanglePageState extends State<RectanglePage> {
  Offset pos = Offset(0, 0);
  List<Offset> listPos = <Offset>[];
  String mode = 'Line';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            RenderBox? box = context.findRenderObject() as RenderBox?;
            pos = box!.globalToLocal(details.globalPosition);

            listPos = List.from(listPos)..add(pos);
          });
        },
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox? box = context.findRenderObject() as RenderBox?;
            pos = box!.globalToLocal(details.globalPosition);

            listPos = List.from(listPos)..add(pos);
          });
        },
        onPanEnd: (DragEndDetails details) => setState(() {
          if (mode == "Line")
            listPos = [
              listPos.lastWhere((element) => true),
              listPos.firstWhere((element) => true),
            ];
        }),
        child: CustomPaint(
          painter: RectanglePainter(listPos),
          child: Container(),
        ),
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {
  RectanglePainter(this.listPost);
  final List<Offset> listPost;
  // Coordinates[] coordinates = new Coordinates[10];
  
  @override
  void paint(Canvas canvas, Size size) {

    // Coordinates coordinates = <Coordinates>[10] as Coordinates;
    // Paint paint = Paint()
    //   ..color = Colors.black
    //   ..strokeWidth = 3.0
    //   ..style = PaintingStyle.stroke;

    // Offset center = Offset(size.width / 2, size.height / 2);
    // Rect listPost = Rect.fromCircle(center: center, radius: 70.0);
    // // canvas.drawRect(rect, paint);

    //     canvas.drawRect(listPost, paint);
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
            size.width / 2, size.height / 2, size.width / 4, size.height / 4),
        Radius.circular(16)));      
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Coordinate {

late int x;
late int y;

 void setX(int x) {
this.x = x;
}

 void setY(int y) {
this.y = y;
}

 int getX() {
return this.x;
}

 int getY() {
return this.y;

}

}
