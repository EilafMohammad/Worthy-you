import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:worthy_you/utils/colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  static const tag = "/loading_screen";

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // _sendToChatGPT(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              Get.back();
            },
            icon: const ImageIcon(
              AssetImage(
                "images/icon_back.png",
              ),
              size: 30.0,
            )),
        backgroundColor: MyColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
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


  Future<void> _sendToChatGPT(String userInput) async {
    const apiKey = 'sk-KSnHdir8kGGHH6qyB-gl031jYCTnsD4xJHY9BmEB6rT3BlbkFJKmNOdh2xmpnCX60p_grMG_EXkC2N2LyGm3DdfhQXIA'; // Add your API key here
    const apiUrl = 'https://api.openai.com/v1/chat/completions';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    // If user input is empty, replace it with "I feel sad"
    final inputText = userInput.isNotEmpty ? userInput : "I feel sad";

    final body = json.encode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": """
        You are a professional psychology therapist. Your job is to provide users with positive affirmations in an inner voice style. These affirmations should be structured like: 
        - "I’m confident and strong."
        - "I am worthy and capable."
        The goal is for users to repeat these affirmations in their own voice. 
        Rules:
        1. The affirmation should be based on the user's self-image and appearance.
        2. Provide only one affirmation in response to the user's input.
        3. If the user asks for anything else, respond with "N/A".
        Do not say anything other than the affirmation.
        """
        },
        {
          "role": "user",
          "content": inputText
        }
      ],
      "max_tokens": 150
    });



    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final chatGptResponse = responseBody['choices'][0]['message']['content'] ?? "No response";

        Get.back(result: chatGptResponse);
      } else {
        Get.back(result: "Error:Failed to get a response from ChatGPT");
      }
    } catch (e) {
      Get.back(result: "Error: $e");
    }
  }

}
