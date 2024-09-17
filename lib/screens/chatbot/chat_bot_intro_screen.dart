import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worthy_you/screens/chatbot/chat_bot.dart';
import 'package:worthy_you/screens/widget/btn_primary.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

class ChatBotIntroScreen extends StatefulWidget {
  static const tag = '/bot_intro_screen';

  const ChatBotIntroScreen({super.key});

  @override
  State<ChatBotIntroScreen> createState() => _ChatBotIntroScreenState();
}

class _ChatBotIntroScreenState extends State<ChatBotIntroScreen> {
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
    Get.toNamed(ChatBotScreen.tag);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Expanded(
                    child: Text(
                  Constants.labelVentingBot,
                  textAlign: TextAlign.center,
                  style: Styles.headingStyle,
                )),
                Opacity(
                  opacity: 0,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                )
              ],
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 150.0, right: 20.0, left: 20.0),
                      child: Card(
                        color: const Color(0XFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 50.0, right: 20.0, left: 20.0, bottom: 20.0),
                          child: Text(
                            Constants.chatBotIntroInfo,
                            textAlign: TextAlign.center,
                            style: Styles.textStyle
                                .copyWith(color: MyColors.textColorSecondary),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.blue[50],
                      child: Image.asset(
                        'images/echo_ventingbot.png',
                        // Replace with the image path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin:
                      const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                  child: PrimaryButton(
                    title: Constants.labelGetStarted,
                    backgroundColor: MyColors.btnColorPrimary,
                    onPressed: _startChat,
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
