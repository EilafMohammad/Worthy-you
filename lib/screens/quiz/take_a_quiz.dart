import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worthy_you/screens/quiz_path_screen.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

class QuizScreen extends StatefulWidget {
  static const tag = '/quiz_screen';
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final List<String> _questions = [
    "When you feel self-conscious, which of the following aspects do you often focus on the most? (you can select multiple)",
    "How do societal beauty standards influence your perception of your own appearance?",
    "When you look in the mirror, what specific features or aspects of your appearance do you feel most dissatisfied with?",
    "In social settings, what specific behaviors or situations trigger feelings of insecurity or rejection?"
  ];

  final List<List<String>> _options = [
    [
      "My physical appearance",
      "How others perceive me socially",
      "My academic performance or intelligence",
      "My abilities and skills in various areas"
    ],
    [
      "I constantly compare myself to unrealistic beauty standards portrayed in the media.",
      "I feel pressured to conform to certain beauty ideals in order to feel accepted or attractive.",
      "I recognize that beauty comes in diverse forms, but I still struggle with accepting my own appearance.",
    ],
    [
      "Facial features (e.g., nose, eyes, skin)",
      "Body shape or size (e.g., weight, height)",
      "Hair (e.g., style, texture)",
      "Overall physical condition (e.g., fitness level, health)"
    ],
    [
      "Being excluded or left out of social gatherings or conversations",
      "Receiving negative feedback or criticism from peers",
      "Feeling like I don't belong or fit in with certain social groups",
      "Comparing myself unfavorably to others in terms of popularity or social status"
    ],
  ];

  void _onOptionSelected() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      Get.toNamed(QuizResultsScreen.tag);
    }
  }

  double get _progress {
    return (_currentQuestionIndex + 1) / _questions.length;
  }

  @override
  Widget build(BuildContext context) {
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
          elevation: 0,
          title: const Text(
            Constants.labelFiguringInsecurities,
            style: Styles.subHeadingStyle,
          ),
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
                _questions[_currentQuestionIndex],
                style: Styles.questionStyle,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                      children: _options[_currentQuestionIndex].map((option) {
                        return GestureDetector(
                          onTap: _onOptionSelected,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: double.maxFinite,
                              margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              decoration: BoxDecoration(
                                color: MyColors.colorWhite,
                                border: Border.all(color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  option,
                                  style: Styles.questionStyle.copyWith(color: MyColors.textColorPurple),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (_currentQuestionIndex > 0) {
                          _currentQuestionIndex--;
                        }
                      });
                    },
                    child: const Text(
                      Constants.labelBack,
                      style: Styles.buttonTextStyle,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      if (_currentQuestionIndex < (_questions.length - 1)) {
                        setState(() {
                          _currentQuestionIndex++;
                        });
                      }
                    },
                    child: const Text(
                      Constants.labelNext,
                      style: Styles.buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



