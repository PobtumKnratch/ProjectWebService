import 'package:flutter/material.dart';

class RectanglePaintPage extends StatefulWidget {
  const RectanglePaintPage({Key? key}) : super(key: key);

  @override
  _RectanglePaintPageState createState() => _RectanglePaintPageState();
}

class _RectanglePaintPageState extends State<RectanglePaintPage> {
  static const String routeName = '/Rec';
  // Offset pos = Offset(0, 0);
  // List<Offset> listPost = <Offset>[];
  var xPos = 0.0;
  var yPos = 0.0;
  final width = 100.0;
  final height = 100.0;
  bool _dragging = false;

  /// Is the point (x, y) inside the rect?
  bool _insideRect(double x, double y) =>
      x >= xPos && x <= xPos + width && y >= yPos && y <= yPos + height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => _dragging = _insideRect(
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      onPanEnd: (details) {
        _dragging = false;
      },
      onPanUpdate: (details) {
        if (_dragging) {
          setState(() {
            xPos += details.delta.dx;
            yPos += details.delta.dy;
          });
        }
      },
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: RectanglePainter(Rect.fromLTWH(xPos, yPos, width, height)),
          child: Container(),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) => Scaffold(
  //       body: GestureDetector(
  //         onPanUpdate: (DragUpdateDetails details) {
  //           setState(
  //             () {
  //               RenderObject? box = context.findRenderObject();
  //               pos = box.globalToLocal(details.globalPosition);
  //               listPost = List.from(listPost)..add(pos);
  //             },
  //           );
  //         },
  //         child: Container(
  //           color: Colors.white,
  //           // width: 300,
  //           // height: 300,
  //           child: CustomPaint(
  //             painter: RectanglePainter(listPost),
  //             // child: Text(
  //             //   "Custom Paint",
  //             //   style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
  //             // ),
  //           ),
  //         ),
  //       ),
  //     );
}

class RectanglePainter extends CustomPainter {
  RectanglePainter(this.rect);
  final Rect rect;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

  
    canvas.drawRect(rect, Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// class RectanglePainter extends CustomPainter {
//   RectanglePainter(this.listPost);
//   final List<Offset> listPost;
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..strokeWidth = 10
//       ..style = PaintingStyle.stroke;

//     final a = Offset(size.width * 1 / 6, size.height * 1 / 4);
//     final b = Offset(size.width * 5 / 6, size.height * 3 / 4);
//     final rect = Rect.fromPoints(
//       a,
//       b,
//     );

//     var length;
//     var canvas = TouchyCanvas(context, canvas);
//     for (var i = 0; i < listPost.length; i++) {
//       canvas.drawRect(rect, paint, onPan);
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
//   // return oldDelegate.listPost != listPost;

// }
