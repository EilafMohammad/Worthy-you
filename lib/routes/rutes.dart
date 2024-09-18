import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:worthy_you/screens/Splash_screen.dart';
import 'package:worthy_you/screens/audioPlay_appearence_screen.dart';
import 'package:worthy_you/screens/audio_play_screen.dart';
import 'package:worthy_you/screens/chatbot/chat_bot.dart';
import 'package:worthy_you/screens/chatbot/chat_bot_intro_screen.dart';
import 'package:worthy_you/screens/home/home_screen.dart';
import 'package:worthy_you/screens/onbaording/onboarding_screen.dart';
import 'package:worthy_you/screens/path_affirmation_categories_screen.dart';
import 'package:worthy_you/screens/quiz/take_a_quiz.dart';
import 'package:worthy_you/screens/quiz_path_screen.dart';

class AppRoutes {
  static rideRoutes() => [
    Generalized.generalized(SplashScreen.tag, () => const SplashScreen(), bindings: []),
    Generalized.generalized(OnboardingScreen.tag, () => const OnboardingScreen(), bindings: []),
    Generalized.generalized(HomeScreen.tag, () => const HomeScreen(), bindings: []),
    Generalized.generalized(AudioPlayScreen.tag, () => const AudioPlayScreen(), bindings: []),
    Generalized.generalized(QuizScreen.tag, () => const QuizScreen(), bindings: []),
    Generalized.generalized(ChatBotIntroScreen.tag, () => const ChatBotIntroScreen(), bindings: []),
    Generalized.generalized(ChatBotScreen.tag, () => const ChatBotScreen(), bindings: []),
    Generalized.generalized(QuizResultsScreen.tag, () => const QuizResultsScreen(), bindings: []),
    Generalized.generalized(AffirmationCategoriesScreen.tag, () =>  AffirmationCategoriesScreen(), bindings: []),
    Generalized.generalized(AudioPlayerAppearanceScreen.tag, () =>  const AudioPlayerAppearanceScreen(), bindings: []),
  ];
}

class Generalized {
  static GetPage generalized(
    String name,
    dynamic page, {
    dynamic arguments,
    Transition? transition,
    bool? opaque,
    Bindings? binding,
    List<Bindings>? bindings,
  }) {
    return GetPage(
      name: name,
      page: page,
      curve: Curves.easeInOutQuad,
      arguments: arguments,
      binding: binding,
      transition: transition ?? Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 350),
      bindings: bindings ?? [],
    );
  }
}
