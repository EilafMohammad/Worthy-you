import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:worthy_you/extensions/map_extentions.dart';
import 'package:worthy_you/extensions/response_extentions.dart';
import 'package:worthy_you/services/http_services.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/pref_utils.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  static const tag = "/loading_screen";

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? title;
  @override
  void initState() {
    super.initState();
    if (Get.arguments is Map) {
      var content = (Get.arguments as Map).getValueOfKey("userInput");
       title = (Get.arguments as Map).getValueOfKey("title");
      var file = (Get.arguments as Map).getValueOfKey("filePath");
      _sendToChatGPT(content, file);
    }
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

  Future<dynamic> _sendToChatGPT(String userInput, File? file) async {
    final inputText = userInput.isNotEmpty ? userInput : "I feel sad";
    getTextFromGPT(content: inputText);
    // Future.delayed(const Duration(seconds: 3),()async{
    //
    //   final jsonObject = {
    //     "id": "AS0KoCS9yPrz2EQIgE",
    //     "progress": 1,
    //     "stage": "complete",
    //     "url": "https://peregrine-results.s3.amazonaws.com/pigeon/AS0KoCS9yPrz2EQIgE_0.mp3",
    //     "duration": 1.664,
    //     "size": 35085
    //   };
    //
    //   // Convert the Map to a JSON string
    //   final jsonString = jsonEncode(jsonObject);
    //   Get.back(result: jsonDecode(jsonString));
    // });

    return;

    const apiKey =
        'sk-KSnHdir8kGGHH6qyB-gl031jYCTnsD4xJHY9BmEB6rT3BlbkFJKmNOdh2xmpnCX60p_grMG_EXkC2N2LyGm3DdfhQXIA'; // Add your API key here
    const apiUrl = 'https://api.openai.com/v1/chat/completions';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    // If user input is empty, replace it with "I feel sad"

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
        {"role": "user", "content": inputText}
      ],
      "max_tokens": 150
    });

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final chatGptResponse =
            responseBody['choices'][0]['message']['content'] ?? "No response";

        Get.back(result: chatGptResponse);
      } else {
        Get.back(result: "Error:Failed to get a response from ChatGPT");
      }
    } catch (e) {
      Get.back(result: "Error: $e");
    }
  }

  Future<dynamic> getTextFromGPT({
    required String content,
    String? filePath,
  }) async {
    try {

      // 2. Provide only one affirmation in response to the user's input.
      // 3. If the user asks for anything else, respond with "N/A".
      final body = {
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
        Do not say anything other than the affirmation.
        """
          },
          {"role": "user", "content": content}
        ],
        "max_tokens": 150
      };
      var response = await HttpServices.postJson(
          url: 'https://api.openai.com/v1/chat/completions',
          body: body,
          token:
              'sk-KSnHdir8kGGHH6qyB-gl031jYCTnsD4xJHY9BmEB6rT3BlbkFJKmNOdh2xmpnCX60p_grMG_EXkC2N2LyGm3DdfhQXIA');
      if (await response.isSuccessful()) {
        final responseBody = json.decode(response.body);
        final chatGptResponse =
            responseBody['choices'][0]['message']['content'] ?? "No response";
        getVoices(
          content: chatGptResponse,
        );
      } else {
        Get.back(result: "Failed to generate Effirmations");
      }
    } catch (e) {
      Get.back(result: "Failed to generate Effirmations");
    }
  }

  Future<dynamic> getVoices({
    required String content,
  }) async {
    try {
      var template = await MyPrefUtils.getString(MyPrefUtils.voiceTemplate);
      var body = {
        "text": content,
        // "voice": "s3://voice-cloning-zero-shot/d9ff78ba-d016-47f6-b0ef-dd630f59414e/female-cs/manifest.json",
        "voice": (template.isNotEmpty)
            ? template
            : "s3://voice-cloning-zero-shot/d9ff78ba-d016-47f6-b0ef-dd630f59414e/female-cs/manifest.json",
        "output_format": "mp3",
        "voice_engine": "PlayHT2.0"
      };

      print("Template--------------->$template");
      var response = await HttpServices.postStreamJson(
          url: 'https://api.play.ht/api/v2/tts', body: body);
      await for (var chunk in response.stream.transform(utf8.decoder)) {
        if (kDebugMode) {
          print("Received event: $chunk");
        }
        processEventStream(content: content, chunk: chunk);
      }

      if (kDebugMode) {
        print("Response headers: ${response.headers}");
      }
    } catch (e) {
      Get.back(result: "Failed to generate Effirmations");
    }
  }

   Future<void> processEventStream(
      {required String chunk, required String content}) async {
    List<String> events = chunk.split('\n\n');
    for (var event in events) {
      if (event.trim().isNotEmpty) {
        if (kDebugMode) {
          print('Processing event: $event');
        }
        final jsonMatch = RegExp(r'\{.*?"url":".*?"[^}]*\}').firstMatch(event);
        if (jsonMatch != null) {
          final jsonString = jsonMatch.group(0)!;
          var jsonData = jsonDecode(jsonString);
          if (jsonData['stage'] == 'complete' && jsonData['url'] != null) {
            if (kDebugMode) {
              print("Stage: ${jsonData['stage']}, URL: ${jsonData['url']}");
            }
            jsonData["content"] = content;
            if (content != "N/A") {
             await saveUserVoiceAndText(jsonString,content);
            }
            Get.back(result: jsonData);
          }
        }

        /*final eventData = jsonDecode(event)['data'];
        if (eventData['stage'] == 'complete' && eventData['url'] != null) {
          if (kDebugMode) {
            print("Stage: ${eventData['stage']}, URL: ${eventData['url']}");
           Get.back(result: {
             "text":Get.arguments,
             "result_url":eventData['url']
           });
          }
          break;
        }
        else if (eventData['stage'] == 'complete' && eventData['url'] == null) {
          Get.back(result: {
            "text":Get.arguments,
            "result_url":null
          });
        }*/
      }
    }
  }

  Future<void> saveUserVoiceAndText(String data,String content) async {
    String userId= await MyPrefUtils.getString(MyPrefUtils.userId);
    try {
      // Create a reference to the user's document
      DocumentReference userRef = _firestore.collection('users').doc(userId);

      // Create the data to save
      Map<String, String> dataToSave = {
        'response_data': data,
        'text': content,
      };

      await userRef.collection('records').doc(title).set(dataToSave);

      print('Data saved successfully: $dataToSave');
    } catch (e) {
      print('Error saving data: $e');
    }
  }
}
