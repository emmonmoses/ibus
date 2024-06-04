import 'package:Weyeyet/utilities/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:Weyeyet/Screen/home_page.dart';

class SuccessRegistered extends StatelessWidget {
  const SuccessRegistered({super.key, required this.context});
  final BuildContext context;

  void show() {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      title: 'Ride Booked',
      desc: 'You Joined this Ride Successfully.',
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      btnOkIcon: Icons.check,
      btnOkColor: AppColor.deepBlue,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder widget
  }
}
