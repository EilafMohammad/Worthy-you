import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:worthy_you/screens/audioPlay_appearence_screen.dart';
import 'package:worthy_you/screens/affirmation_generation.dart'; // Import AffirmationGeneration screen

class AppearanceScreen extends StatefulWidget {
  static const routeName = 'AppearanceScreen';

  const AppearanceScreen({super.key});

  @override
  _AppearanceScreenState createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = ""; // Speech-to-text output
  bool _isButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) => setState(() {
          _text = val.recognizedWords.isNotEmpty
              ? val.recognizedWords
              : "I couldn't catch that, try again."; // Handle empty result
          print("Recognized Words: $_text"); // Debugging log
        }),
      );
    }
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
      _isButtonPressed = false;
    });
    _speech.stop();
    // Do not automatically send to ChatGPT. Let the user review the text.
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
        
        // Navigate to AudioplayAppearanceScreen with GPT response
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AudioplayAppearenceScreen(responseText: chatGptResponse),
          ),
        );
      } else {
        _showError("Failed to get a response from ChatGPT");
      }
    } catch (e) {
      _showError("Error: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffFAFDFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'images/icons/arrowleft.png',
                      height: 35,
                      width: 35,
                    ),
                  ),
                  const Text(
                    "Appearance",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Do you often feel self-conscious about your appearance?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff0F1117),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'images/Picture4 1.png',
                  height: size.height * 0.4,
                  width: size.width * 0.8,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xff0f11171a)),
                ),
                child: Text(
                  _text.isEmpty ? "Your text will appear here..." : _text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff0F1117),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Press the mic, and hold to record",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff6C717B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              // Updated Row with Clear, Mic, and Submit buttons in correct positions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _text = ""; // Clear the text
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffffffff),
                      side: BorderSide(
                        color: const Color(0xff0F1117).withAlpha(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32, 
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Clear",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (_) {
                      setState(() => _isButtonPressed = true);
                      _startListening();
                    },
                    onTapUp: (_) {
                      _stopListening();
                    },
                    child: CircleAvatar(
                      radius: size.width * 0.1,
                      backgroundColor: _isButtonPressed
                          ? Colors.indigo.withOpacity(0.3)
                          : Colors.indigo.withOpacity(0.1),
                      child: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        color: Colors.indigo,
                        size: 35,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Send to ChatGPT if the user submits the text
                      if (_text.isNotEmpty) {
                        _sendToChatGPT(_text); // Send the text to ChatGPT only after pressing Submit
                      } else {
                        _sendToChatGPT("I don't like my nose"); // Auto-send "I feel sad" if no input
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffffffff),
                      side: BorderSide(
                        color: const Color(0xff0F1117).withAlpha(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32, 
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Space at the bottom for padding
            ],
          ),
        ),
      ),
    );
  }
}
