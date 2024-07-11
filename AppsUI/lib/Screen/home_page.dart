import 'package:Weyeyet/Screen/important_pages/transfer.dart';
import 'package:Weyeyet/Screen/trips/OrderSummaryPage.dart';
import 'package:Weyeyet/utilities/app_theme.dart';
import 'package:Weyeyet/widget/menu_drawer/Card_view.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:Weyeyet/Screen/User/account_screen.dart';
import 'package:Weyeyet/Screen/trips/trip_history.dart';
import 'package:Weyeyet/utilities/colors.dart';
import 'package:Weyeyet/Screen/header_parts.dart';
import 'package:Weyeyet/Screen/items_diplay.dart';
import 'package:Weyeyet/model/items_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    // const OrderSummaryPage(),
    // const CardBasicRoute(),
// const TransferPage(),
    MyTripSummaryPage(trip: tripsItems[0]), // Pass a TripDetail object here
    AccountScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: primaryColors,
        buttonBackgroundColor: primaryColors,
        height: 50, // Adjust the height here
        index: _currentIndex,
        onTap: onTabTapped,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.directions_bus, size: 30, color: Colors.white),
          Icon(Icons.account_box, size: 30, color: Colors.white),
        ],
      ),
      body: _pages[_currentIndex],
      floatingActionButton: Positioned(
        bottom: 45.0,
        right: 5.0,
        child: FloatingActionButton(
          backgroundColor: Colors.red,
                hoverElevation: 10,
                splashColor: Colors.green,
                tooltip: 'SOS',
                elevation: 4,
                child: Text(
                  'SOS',
                  style: TextStyle(color: AppColor.white),
                ),
          onPressed: () {
            // Add your SOS call functionality here
          },
          // backgroundColor: Colors.red,
          // child: const Icon(Icons.phone, color: Colors.white),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: 15),
        HeaderParts(),
        ItemsDisplay(),
      ],
    );
  }
}
