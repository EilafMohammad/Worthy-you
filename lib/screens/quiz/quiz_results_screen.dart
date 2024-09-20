import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:worthy_you/extensions/widget_extentions.dart';
import 'package:worthy_you/screens/quiz/affirmation_categories_screen.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

class QuizResultsScreen extends StatelessWidget {
  static const tag = '/quiz_results_screen';

  const QuizResultsScreen({super.key});
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
                            style:Styles.textStyle.copyWith(fontSize: 12.0),
                          )),
                      Expanded(
                        flex: 6,
                        child: LinearPercentIndicator(
                          lineHeight: 30.0,
                          percent: 0.5,
                          center: Text(
                            "50.0%",
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
                            Constants.labelSocialAcceptance,
                            textAlign: TextAlign.right,
                            style: Styles.textStyle.copyWith(fontSize: 12.0),
                          )),
                      Expanded(
                        flex: 6,
                        child: LinearPercentIndicator(
                          lineHeight: 30.0,
                          percent: 0.5,
                          center: Text(
                            "50.0%",
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
                            Constants.labelAppearance,
                            textAlign: TextAlign.right,
                            style:
                            Styles.textStyle.copyWith(fontSize: 12.0),
                          )),
                      Expanded(
                        flex: 6,
                        child: LinearPercentIndicator(
                          lineHeight: 30.0,
                          percent: 0.5,
                          center: Text(
                            "50.0%",
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
                            style:
                            Styles.textStyle.copyWith(fontSize: 12.0),
                          )),
                      Expanded(
                        flex: 6,
                        child: LinearPercentIndicator(
                          lineHeight: 30.0,
                          percent: 0.5,
                          center: Text(
                            "50.0%",
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
                        Text(Constants.labelNextStep,
                          style: Styles.subHeadingStyle.copyWith(color: MyColors.colorWhite),
                        ),
                        Text(Constants.labelListenPersonalizedAffirmations,
                          style: Styles.textStyleBold.copyWith(color: MyColors.colorWhite),
                        ),
                        Text(Constants.labelListenPersonalizedAffirmationsInfo,
                          style: Styles.textStyleBold.copyWith(color: MyColors.colorWhite),
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
                    ),color: MyColors.colorWhite,).rotate(degrees: 180),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
    }
}


