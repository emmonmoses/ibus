// Flutter imports
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Weyeyet/Screen/home_page.dart';

// Package imports

// Project imports

class DrawerList extends StatefulWidget {
  // final Function(int) onDrawerItemTap;
  const DrawerList({
    Key? key,
    // required this.onDrawerItemTap
  }) : super(key: key);

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<DrawerList> {
  dynamic container;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // home();
          },
          child: menuItem(
            1,
            "Home",
            Icons.home,
          ),
        ),
        InkWell(
          onTap: () {
            // flighthome();
          },
          child: menuItem(
            2,
            "Search Churches",
            Icons.church_outlined,
          ),
        ),
        InkWell(
          onTap: () {
            login();
          },
          child: menuItem(
            3,
            "Sign In",
            Icons.login,
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     logout();
        //   },
        //   child: menuItem(
        //     3,
        //     "Sign Out",
        //     Icons.logout,
        //   ),
        // ),
        InkWell(
          onTap: (() {
            // signout();
          }),
          child: menuItem(
            4,
            "Contact Us",
            Icons.contact_page,
          ),
        ),
      ],
    );
  }

  Widget menuItem(
    int id,
    String title,
    IconData icon,
  ) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }

  void login() {}

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ),
    ); // Replace '/login' with the route of your login page
  }
}
