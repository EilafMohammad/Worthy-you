// File: screens/third_onboard.dart

import 'package:flutter/material.dart';

class ThirdOnboard extends StatelessWidget {
  const ThirdOnboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Center(
            child: Image.asset(
              'images/3rdonboard.png', // Path to your image
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Personalized Affirmations',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Experience the power of affirmations tailored to your needs and delivered in a voice that’s uniquely yours.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontFamily: 'Roboto',
              height: 1.5, // Adjust line height for better readability
            ),
          ),
        ),
        const SizedBox(height: 30),
        // Get Started button
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('FirstRegistration'); // Navigate to FirstRegistration
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 28.0),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
          ),
          child: const Text(
            'Get Started',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20), // Bottom padding
      ],
    );
  }
}
