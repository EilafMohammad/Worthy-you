// File: screens/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worthy_you/screens/home/home_screen.dart';
import 'package:worthy_you/screens/onbaording/first_onboard.dart';
import 'package:worthy_you/screens/onbaording/second_onboard.dart';
import 'package:worthy_you/screens/onbaording/third_onboard.dart';
import 'package:worthy_you/screens/widget/btn_primary.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static String tag = "/onboarding_screen";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacementNamed('HomeScreen');
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Column(
        children: [
          if (_currentPage > 0)
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                onPressed: () {
                  _prevPage();
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: const [
                FirstOnboard(),  // Ensure these widgets are defined and imported correctly
                SecondOnboard(),
                ThirdOnboard(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.black : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (_currentPage < 2) ? 20.0 : 50.0),
            child: (_currentPage < 2)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed(HomeScreen.tag);
                        },
                        child: const Text(
                          Constants.labelSkip,
                          style: Styles.buttonTextStyle,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          if (_currentPage < 2) {
                            _nextPage();
                          } else {
                            Get.toNamed(HomeScreen.tag);
                          }
                        },
                        child: const Text(
                          Constants.labelNext,
                          style: Styles.buttonTextStyle,
                        ),
                      ),
                    ],
                  )
                : PrimaryButton(
                    title: Constants.labelGetStarted,
                    backgroundColor: MyColors.btnColorPrimary,
                    onPressed: () {
                      Get.toNamed(HomeScreen.tag);
                    },
                  ),
          ),
          const SizedBox(height: 20), // Bottom padding
        ],
      ),
    );
  }
}
