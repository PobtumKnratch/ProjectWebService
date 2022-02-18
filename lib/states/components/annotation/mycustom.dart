import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

class MyCustomPainter extends StatefulWidget {
  const MyCustomPainter({Key? key}) : super(key: key);
  static const String routeName = '/mycustom';

  @override
  _MyCustomPainterState createState() => _MyCustomPainterState();
}

class _MyCustomPainterState extends State<MyCustomPainter> {
  Offset pos = Offset(0, 0);
  List<Offset> listPos = <Offset>[];
  static Color color = Colors.black;
  List<Color> listColor = <Color>[Colors.amber, Colors.green, Colors.blue];
  String mode = 'Line';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              // onPanDown: (DragDownDetails details) => setState(() => listPos = []),
              onPanStart: (details) {
                setState(() {
                  RenderBox? box = context.findRenderObject() as RenderBox?;
                  pos = box!.globalToLocal(details.globalPosition);

                  listPos = List.from(listPos)..add(pos);
                  listColor = List.from(listColor)..add(color);
                });
              },
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  RenderBox? box = context.findRenderObject() as RenderBox?;
                  pos = box!.globalToLocal(details.globalPosition);

                  listPos = List.from(listPos)..add(pos);
                  listColor = List.from(listColor)..add(color);
                });
              },
              onPanEnd: (DragEndDetails details) => setState(() {
                if (mode == "Line")
                  listPos = [
                    listPos.lastWhere((element) => true),
                    listPos.firstWhere((element) => true),
                  ];
                listColor = [listColor.lastWhere((element) => true)];
              }),
              child: Container(
                child: CustomPaint(
                  painter: Draw(listPos, listColor),
                  child: Container(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Container(
              color: Colors.black,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        listColor = [Colors.amber, Colors.green, Colors.blue];
                      });
                    },
                    icon: Icon(
                      Icons.mode_edit_outlined,
                      size: 30,
                      color: Colors.amber,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        listColor = [Colors.amber, Colors.green, Colors.blue];
                      });
                    },
                    icon: Icon(
                      Icons.crop_free_outlined,
                      size: 30,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Draw extends CustomPainter {
  Draw(this.listPost, this.listColor);
  final List<Offset> listPost;
  final List<Color> listColor;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 5;

    for (var i = 0; i < listPost.length; i++) {
      paint.color = listColor[i];
      canvas.drawLine(listPost[i], listPost[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(Draw old) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return old.listPost != listPost;
  }
}
