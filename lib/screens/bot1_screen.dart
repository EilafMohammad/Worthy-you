import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VentingBotScreen1 extends StatefulWidget {
  static const routeName = 'VentingBotScreen1';

  const VentingBotScreen1({super.key});

  @override
  State<VentingBotScreen1> createState() => _VentingBotScreen1State();
}

class _VentingBotScreen1State extends State<VentingBotScreen1> {
  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  // Check if the user has already started a chat before
  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasInteracted = prefs.getBool('hasInteractedWithBot') ?? false;

    // If the user has interacted before, go directly to the chat screen
    if (hasInteracted) {
      Navigator.pushReplacementNamed(context, 'Bot2ChatScreen');
    }
  }

  // When "Start Chat" is pressed for the first time
  Future<void> _startChat() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasInteractedWithBot', true);  // Mark as interacted
    Navigator.pushReplacementNamed(context, 'Bot2ChatScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFAFDFF),
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 180), // Offset for the CircleAvatar
                  Card(
                    color: const Color(0XFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(height: 60), // Offset for overlapping avatar
                          Text(
                            'Hello Nice to see you here! By pressing the "Start chat" button you agree to have your personal data processed as described in our Privacy Policy',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFF667085)),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: _startChat, // Start chat and mark as interacted
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 48, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Start chat',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 210,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.blue[50],
                child: Image.asset(
                  'images/echo_ventingbot.png', // Replace with the image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 10,
              child: Row(
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
                  const SizedBox(
                    width: 90,
                  ),
                  const Text(
                    "Venting Bot",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
