import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/homepage.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset("assets/logo.png"),
      durationInSeconds: 5,
      logoSize: 120,
      backgroundColor: Colors.red.shade100,
      showLoader: true,
      navigator: const Homepage(),
    );
  }
}
