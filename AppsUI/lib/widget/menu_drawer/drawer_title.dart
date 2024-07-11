import 'package:flutter/material.dart';
import 'package:Weyeyet/utilities/app_theme.dart';

class DrawerHead extends StatefulWidget {
  const DrawerHead({super.key});

  @override
  DrawerHeadState createState() => DrawerHeadState();
}

class DrawerHeadState extends State<DrawerHead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.deepBlue,
      // width: double.infinity,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/appimage.png'),
              ),
            ),
          ),
          Text(
            "Waafi Travel",
            style:
                TextStyle(color: AppColor.kContentColorDarkTheme, fontSize: 20),
          ),
          Text(
            "info@waffitravel.com",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
