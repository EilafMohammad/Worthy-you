
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:worthy_you/screens/home/home_screen.dart';
import 'package:worthy_you/screens/onbaording/onboarding_screen.dart';
import 'package:worthy_you/screens/onbaording/register/SignUpScreen.dart';
import 'package:worthy_you/screens/onbaording/signIn/SignInScreen.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/pref_utils.dart'; // Required for Timer

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
    Timer(const Duration(seconds: 3), () async {
      // Get.toNamed(OnboardingScreen.tag);
      if(await MyPrefUtils.getBool(MyPrefUtils.isLoggedIn)){
        if(await MyPrefUtils.getBool(MyPrefUtils.isSliderSeen)){
          Get.toNamed(HomeScreen.tag);
        }else{
          Get.toNamed(OnboardingScreen.tag);
        }
      }else{
        Get.toNamed(SignInScreen.tag);
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Center(
        child: Image.asset('images/icon_worthy.png',width : width*0.6),
      ),
    );
  }
}
