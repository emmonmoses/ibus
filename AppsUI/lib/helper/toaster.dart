import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utilities/app_theme.dart';

class ToasterService {
  static const searchText = '';
  static const successBook = 'Your Flight Booked';
  static const notify = 'Notification Enabled';

  static const success = 'Success';
  static const errorMsg = 'Something happened';
  static const validationMsg = 'Error: Required Fields*';
  static const notFound = '404:Response Not Found';
  static const emailNotFound = 'your email is not found in our system.';
  static const emailempty = 'Email can not empty';
  static const permisstionnotgiven = 'Permission is Not granted';

  static const adultAge = 'Adult:12+ Years';
  static const childAge = 'Child:2-11 Years';
  static const infantAge = 'Infant:0-23 Months';
  static const loginError = 'Incorrect E-mail or Password';
  static const transactionDeails = 'Transaction Details';
}

transaction() {
  Fluttertoast.showToast(
    msg: ToasterService.transactionDeails,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kPrimaryColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

toastSuccess() {
  Fluttertoast.showToast(
    msg: ToasterService.successBook,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kPrimaryColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

toastNotification() {
  Fluttertoast.showToast(
    msg: ToasterService.notify,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kPrimaryColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

toastAdultage() {
  Fluttertoast.showToast(
    msg: ToasterService.adultAge,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kPrimaryColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

toastChildage() {
  Fluttertoast.showToast(
    msg: ToasterService.childAge,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kPrimaryColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

toastInfantage() {
  Fluttertoast.showToast(
    msg: ToasterService.infantAge,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kPrimaryColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

toastError(error) {
  Fluttertoast.showToast(
    msg: error,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kErrorColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

toastSuccessArg(success) {
  Fluttertoast.showToast(
    msg: success,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kPrimaryColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

toast404() {
  Fluttertoast.showToast(
    msg: ToasterService.notFound,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kErrorColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

emailNotFound() {
  Fluttertoast.showToast(
    msg: ToasterService.emailNotFound,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kErrorColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

emptyEmail() {
  Fluttertoast.showToast(
    msg: ToasterService.emailempty,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kErrorColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

nopermisstiongiven(err) {
  Fluttertoast.showToast(
    msg: ToasterService.permisstionnotgiven,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kErrorColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

toastAlert(msg) {
  Fluttertoast.showToast(
    msg: msg,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColor.kErrorColor,
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

toastValidation(formKey) {
  if (formKey.currentState!.validate()) {
    toastError(formKey);
  }
}

toastNotFound(arg) {
  if (arg.currentState!.validate()) {
    toast404();
  }
}

toastOriginError() {
  Fluttertoast.showToast(
      msg: 'Select departure city',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);
}

toastDestinationError() {
  Fluttertoast.showToast(
      msg: 'Select Arrival city',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);
}

toastDuplicateError() {
  Fluttertoast.showToast(
      msg: 'Departure City and Arrival City',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);
}

toastDateError() {
  Fluttertoast.showToast(
      msg: 'Pick a date',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);
}

toastReturnDateError() {
  Fluttertoast.showToast(
      msg: 'Pick a return date',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);
}

toastLoginError() {
  Fluttertoast.showToast(
    msg: ToasterService.loginError,
    timeInSecForIosWeb: 5,
    webShowClose: true,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.red[400],
    textColor: AppColor.kContentColorDarkTheme,
    fontSize: 16.0,
  );
}

class MyStringsSample {
  static const String lorem_ipsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam efficitur ipsum in placerat molestie.  Fusce quis mauris a enim sollicitudin"
      "\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam efficitur ipsum in placerat molestie.  Fusce quis mauris a enim sollicitudin";
  static const String middle_lorem_ipsum =
      "Flutter is an open-source UI software development kit created by Google. It is used to develop cross-platform applications for Android, iOS, Linux, macOS, Windows, Google Fuchsia, and the web from a single codebase.";
  static const String card_text =
      "Your All-in-One Solution for On-Demand Home Services";
}
