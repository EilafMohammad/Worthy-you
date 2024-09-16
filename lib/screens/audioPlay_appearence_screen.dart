import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async'; // Import for Timer functionality

class AudioplayAppearenceScreen extends StatefulWidget {
  static const routeName = 'AudioplayAppearenceScreen';
  final String responseText; // The generated affirmation text

  const AudioplayAppearenceScreen({super.key, required this.responseText});

  @override
  State<AudioplayAppearenceScreen> createState() => _AudioplayAppearenceScreenState();
}

class _AudioplayAppearenceScreenState extends State<AudioplayAppearenceScreen> {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  Duration currentDuration = Duration.zero;
  Duration totalDuration = Duration.zero;
  Timer? _timer;  // Timer to simulate progress

  @override
  void initState() {
    super.initState();
    _setupTTS();
    _calculateEstimatedDuration(); // Calculate the estimated audio duration
  }

  Future<void> _setupTTS() async {
    await flutterTts.setLanguage("en-US"); // Set the language
    await flutterTts.setSpeechRate(0.5);   // Set speech rate (adjust as needed)
    await flutterTts.setPitch(1.0);        // Set the pitch of the voice

    // Start listening to the onComplete event to stop the timer
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
        _stopProgress();
      });
    });
  }

  // Calculate the estimated duration of the speech based on word count and speech rate
  void _calculateEstimatedDuration() {
    double speechRate = 0.5; // Keep it consistent with the set speech rate
    double estimatedSeconds = _estimateSpeechDuration(widget.responseText, speechRate);
    setState(() {
      totalDuration = Duration(seconds: estimatedSeconds.toInt());
    });
  }

  double _estimateSpeechDuration(String text, double speechRate) {
    int wordCount = text.split(' ').length;
    double wordsPerSecond = speechRate * 2.5; // Approximation: 2.5 words per second
    return wordCount / wordsPerSecond;
  }

  // Method to play the generated affirmation text
  Future<void> _speak() async {
    if (widget.responseText.isNotEmpty) {
      var result = await flutterTts.speak(widget.responseText);
      if (result == 1) {
        setState(() => isPlaying = true);
        _startProgress(); // Start updating the progress bar
      }
    }
  }

  // Method to stop the speech and progress
  Future<void> _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) {
      setState(() => isPlaying = false);
      _stopProgress(); // Stop updating the progress bar
    }
  }

  // Start the progress bar timer
  void _startProgress() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (currentDuration < totalDuration) {
          currentDuration += Duration(seconds: 1);
        } else {
          _stopProgress(); // Stop the timer when the duration is completed
        }
      });
    });
  }

  // Stop the progress bar timer
  void _stopProgress() {
    _timer?.cancel();
  }

  void _playPause() {
    if (isPlaying) {
      _stop(); // Stop if currently playing
    } else {
      _speak(); // Play the affirmation text
    }
  }

  // Helper function to format the duration for the sound bar
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void _skipForward() {
    setState(() {
      currentDuration += const Duration(seconds: 5);
      if (currentDuration > totalDuration) currentDuration = totalDuration;
    });
  }

  void _skipBackward() {
    setState(() {
      currentDuration -= const Duration(seconds: 5);
      if (currentDuration < Duration.zero) currentDuration = Duration.zero;
    });
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
        backgroundColor: const Color(0xffFAFDFF),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
                  ),
                  const Text(
                    'Appearance',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff0F1117)),
                  ),
                  const SizedBox(width: 35), // Invisible box for symmetry
                ],
              ),
              const SizedBox(height: 20),

              // Image Section
              CircleAvatar(
                radius: 110,
                backgroundImage: const AssetImage('images/Group15.png'), // Assuming image path is correct
              ),

              const SizedBox(height: 20),

              // Text Response Box
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffFFFFFF),
                  border: Border.all(color: const Color(0xff0F1117).withOpacity(0.2)),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.responseText, // Display the GPT response here
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10.0,
                children: [
                  _buildNarratorButton("Female", false),
                  _buildNarratorButton("Male", true),  // Disabled button
                  _buildNarratorButton("My Voice", true),  // Disabled button
                ],
              ),

              const SizedBox(height: 20),

              // Sound Bar for progress and skip controls
              Slider(
                value: currentDuration.inSeconds.toDouble(),
                min: 0.0,
                max: totalDuration.inSeconds.toDouble(),
                activeColor: Colors.deepPurple,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    currentDuration = Duration(seconds: value.toInt());
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(currentDuration)),
                    Text(_formatDuration(totalDuration)),
                  ],
                ),
              ),

              // Play/Pause and Skip controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.replay_5),
                    iconSize: 36.0,
                    color: Colors.deepPurple,
                    onPressed: _skipBackward,
                  ),
                  IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    iconSize: 36.0,
                    color: Colors.deepPurple,
                    onPressed: _playPause,
                  ),
                  IconButton(
                    icon: const Icon(Icons.forward_5),
                    iconSize: 36.0,
                    color: Colors.deepPurple,
                    onPressed: _skipForward,
                  ),
                ],
              ),
            ],
          ),
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
