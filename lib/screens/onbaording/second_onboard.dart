// File: screens/second_onboard.dart

import 'package:flutter/material.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

class SecondOnboard extends StatelessWidget {
  const SecondOnboard({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width*0.1),
              child: Image.asset('images/2ndonboard.png', fit: BoxFit.contain,),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  Constants.titleDiagnoseInsecurities,
                  style: Styles.titleStyle,
                ),
                SizedBox(height: 10.0,),
                Text(
                  Constants.titleDiagnoseInsecuritiesInfo,
                  textAlign: TextAlign.center,
                  style: Styles.subHeadingStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
