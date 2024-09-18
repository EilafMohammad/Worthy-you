import 'package:flutter/material.dart';
import 'package:worthy_you/screens/audioPlay_appearence_screen.dart'; // Import the AudioPlayAppearanceScreen

class AffirmationGeneration extends StatefulWidget {
  const AffirmationGeneration({super.key});

  @override
  _AffirmationGenerationState createState() => _AffirmationGenerationState();
}

class _AffirmationGenerationState extends State<AffirmationGeneration> {
  @override
  void initState() {
    super.initState();

    // Simulated ChatGPT response (replace with actual value)
    String chatGptResponse = "You are worthy, confident, and strong!"; // Replace this with actual dynamic data

    // Navigate to AudioplayAppearenceScreen after 3 seconds with the responseText
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AudioPlayerAppearanceScreen(responseText: chatGptResponse), // Pass responseText here
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFDFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Affirmations are being generated....",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff0F1117),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Center(
              child: Image.asset(
                'images/affirmation_generation.png', // Your image path
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Please wait patiently....\nthis takes usually 1 - 2 min",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff6C717B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
