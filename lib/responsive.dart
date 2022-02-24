import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobileContent(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;
  static bool isTabletContent(BuildContext context) =>
      MediaQuery.of(context).size.width < 900 &&
      MediaQuery.of(context).size.width >= 650;
  static bool isDesktopContent(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktop;
        } else if (constraints.maxWidth >= 650 && constraints.maxWidth < 1200) {
          return tablet ;
        } else {
          return mobile;
        }
      },
    );
  }
}

// enum ScreenStatus {
//   mobile,
//   tablet,
//   desktop,
// }

// class ScreenSize {
//   static ScreenStatus getScreenStatus(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     if (size.width >= 1200) {
//       return ScreenStatus.desktop;
//     }
//     if (size.width < 1200 && size.width >= 900) {
//       return ScreenStatus.tablet;
//     } else {
//       return ScreenStatus.mobile;
//     }
//   }
// }
