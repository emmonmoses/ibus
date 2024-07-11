//dart import

import 'package:flutter/material.dart';
//package import
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:Weyeyet/Screen/User/registration_with_phone.dart';

//project import

import '../utilities/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> children = [];
  @override
  void initState() {
    children = navBarPages();
    super.initState();
  }

  final GlobalKey<CurvedNavigationBarState> _navKey = GlobalKey();

  List<Widget> navBarPages() => [
        // FlightSearch()
        const RegisterWithPhoneNumber(),
        const RegisterWithPhoneNumber(),

        const RegisterWithPhoneNumber(),

        // const TripScreen(),
        // BookingConfirmationPage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.deepBlue,
        key: _navKey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.airplanemode_active_outlined), label: 'Book'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.luggage),
            label: 'My Trips',
          )
        ],
        backgroundColor: AppColor.white,
        onTap: (index) {},
      ),
    );
  }
}
