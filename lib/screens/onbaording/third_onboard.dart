// File: screens/third_onboard.dart

import 'package:flutter/material.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

class ThirdOnboard extends StatelessWidget {
  const ThirdOnboard({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width*0.1),
              child: Image.asset('images/3rdonboard.png',),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Column(
              children: [
                Text(
                  Constants.titlePersonalizedAffirmations,
                  style: Styles.titleStyle,
                ),
                SizedBox(height: 10),
                Text(
                  Constants.titlePersonalizedAffirmationsInfo,
                  textAlign: TextAlign.center,
                  style: Styles.subHeadingStyle,
                ),
              ],
            ),
          ),// Bottom padding
        ],
      ),
    );
  }
}
