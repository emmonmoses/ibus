import 'package:flutter/material.dart';
import 'package:Weyeyet/widget/menu_drawer/drawer_header.dart';
import 'package:Weyeyet/widget/menu_drawer/drawer_list.dart';

class MenuDrawer extends StatefulWidget {
  // final Function(int) onDrawerItemTap;
  const MenuDrawer({
    Key? key,
    // required this.onDrawerItemTap
  }) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isMobile(context)) const DrawerHead(),
            if (isMobile(context)) const DrawerList(),
          ],
        ),
      ),
    );
  }
}
