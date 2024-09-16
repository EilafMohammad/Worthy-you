import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worthy_you/screens/splash_screen.dart';

import 'routes/rutes.dart';
import 'utils/constants.dart'; // Correct import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.tag,
      getPages: AppRoutes.rideRoutes(),
      // routes: {
      //   SplashScreen.tag: (context) => const SplashScreen(), // Register the splash screen route
      //   OnboardingScreen.tag: (context) => const OnboardingScreen(), // Correctly reference OnboardingScreen
      //   'FirstRegistration': (context) => const FirstRegistration(), // Register the FirstRegistration screen
      //   'HomeScreen': (context) => const HomeScreen(),
      //   'AudioPlayScreen': (context) => const AudioPlayScreen(),
      //   'AppearanceScreen': (context) => const AppearanceScreen(),
      //   'VentingBotScreen1': (context) => const VentingBotScreen1(),
      //   'Bot2ChatScreen': (context) => const Bot2ChatScreen(),
      //   'QuizScreen': (context) => const QuizScreen(),
      //   'QuizPathScreen': (context) => const QuizPathScreen(),
      //   'AudioplayAppearenceScreen': (context) => AudioplayAppearenceScreen(responseText: 'Sample response'), // Fix: remove const and pass dynamic value
      // },
    );
  }
}
