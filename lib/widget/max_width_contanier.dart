import 'package:flutter/material.dart';

class AppConst {
  static const Color colorGrey = Color.fromRGBO(87, 85, 99, 1);
  static const Color colorGreyDark = Color.fromRGBO(50, 52, 64, 1);
  static const Color colorRedOrange = Color.fromRGBO(233, 89, 80, 1);
  static const Color colorYellow = Color.fromRGBO(252, 204, 99, 1);
  static const Color colorOrange = Color.fromRGBO(251, 173, 80, 1);

  static const double padding = 10.0;
}

class MaxWidthCintainer extends StatelessWidget {
  const MaxWidthCintainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1960),
        child: child,
      ),
    );
  }
}
