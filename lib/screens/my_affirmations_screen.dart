import 'package:flutter/material.dart';

class MyAffirmationsScreen extends StatelessWidget {
  const MyAffirmationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Affirmations')),
      body: const Center(
        child: Text(
          'My Affirmations Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
