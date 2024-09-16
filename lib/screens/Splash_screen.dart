// File: screens/splash_screen.dart

import 'package:flutter/material.dart';
import 'dart:async'; // Required for Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer to navigate to OnboardingScreen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('OnboardingScreen'); // Navigate to OnboardingScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/splash_worthy.png', height: 320, width: 320),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Loading progress bar
          ],
        ),
      ),
    );
  }
}
