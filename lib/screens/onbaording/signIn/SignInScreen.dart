// File: screens/onboarding_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:worthy_you/screens/home/home_screen.dart';
import 'package:worthy_you/screens/onbaording/onboarding_screen.dart';
import 'package:worthy_you/screens/onbaording/register/SignUpScreen.dart';
import 'package:worthy_you/screens/widget/btn_primary.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

import '../../../utils/DimLoadingDialog.dart';
import '../../../utils/pref_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static String tag = "/sign_in_screen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  _signInWithGoogle() async {
    var dialog = DimLoadingDialog(context,
        blur: 3,
        dismissable: false,
        backgroundColor: const Color(0x30000000),
        animationDuration: const Duration(milliseconds: 100));
    try {
      dialog.show();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      QuerySnapshot emailQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: googleUser.email)
          .get();

      if (emailQuery.docs.isNotEmpty) {
        setState(() {
          _errorMessage("Email already in use.");
        });
      } else {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': googleUser.displayName,
          'email': googleUser.email,
        });
      }
      _showSuccess("Sign-in successful!");

      await MyPrefUtils.putString(
          MyPrefUtils.userEmail, userCredential.user?.email ?? "");
      await MyPrefUtils.putString(
          MyPrefUtils.userName, userCredential.user?.displayName ?? "");
      await MyPrefUtils.putString(MyPrefUtils.userId, userCredential.user!.uid);
      await MyPrefUtils.putBool(MyPrefUtils.isLoggedIn, true);
      await MyPrefUtils.putBool(MyPrefUtils.isGoogleLoggedIn, true);
      dialog.dismiss();
      if (await MyPrefUtils.getBool(MyPrefUtils.isSliderSeen)) {
        Get.offAllNamed(HomeScreen.tag);
      } else {
        Get.offAllNamed(OnboardingScreen.tag);
      }
    } catch (e) {
      dialog.dismiss();

    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  SizedBox(
                    height: 50,
                    child: Image.asset(
                      "images/diamond_cut.png",
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              const Text(
                Constants.lblSignInTOAccount,
                textAlign: TextAlign.start,
                style: Styles.boldHeading,
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                Constants.lblEnterYourEmailAndPassword,
                textAlign: TextAlign.center,
                style: Styles.normalText,
              ),
              SizedBox(
                height: 20,
              ),
              const Text(
                Constants.lblEmail,
                textAlign: TextAlign.center,
                style: Styles.inputTitleStyle,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                onTap: () {},
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                cursorHeight: 24,
                cursorColor: Colors.black,
                cursorRadius: const Radius.circular(1),
                cursorWidth: 1.5,
                controller: _emailController,
                style: Styles.inputFieldTextStyle,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  // Set background color to white
                  errorStyle: const TextStyle(height: 0),
                  hintText: "email@gmail.com",
                  hintStyle: Styles.inputFieldTextHintStyle,

                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300, // Light grey border
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      // Light grey border for enabled state
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, // Active border color
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              const Text(
                Constants.lblSetPassword,
                textAlign: TextAlign.center,
                style: Styles.inputTitleStyle,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                onTap: () {},
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                cursorHeight: 24,
                cursorColor: Colors.black,
                cursorRadius: const Radius.circular(1),
                cursorWidth: 1.5,
                controller: _passwordController,
                style: Styles.inputFieldTextStyle,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  // Set background color to white
                  errorStyle: const TextStyle(height: 0),
                  hintText: "Alpha@123",
                  hintStyle: Styles.inputFieldTextHintStyle,

                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300, // Light grey border
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      // Light grey border for enabled state
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, // Active border color
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.centerRight, // Aligns text to the right
                  child: Text(
                    Constants.lblForgotPassword,
                    textAlign: TextAlign.center,
                    style: Styles.normalText
                        .copyWith(color: MyColors.btnColorSecondaryDark),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              PrimaryButton(
                title: Constants.labelLogInWithSpace,
                backgroundColor: MyColors.btnColorSecondaryDark,
                onPressed: () {
                  if (_emailController.text.isNotEmpty) {
                    if (_passwordController.text.isNotEmpty) {
                      signIn();
                    } else {
                      _errorMessage("Please enter a valid password");
                    }
                  } else {
                    _errorMessage("Please enter a valid email");
                  }
                  // Get.toNamed(HomeScreen.tag);
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Or",
                      textAlign: TextAlign.center,
                      style: Styles.normalText.copyWith(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColors.greyLight, // Border color
                    width: 1, // Border width
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    _signInWithGoogle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 20,
                          child: Image.asset(
                            "images/google.png",
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Constants.lblContinueWithGoogle,
                        textAlign: TextAlign.center,
                        style: Styles.normalText
                            .copyWith(color: MyColors.colorBlack),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColors.greyLight, // Border color
                    width: 1, // Border width
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 20,
                        child: Image.asset(
                          "images/facebook.png",
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Constants.lblContinueWithFacebook,
                      textAlign: TextAlign.center,
                      style:
                          Styles.normalText.copyWith(color: MyColors.colorBlack),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height*0.1,),
              Center(
                child: RichText(
                    text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: Constants.lblAlreadyHaveAccount,
                      style: Styles.inputTitleStyle.copyWith(color: Colors.grey),
                    ),
                    const TextSpan(
                      text: ' ',
                    ),
                    TextSpan(
                        text: Constants.lblSignUpWithSPace,
                        style:
                            Styles.inputTitleStyle.copyWith(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(SignUpScreen.tag);
                          }),
                  ],
                )),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    var dialog = DimLoadingDialog(context,
        blur: 3,
        dismissable: false,
        backgroundColor: const Color(0x30000000),
        animationDuration: const Duration(milliseconds: 100));
    dialog.show();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String name = "N/A";
      final firestore = FirebaseFirestore.instance;

      // Get user document by UID
      DocumentSnapshot userDoc = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      // Check if the document exists
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        name = data['username'] ?? '';
      }

      _showSuccess("Sign-in successful!");

      await MyPrefUtils.putString(MyPrefUtils.userEmail, _emailController.text);
      await MyPrefUtils.putString(MyPrefUtils.userName, name);
      await MyPrefUtils.putString(MyPrefUtils.userId, userCredential.user!.uid);
      await MyPrefUtils.putBool(MyPrefUtils.isLoggedIn, true);
      dialog.dismiss();
      if (await MyPrefUtils.getBool(MyPrefUtils.isSliderSeen)) {
        Get.offAllNamed(HomeScreen.tag);
      } else {
        Get.offAllNamed(OnboardingScreen.tag);
      }
    } catch (e) {
      dialog.dismiss();
      setState(() {
        _errorMessage(e.toString());
      });
    }
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: Styles.normalText.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.green));
  }

  void _errorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: Styles.normalText.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.red));
  }

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    print('User signed out');
  }
}
