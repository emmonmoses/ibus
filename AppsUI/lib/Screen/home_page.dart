import 'package:Weyeyet/model/items_model.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:Weyeyet/Screen/User/account_screen.dart';
import 'package:Weyeyet/Screen/trips/trip_history.dart';
import 'package:Weyeyet/utilities/colors.dart';
import 'package:Weyeyet/Screen/header_parts.dart';
import 'package:Weyeyet/Screen/items_diplay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    MyTripHistoryPage(trip: tripsItems[0]), // Pass a TripDetail object here
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
        height: 50,  // Adjust the height here
        index: _currentIndex,
        onTap: onTabTapped,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.directions_bus, size: 30, color: Colors.white),
          Icon(Icons.account_box, size: 30, color: Colors.white),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
