// File: screens/first_onboard.dart

import 'package:flutter/material.dart';

class FirstOnboard extends StatelessWidget {
  const FirstOnboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Center(
            child: Image.asset(
              'images/1stonboard.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 1),
        const Text(
          'Welcome to WorthyYou',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Your journey to self-acceptance and confidence starts here',
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
