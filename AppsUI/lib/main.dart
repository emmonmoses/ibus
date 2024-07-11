import 'package:Weyeyet/Screen/User/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Weyeyet/Screen/User/registration_with_phone.dart';
import 'package:Weyeyet/Screen/important_pages/Introduction_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final showIntro = prefs.getBool('ON_BOARDING') ?? true;

  runApp(MyApp(showIntro: showIntro));
}

class MyApp extends StatelessWidget {
  final bool showIntro;

  MyApp({Key? key, required this.showIntro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Add this line
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: showIntro ? IntroScreen() : const LoginPage(),
    );
  }
}
