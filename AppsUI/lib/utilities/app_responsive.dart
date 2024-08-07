// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class AppResponsive extends StatelessWidget {
  final mobile;
  final tablet;
  final desktop;

  const AppResponsive({Key? key, this.mobile, this.tablet, this.desktop})
      : super(key: key);

  static bool isMobile(context) => MediaQuery.of(context).size.width < 900;
  static bool isTablet(context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 900;
  static bool isDesktop(context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
    // return Container();
  }
}
