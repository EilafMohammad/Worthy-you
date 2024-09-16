// File: screens/second_onboard.dart

import 'package:flutter/material.dart';

class SecondOnboard extends StatelessWidget {
  const SecondOnboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Center(
            child: Image.asset(
              'images/2ndonboard.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Diagnose your insecurities',
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
            'Take a quiz to uncover what’s holding you back.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        const Spacer(), // Optional: Adjust spacing
      ],
    );
  }
}
