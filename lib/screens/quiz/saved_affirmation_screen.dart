import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worthy_you/screens/audioPlay_appearence_screen.dart';
import 'package:worthy_you/screens/quiz/specific/speech_text_screen.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/pref_utils.dart';
import 'package:worthy_you/utils/styles.dart';

import '../../utils/DimLoadingDialog.dart';

class SavedAffirmationScreen extends StatefulWidget {
  static const tag = '/saved_affirmation_screen';
  const SavedAffirmationScreen({super.key});

  @override
  State<SavedAffirmationScreen> createState() =>
      _SavedAffirmationScreenState();
}

class _SavedAffirmationScreenState
    extends State<SavedAffirmationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String responseText = "N/A";

  bool isFromResult = isFromResultScreen();
  List<Map<String, dynamic>> recordsList = [];

  // List of image assets
  final List<Map> imagePaths = [
    {
      "id": "Academic Performance",
      "img": 'images/Playlist 6.png',
    },
    {
      "id": "Appearance",
      "img": 'images/playlist8.png',
    },
    {
      "id": "Career Competence",
      "img": 'images/img.png',
    },
    {
      "id": "Social Acceptance",
      "img": 'images/Playlist 7.png',
    }
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        getUserRecords(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        elevation: 0,
        backgroundColor: MyColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constants.titleAffirmationsCategories,
              style: Styles.subHeadingStyle
                  .copyWith(color: MyColors.textColorSecondary),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    Constants.infoAffirmationsCategories,
                    style: Styles.textStyle.copyWith(fontSize: 14.0),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('images/Frame 10.png'),
                    ),
                  ),
                ), // Image on the right side
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey), // Divider below the text
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        if (recordsList.where((item)=> (item["id"] == imagePaths[index]['id'])).isNotEmpty) {
                          var quizValue = recordsList.firstWhere((item) => item["id"] == imagePaths[index]['id']);


                          Get.toNamed(AudioPlayerAppearanceScreen.tag,
                              arguments: {
                                "text": quizValue["text"],
                                "category": Constants.labelCareerCompetence,
                                "data": jsonDecode(quizValue["response_data"])
                              });
                        }



                        /*// Get.toNamed(AudioPlayerAppearanceScreen.tag);
                        switch (index) {
                          case 0:
                            {
                              var args = {
                                "title": Constants.labelAppearance,
                                "heading": Constants.infoAppearance,
                                "image": "images/icon_appearance.png"
                              };
                              // Get.toNamed(SpeechToTextScreen.tag,
                              //     arguments: args);

                              responseText = "";
                              getUserVoice(Constants.labelAppearance, context)
                                  .then((val) {
                                if (responseText.isNotEmpty) {
                                  Get.toNamed(AudioPlayerAppearanceScreen.tag,
                                      arguments: {
                                        "text": responseText,
                                        "category": Constants.labelAppearance,
                                        "data": jsonDecode(val ?? "")
                                      });
                                } else {
                                  Get.toNamed(SpeechToTextScreen.tag,
                                      arguments: args);
                                }
                              });
                            }
                          case 1:
                            {
                              var args = {
                                "title": Constants.labelSocialAcceptance,
                                "heading": Constants.infoSocialAcceptance,
                                "image": "images/icon_social_acceptance.png"
                              };
                              // Get.toNamed(SpeechToTextScreen.tag,
                              //     arguments: args);

                              responseText = "";
                              getUserVoice(
                                      Constants.labelSocialAcceptance, context)
                                  .then((val) {
                                if (responseText.isNotEmpty) {
                                  Get.toNamed(AudioPlayerAppearanceScreen.tag,
                                      arguments: {
                                        "text": responseText,
                                        "category":
                                            Constants.labelSocialAcceptance,
                                        "data": jsonDecode(val ?? "")
                                      });
                                } else {
                                  Get.toNamed(SpeechToTextScreen.tag,
                                      arguments: args);
                                }
                              });
                            }
                          case 2:
                            {
                              var args = {
                                "title": Constants.labelAcademicPerformance,
                                "heading": Constants.infoAcademicPerformance,
                                "image": "images/icon_academic_performance.png"
                              };
                              // Get.toNamed(SpeechToTextScreen.tag,
                              //     arguments: args);

                              responseText = "";
                              getUserVoice(Constants.labelAcademicPerformance,
                                      context)
                                  .then((val) {
                                if (responseText.isNotEmpty) {
                                  Get.toNamed(AudioPlayerAppearanceScreen.tag,
                                      arguments: {
                                        "text": responseText,
                                        "category":
                                            Constants.labelAcademicPerformance,
                                        "data": jsonDecode(val ?? "")
                                      });
                                } else {
                                  Get.toNamed(SpeechToTextScreen.tag,
                                      arguments: args);
                                }
                              });
                            }
                          case 3:
                            {
                              var args = {
                                "title": Constants.labelCareerCompetence,
                                "heading": Constants.infoCareerCompetence,
                                "image": "images/icon_career_competence.png"
                              };
                              // Get.toNamed(SpeechToTextScreen.tag,
                              //     arguments: args);

                              responseText = "";
                              getUserVoice(Constants.labelCareerCompetence, context)
                                  .then((val) {
                                if (responseText.isNotEmpty) {
                                  Get.toNamed(AudioPlayerAppearanceScreen.tag,
                                      arguments: {
                                        "text": responseText,
                                        "category": Constants.labelCareerCompetence,
                                        "data": jsonDecode(val ?? "")
                                      });
                                } else {
                                  Get.toNamed(SpeechToTextScreen.tag,
                                      arguments: args);
                                }
                              });
                            }
                        }*/
                      },
                      child: (showIndex(recordsList,index))
                          ? Container(
                              height: 150,
                              width: double.infinity,
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(imagePaths[index]["img"]),
                                  // Use the image path from the list
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            )
                          : Container());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool showIndex(List<Map<String, dynamic>> recordsList, int index) {
    if (recordsList.isEmpty) return false;
    if (recordsList.where((item)=> (item["id"] == imagePaths[index]['id'])).isNotEmpty) {
      var quizValue = recordsList.firstWhere((item) => item["id"] == imagePaths[index]['id']);
      return quizValue["response_data"]!=null;
    }
    return false;
  }

  Future<String?> getUserVoice(
      String competenceId, BuildContext context) async {
    var dialog = DimLoadingDialog(context,
        blur: 3,
        dismissable: false,
        backgroundColor: const Color(0x30000000),
        animationDuration: const Duration(milliseconds: 100));
    dialog.show();
    String userId = await MyPrefUtils.getString(MyPrefUtils.userId);
    try {
      DocumentReference userRef = _firestore.collection('users').doc(userId);
      DocumentSnapshot snapshot =
          await userRef.collection('records').doc(competenceId).get();
      dialog.dismiss();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        String? dataString = data?['response_data'] as String?;
        responseText = (data?['text'] as String?) ?? "";
        return dataString;
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      dialog.dismiss();
      print('Error retrieving voice: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getUserRecords(BuildContext context) async {
    var dialog = DimLoadingDialog(context,
        blur: 3,
        dismissable: false,
        backgroundColor: const Color(0x30000000),
        animationDuration: const Duration(milliseconds: 100));
    dialog.show();
    String userId = await MyPrefUtils.getString(MyPrefUtils.userId);
    try {
      // Fetch records from the user's document
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        // Assuming records are stored in a sub-collection called 'records'
        QuerySnapshot recordsSnapshot =
            await userDoc.reference.collection('records').get();

        // Convert the QuerySnapshot to a list of maps
        List<Map<String, dynamic>> records = recordsSnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
            // Add document data
          };
        }).toList();
        dialog.dismiss();
        setState(() {
          recordsList = records;
        });

        return records;
      } else {
        dialog.dismiss();
        print('User not found');
        return []; // Return an empty list if the user does not exist
      }
    } catch (e) {
      dialog.dismiss();
      print('Error fetching user records: $e');
      return []; // Return an empty list in case of error
    }
  }
}

isFromResultScreen<bool>() {
  if (Get.arguments is String) {
    if (Get.arguments == "isFromResult") {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashHeight;

  DashedLinePainter({required this.color, this.dashHeight = 5});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight * 2;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;


}
