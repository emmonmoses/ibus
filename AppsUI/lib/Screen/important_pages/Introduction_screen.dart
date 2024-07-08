import 'package:Weyeyet/Screen/User/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:Weyeyet/Screen/User/registration_with_phone.dart';
import 'package:Weyeyet/utilities/app_theme.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages = [
    PageViewModel(
      title: 'Sunrise to Sunset Rides',
      body: 'Commute confidently from dawn till dusk with our reliable ride-sharing app. Start your day right and end it stress-free.',
      footer: SizedBox(
        height: 45,
        width: 300,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 34, 54, 235),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
          ),
          onPressed: () {},
          child: Text(
            "Let's Go",
            style: TextStyle(fontSize: 20, color: AppColor.white),
          ),
        ),
      ),
      image: const Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/images/ride.jpg'),
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    PageViewModel(
      title: 'Morning Commute Made Easy',
      body: 'Streamline your morning routine with our efficient ride-sharing service. Get to work on time, every time.',
      footer: SizedBox(
        height: 45,
        width: 300,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 34, 54, 235),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
          ),
          onPressed: () {},
          child: Text(
            "Why wait!",
            style: TextStyle(fontSize: 20, color: AppColor.white),
          ),
        ),
      ),
      image: const Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/images/taxi.jpg'),
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    PageViewModel(
      title: 'Safe and Reliable',
      body: 'Experience safe and reliable transportation with our trusted ride-sharing service. Your journey, our priority.',
      footer: SizedBox(
        height: 45,
        width: 300,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 34, 54, 235),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
          ),
          onPressed: () {},
          child: Text(
            "Stay Updated",
            style: TextStyle(fontSize: 20, color: AppColor.white),
          ),
        ),
      ),
      image: const Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/images/trip.jpg'),
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 80, 12, 12),
        child: IntroductionScreen(
          pages: pages,
          dotsDecorator:  DotsDecorator(
            size: const Size(15, 15),
            color: AppColor.deepBlue,
            activeSize: const Size.square(20),
            activeColor: const Color.fromARGB(255, 34, 54, 235),
          ),
          showDoneButton: true,
          done:  Text(
            'Finish',
            style: TextStyle(fontSize: 20,color: AppColor.deepBlue),
          ),
          showSkipButton: true,
          skip: InkWell(
            onTap: () {
              onDone(context);
            },
            child:  Text(
              'Skip',
              style: TextStyle(fontSize: 20,color: AppColor.deepBlue),
            ),
          ),
          onSkip: () => onDone(context),
          showNextButton: true,
          next:  Icon(
            Icons.arrow_forward,
            size: 25,
            color: AppColor.deepBlue

          ),
          onDone: () => onDone(context),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  void onDone(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
