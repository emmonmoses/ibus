// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:Weyeyet/utilities/app_theme.dart';
// import './themeColors.dart';

class ThemeStyles {
  static TextStyle departureTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 25.0,
  );
  static TextStyle arrivalTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 40.0,
    fontWeight: FontWeight.w700,
  );
  static TextStyle travelDateTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 25.0,
    fontWeight: FontWeight.w100,
  );
  static TextStyle dropDownTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 15.0,
  );
  static TextStyle ticketPrice = TextStyle(
    color: AppColor.deepBlue,
    fontSize: 35.0,
    fontWeight: FontWeight.w900,
  );
  static TextStyle greyStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 15.0,
  );
  static TextStyle mainBlackTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 30.0,
  );
  static TextStyle subBlackTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 15.0,
  );
}
