import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worthy_you/screens/audio_play_screen.dart';
import 'package:worthy_you/screens/chatbot/chat_bot_intro_screen.dart';
import 'package:worthy_you/screens/quiz/take_a_quiz.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var listMeditationPaths = [
    "Appearance",
    "Academic Performance",
    "Acceptance",
    "Competence"
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Opacity(
                  opacity: 0,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/profile.png'),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('images/icon_worthy.png'),
                        height: 40.0,
                      ),
                      Text(
                        Constants.labelWelcomEliaf,
                        style: Styles.subHeadingStyle
                            .copyWith(color: MyColors.colorBlack),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AudioPlayScreen.tag);
                  },
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/profile.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              Constants.titleCraftingPersonalizedAffirmations,
              style: Styles.textStyleBold,
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(QuizScreen.tag);
              },
              child: Image.asset("images/take_a_general_quiz.png"),
            ),
            const SizedBox(height: 10),
            const Text(
              Constants.titleMeditationPaths,
              style: Styles.textStyleBold,
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: listMeditationPaths.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: ActionChip(
                      backgroundColor: MyColors.colorWhite,
                      label: Text(
                        item,
                        style: Styles.textStyle.copyWith(fontSize: 14),
                      ),
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              color: MyColors.colorBlack, width: 0.5),
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      onPressed: () {},
                    ),
                  );
                }).toList(),
                // children: [
                //   Chip(label: Text("Appearance")),
                //   buildMeditationButton(
                //       title: 'Appearance',
                //       onPressed: () {
                //         Navigator.pushNamed(context, 'AppearanceScreen');
                //       }),
                //   buildMeditationButton(
                //       title: 'Academic Performance', onPressed: () {}),
                //   buildMeditationButton(title: 'Acceptance', onPressed: () {}),
                //   buildMeditationButton(title: 'Competence', onPressed: () {}),
                // ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 160,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.4,
                    child: GestureDetector(
                      onTap: (){
                        Get.toNamed(ChatBotIntroScreen.tag);
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                "images/echo.jpg",
                                width: width * 0.4,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                      MyColors.titleBlueColor
                                    ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)),
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  Constants.labelEcho,
                                  style: Styles.textStyleBold
                                      .copyWith(color: MyColors.colorWhite),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              "images/book_a_session.png",
                              fit: BoxFit.cover,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                    MyColors.titleBlueColor
                                  ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                Constants.labelBookSession,
                                style: Styles.textStyleBold
                                    .copyWith(color: MyColors.colorWhite),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.maxFinite,
              height: 180,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: const DecorationImage(fit: BoxFit.cover, image: AssetImage('images/icon_creative_visualization.png')),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Creative Visualization',
                    style: Styles.headingStyle.copyWith(color: MyColors.colorWhite),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'You, your future,\nare a result of your\nbelieves. Reset your\nmindset to live a \nbreakthrough.',
                    style: Styles.textStyle.copyWith(fontSize: 14,color: MyColors.colorWhite),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
