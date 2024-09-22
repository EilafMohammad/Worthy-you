import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:worthy_you/extensions/map_extentions.dart';
import 'package:worthy_you/screens/audio_player.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/styles.dart'; // Import for Timer functionality

class AudioPlayerAppearanceScreen extends StatefulWidget {
  static const tag = '/audio_player_appearance';

  const AudioPlayerAppearanceScreen({super.key});

  @override
  State<AudioPlayerAppearanceScreen> createState() => _AudioPlayerAppearanceScreenState();
}

class _AudioPlayerAppearanceScreenState extends State<AudioPlayerAppearanceScreen> {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  String responseText = "";
  String responseUrl = "";
  String title = "";
  Duration currentDuration = Duration.zero;
  Duration totalDuration = Duration.zero;
  Timer? _timer;  // Timer to simulate progress

  @override
  void initState() {
    super.initState();
    if (Get.arguments is Map) {
      responseText = (Get.arguments as Map).getValueOfKey("text");
      responseUrl = (Get.arguments as Map).getValueOfKey("url");
      title = (Get.arguments as Map).getValueOfKey("category");
    }
  }


  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    flutterTts.stop(); // Ensure TTS is stopped when exiting
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
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
          title: Text(
            "Appearance",
            style: Styles.subHeadingStyle,
          ),
          centerTitle: true,
          backgroundColor: MyColors.backgroundColor,
        ),

        backgroundColor: MyColors.backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image Section
                  const CircleAvatar(
                    radius: 110,
                    backgroundImage: AssetImage(
                        'images/Group15.png'), // Assuming image path is correct
                  ),

                  const SizedBox(height: 20),

                  // Text Response Box
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xffFFFFFF),
                      border: Border.all(
                          color: const Color(0xff0F1117).withOpacity(0.2)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          responseText, // Display the GPT response here
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0F1117),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Background Effects Section
                  const Text(
                    "Background Effects",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10.0,
                    children: [
                      _buildEffectButton("Ocean"),
                      _buildEffectButton("Rain"),
                      _buildEffectButton("Forest"),
                      _buildEffectButton("None"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Narrator Selection Section
                  const Text(
                    "Narrator",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10.0,
                    children: [
                      _buildNarratorButton("Female", false),
                      _buildNarratorButton("Male", true), // Disabled button
                      _buildNarratorButton("My Voice", true), // Disabled button
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
            Spacer(),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: AudioPlayerWidget(audioUrl: responseUrl)),
          ],
        ),
      ),
    );
  }

  // Button builder for background effects
  Widget _buildEffectButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Handle background effect change
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffFFFFFF),
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Button builder for narrator options with disabled state
  Widget _buildNarratorButton(String label, bool disabled) {
    return ElevatedButton(
      onPressed: disabled ? null : () {
        // Handle narrator selection if not disabled
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffFFFFFF),
        side: disabled
            ? BorderSide(color: Colors.grey.withOpacity(0.5))
            : const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: disabled ? Colors.grey : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
