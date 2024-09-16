import 'package:flutter/material.dart';
import 'package:worthy_you/screens/audioPlay_appearence_screen.dart';
import 'package:worthy_you/screens/audio_play_screen.dart';
import 'package:worthy_you/screens/bot1_screen.dart';
import 'package:worthy_you/screens/bot2_chat_screen.dart';
import 'package:worthy_you/screens/home_screen.dart';
import 'package:worthy_you/screens/quiz_appearence_screen.dart';
import 'package:worthy_you/screens/quiz_path_screen.dart';
import 'package:worthy_you/screens/take_a_quiz.dart';
import 'package:worthy_you/screens/splash_screen.dart';
import 'package:worthy_you/screens/onboarding_screen.dart'; // Import the OnboardingScreen
import 'package:worthy_you/screens/first_registration.dart'; // Correct import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WorthyYou',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: 'SplashScreen', // Set the splash screen as the initial route
      routes: {
        'SplashScreen': (context) => const SplashScreen(), // Register the splash screen route
        'OnboardingScreen': (context) => const OnboardingScreen(), // Correctly reference OnboardingScreen
        'FirstRegistration': (context) => const FirstRegistration(), // Register the FirstRegistration screen
        'HomeScreen': (context) => const HomeScreen(),
        'AudioPlayScreen': (context) => const AudioPlayScreen(),
        'AppearanceScreen': (context) => const AppearanceScreen(),
        'VentingBotScreen1': (context) => const VentingBotScreen1(),
        'Bot2ChatScreen': (context) => const Bot2ChatScreen(),
        'QuizScreen': (context) => const QuizScreen(),
        'QuizPathScreen': (context) => const QuizPathScreen(),
        'AudioplayAppearenceScreen': (context) => AudioplayAppearenceScreen(responseText: 'Sample response'), // Fix: remove const and pass dynamic value
      },
    );
  }
}
