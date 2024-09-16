// File: screens/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:worthy_you/screens/first_onboard.dart';
import 'package:worthy_you/screens/second_onboard.dart';
import 'package:worthy_you/screens/third_onboard.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _prevPage,
                  child: const Text(
                    'Back',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                if (_currentPage < 2)
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 28.0),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                else
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('HomeScreen');
                    },
                    child: const Text(
                      'Enter as a guest',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Bottom padding
        ],
      ),
    );
  }
}
