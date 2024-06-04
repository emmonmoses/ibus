// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:Weyeyet/Screen/home_page.dart';
import 'package:Weyeyet/utilities/colors.dart';
import 'package:animate_do/animate_do.dart'; // Import animate_do package

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColors,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            // Wrap Image.asset with FadeIn animation
            FadeIn(
              child: Image.asset(
                "assets/images/fourth.png",
                height: 300,
                width: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              // Wrap Text widget with BounceInDown animation
              child: BounceInDown(
                child: const Text(
                  "Fast delivery at \n your doorstep",
                  style: TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              // Wrap Text widget with BounceInDown animation
              child: BounceInDown(
                child: const Text(
                  "Home delivery and online reservation \n system for restaurants & cafes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              width: double.infinity,
              height: 55,
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: const Text(
                  "Let's Explore",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: primaryColors,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
