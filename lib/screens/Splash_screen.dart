
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:worthy_you/screens/onbaording/onboarding_screen.dart';
import 'package:worthy_you/utils/colors.dart'; // Required for Timer

class SplashScreen extends StatefulWidget {
  static String tag = "/splash_screen";

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.toNamed(OnboardingScreen.tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Center(
        child: Image.asset('images/splash_worthy.png',width : width*0.6),
      ),
    );
  }
}
