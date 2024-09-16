import 'package:flutter/material.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

class FirstOnboard extends StatelessWidget {
  const FirstOnboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex:8,child: Image.asset("images/1stonboard.png",fit: BoxFit.cover,),),
        const SizedBox(height: 20.0,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text(
                Constants.titleWelcomeApp,
                style: Styles.titleStyle,
              ),
              SizedBox(height: 10.0,),
              Text(
                Constants.welcomeAppInfo,
                textAlign: TextAlign.center,
                style: Styles.subHeadingStyle,
              ),
            ],
          ),
        )
      ],
    );
  }
}
