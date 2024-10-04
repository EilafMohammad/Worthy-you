import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worthy_you/extensions/map_extentions.dart';
import 'package:worthy_you/screens/chatbot/chat_bot_intro_screen.dart';
import 'package:worthy_you/screens/quiz/specific/speech_text_screen.dart';
import 'package:worthy_you/screens/quiz/take_a_quiz.dart';
import 'package:worthy_you/utils/DimLoadingDialog.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

import '../../utils/pref_utils.dart';
import '../profile/ProfileScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String name="N/A";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var listMeditationPaths = [
    "Appearance",
    "Social Acceptance",
    "Academic Performance",
    "Career Competence"
  ];
  @override
  void initState() {
    _loadUserData();
    getUserRecords();
    super.initState();
  }
  void _loadUserData() async {
    String? userName = await MyPrefUtils.getString(MyPrefUtils.userName);
    setState(() {
      name = userName ?? ''; // Update the state with the retrieved name
    });
  }
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
                        "Welcome $name!",
                        style: Styles.subHeadingStyle
                            .copyWith(color: MyColors.colorBlack),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(ProfileScreen.tag);
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
                children: listMeditationPaths.map((val) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: ActionChip(
                      backgroundColor: MyColors.colorWhite,
                      label: Text(
                        val,
                        style: Styles.textStyle.copyWith(fontSize: 14),
                      ),
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              color: MyColors.colorBlack, width: 0.5),
                          borderRadius:
                          BorderRadius.all(Radius.circular(25.0))),
                      onPressed: () {
                        var index = listMeditationPaths.indexOf(val);
                        switch (index) {
                          case 0:
                            {
                              var args = {
                                "title": Constants.labelAppearance,
                                "heading": Constants.infoAppearance,
                                "image": "images/icon_appearance.png"
                              };
                              Get.toNamed(SpeechToTextScreen.tag,
                                  arguments: args);
                            }
                          case 1:
                            {
                              var args = {
                                "title": Constants.labelSocialAcceptance,
                                "heading": Constants.infoSocialAcceptance,
                                "image":
                                "images/icon_social_acceptance.png"
                              };
                              Get.toNamed(SpeechToTextScreen.tag,
                                  arguments: args);
                            }
                          case 2:
                            {
                              var args = {
                                "title":
                                Constants.labelAcademicPerformance,
                                "heading":
                                Constants.infoAcademicPerformance,
                                "image":
                                "images/icon_academic_performance.png"
                              };
                              Get.toNamed(SpeechToTextScreen.tag,
                                  arguments: args);
                            }
                          case 3:
                            {
                              var args = {
                                "title": Constants.labelCareerCompetence,
                                "heading": Constants.infoCareerCompetence,
                                "image":
                                "images/icon_career_competence.png"
                              };
                              Get.toNamed(SpeechToTextScreen.tag,
                                  arguments: args);
                            }
                        }
                      },
                    ),
                  );
                }).toList(),
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

  Future<void> getUserRecords() async {
    if(FirebaseAuth.instance.currentUser?.uid !=null){
      try {
        var userDoc = await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
        if (userDoc.exists) {
          if(userDoc.data()?.containsKey("voice") ==  true){
            var voice = userDoc.data()?.getValueOfKey("voice");
            MyPrefUtils.putString(MyPrefUtils.voiceTemplate, voice);
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching user records: $e');
        }
      }
    }
  }
}
