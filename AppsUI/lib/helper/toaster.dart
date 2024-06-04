// Package imports:
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Weyeyet/utilities/app_theme.dart';

// Project imports:

class ToasterService {
  static const searchText = '';
  static const successBook = 'Your Flight Booked';
  static const success = 'Success';
  static const errorMsg = 'Something happened';
  static const validationMsg = 'Error: Required Fields*';
  static const notFound = '404:Response Not Found';
  static const adultAge = 'Adult:12+ Years';
  static const childAge = 'Child:2-11 Years';
  static const infantAge = 'Infant:0-23 Months';
  static const loginError = 'Incorrect E-mail or Password';
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
    // msg: ToasterService.errorMsg,
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
