import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worthy_you/models/questions_model.dart';
import 'package:worthy_you/screens/quiz/quiz_results_screen.dart';
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
  List<Data> _questions = [];
  final List<Option?> _selectedQuestions = [];

  void _onOptionSelected({required Option option}) {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        addItem(option: option);
        _currentQuestionIndex++;
      });
    } else {
      Get.toNamed(QuizResultsScreen.tag,arguments: _selectedQuestions);
    }
  }

  @override
  void initState() {
    super.initState();
    _questions = getAllQuestions();
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
              )
          ),
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _questions[_currentQuestionIndex].question ?? "",
                style: Styles.questionStyle,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                      children: _questions[_currentQuestionIndex].options!.map((option) {
                        return GestureDetector(
                          onTap: (){
                            _onOptionSelected(option: option);
                          },
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
                                  option.option ?? "",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10),
                  value: _progress,
                  backgroundColor: const Color(0XFFD9D9D9),
                  color: const Color(0XFF8367C7),
                  minHeight: 13,
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

  void addItem({required Option option}) {
    Option? existingOption = _selectedQuestions.firstWhere((item) => item?.catId == option.catId &&item?.questionId == option.questionId &&item?.optionId == option.optionId,
      orElse: () => null, // Cast to Option, assuming no match.
    );
    if (existingOption == null) {
      Option? differentOption = _selectedQuestions.firstWhere((item) =>
        item?.catId == option.catId && item?.questionId == option.questionId && item?.optionId != option.optionId,
        orElse: () => null, // Cast to Option for empty case
      );
      if (differentOption != null) {
        var index = _selectedQuestions.indexOf(differentOption);
        _selectedQuestions[index] = option;
      } else {
        _selectedQuestions.add(option);
      }
    }
  }



  double get _progress {
    return (_currentQuestionIndex + 1) / _questions.length;
  }

  List<Data> getAllQuestions() {
    List<Data> allQuestions = [];
    for (var category in Constants.questionsModel.questionsData ?? []) {
      if (category.data != null) {
        allQuestions.addAll(category.data!);
      }
    }
    return allQuestions;
  }
}



