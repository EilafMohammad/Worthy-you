import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:worthy_you/extensions/widget_extentions.dart';
import 'package:worthy_you/models/questions_model.dart';
import 'package:worthy_you/screens/quiz/affirmation_categories_screen.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

class QuizResultsScreen extends StatefulWidget {
  static const tag = '/quiz_results_screen';

  const QuizResultsScreen({super.key});

  @override
  State<QuizResultsScreen> createState() => _QuizResultsScreenState();
}

class _QuizResultsScreenState extends State<QuizResultsScreen> {
  List<Option?> _selectedQuestions = [];
  List<Option?> _appearanceList = [];
  List<Option?> _socialAcceptance = [];
  List<Option?> _academicPerformance = [];
  List<Option?> _careerCompetence = [];

  @override
  void initState() {
    super.initState();
    var list = Get.arguments;
    if (list is List<Option?>) {
      _selectedQuestions = list;
      _appearanceList = list.where((item) => item?.catId == 1 && item?.questionId != 0).toList();
      _socialAcceptance = list.where((item) => item?.catId == 2 && item?.questionId != 0).toList();
      _academicPerformance = list.where((item) => item?.catId == 3 && item?.questionId != 0).toList();
      _careerCompetence = list.where((item) => item?.catId == 4 && item?.questionId != 0).toList();
    }
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 20),
              Text(
                Constants.titleQuizResults,
                style: Styles.subHeadingStyle
                    .copyWith(color: MyColors.textColorSecondary),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Text(
                            Constants.labelCareerCompetence,
                          textAlign: TextAlign.right,
                          style: Styles.textStyle.copyWith(fontSize: 12.0),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: LinearPercentIndicator(
                          lineHeight: 30.0,
                          percent: getInsecurityPercentage(list: _careerCompetence),
                          center: Text(
                            "${getInsecurityPercentage(list: _careerCompetence)*100}%",
                            style: Styles.textStyle.copyWith(color: MyColors.colorWhite),
                          ),
                          progressColor: MyColors.progressColor,
                          backgroundColor: MyColors.progressBackground,
                          barRadius: const Radius.circular(15.0),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Text(
                            Constants.labelSocialAcceptance,
                            textAlign: TextAlign.right,
                            style: Styles.textStyle.copyWith(fontSize: 12.0),
                          )),
                      Expanded(
                        flex: 6,
                        child: LinearPercentIndicator(
                          lineHeight: 30.0,
                          percent: getInsecurityPercentage(list: _socialAcceptance),
                          center: Text(
                            "${getInsecurityPercentage(list: _socialAcceptance)*100}%",
                            style: Styles.textStyle
                                .copyWith(color: MyColors.colorWhite),
                          ),
                          progressColor: MyColors.progressColor,
                          backgroundColor: MyColors.progressBackground,
                          barRadius: const Radius.circular(15.0),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Text(
                            Constants.labelAppearance,
                            textAlign: TextAlign.right,
                            style: Styles.textStyle.copyWith(fontSize: 12.0),
                          )),
                      Expanded(
                        flex: 6,
                        child: LinearPercentIndicator(
                          lineHeight: 30.0,
                          percent: getInsecurityPercentage(list: _appearanceList),
                          center: Text(
                            "${getInsecurityPercentage(list: _appearanceList)*100}%",
                            style: Styles.textStyle
                                .copyWith(color: MyColors.colorWhite),
                          ),
                          progressColor: MyColors.progressColor,
                          backgroundColor: MyColors.progressBackground,
                          barRadius: const Radius.circular(15.0),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Text(
                            Constants.labelAcademicPerformance,
                            textAlign: TextAlign.right,
                            style: Styles.textStyle.copyWith(fontSize: 12.0),
                          )),
                      Expanded(
                        flex: 6,
                        child: LinearPercentIndicator(
                          lineHeight: 30.0,
                          percent: getInsecurityPercentage(list: _academicPerformance),
                          center: Text(
                            "${getInsecurityPercentage(list: _academicPerformance)*100}%",
                            style: Styles.textStyle
                                .copyWith(color: MyColors.colorWhite),
                          ),
                          progressColor: MyColors.progressColor,
                          backgroundColor: MyColors.progressBackground,
                          barRadius: const Radius.circular(15.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: MyColors.resultsCardColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Constants.labelNextStep,
                          style: Styles.subHeadingStyle
                              .copyWith(color: MyColors.colorWhite),
                        ),
                        Text(
                          Constants.labelListenPersonalizedAffirmations,
                          style: Styles.textStyleBold
                              .copyWith(color: MyColors.colorWhite),
                        ),
                        Text(
                          Constants.labelListenPersonalizedAffirmationsInfo,
                          style: Styles.textStyleBold
                              .copyWith(color: MyColors.colorWhite),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Get.toNamed(AffirmationCategoriesScreen.tag);
                    },
                    icon: const ImageIcon(
                      AssetImage(
                        "images/icon_back.png",
                      ),
                      size: 30.0,
                    ),
                    color: MyColors.colorWhite,
                  ).rotate(degrees: 180),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  getSum({required List<Option?> list}){
    int sum = list
        .map((item) => item?.optionId ?? 0)
        .map((optionId) => optionId % 10)          // Get the last digit of each optionId
        .fold(0, (prev, current) => prev + current); // Sum the last digits

    if (kDebugMode) {
      print("Sum of last digits--------->: $sum");
    }
    return sum;
  }

  getInsecurityPercentage({required List<Option?> list}){
    var jsonList = list.map((item) => item?.toJson()).toList();
    jsonEncode(jsonList);
    if (kDebugMode) {
      print("Encode------------->${jsonEncode(jsonList)}");
    }
    var sum = getSum(list: list);
    var insecurityPercentage = (sum - 5)/(20-5);
    if (kDebugMode) {
      print("Sum of last digits--------->: $sum");
    }

    if(insecurityPercentage>1){
      insecurityPercentage = 1.0;
    }
    return double.parse(insecurityPercentage.toStringAsFixed(2));
  }
}
