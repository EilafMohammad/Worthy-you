
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worthy_you/screens/onbaording/onboarding_screen.dart';
import 'package:worthy_you/screens/onbaording/signIn/SignInScreen.dart';
import 'package:worthy_you/screens/widget/btn_primary.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

import '../../../utils/DimLoadingDialog.dart';
import '../../../utils/pref_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String tag = "/sign_up_screen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
                  IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        Get.back();
                      },
                      icon: const ImageIcon(
                        AssetImage(
                          "images/back_arrow.png",
                        ),
                        size: 20.0,
                      )),
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
                height: 20,
              ),
              const Text(
                Constants.lblSignUp,
                textAlign: TextAlign.start,
                style: Styles.boldHeading,
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                Constants.lblSignUpInfo,
                textAlign: TextAlign.center,
                style: Styles.normalText,
              ),
              SizedBox(
                height: 20,
              ),
              const Text(
                Constants.lblFullName,
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
                controller: _nameController,
                cursorColor: Colors.black,
                cursorRadius: const Radius.circular(1),
                cursorWidth: 1.5,
                style: Styles.inputFieldTextStyle,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  // Set background color to white
                  errorStyle: const TextStyle(height: 0),
                  hintText: "John Doe",
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
                controller: _emailController,
                cursorColor: Colors.black,
                cursorRadius: const Radius.circular(1),
                cursorWidth: 1.5,
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
                controller: _passwordController,
                cursorColor: Colors.black,
                cursorRadius: const Radius.circular(1),
                cursorWidth: 1.5,
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
                height: 30,
              ),
              PrimaryButton(
                title: Constants.labelRegister,
                backgroundColor: MyColors.btnColorSecondaryDark,
                onPressed: () {
                  // Get.toNamed(HomeScreen.tag);
                  if(_nameController.text.isNotEmpty){
                    if(_emailController.text.isNotEmpty){
                      if(_nameController.text.isNotEmpty){
                        _register();
                      }else{
                        _errorMessage("Please enter password");
                      }
                    }else{
                      _errorMessage("Please enter a valid email");
                    }
                  }else{
                    _errorMessage("Please enter a full name");
                  }
                },
              ),
              SizedBox(height: height*0.2,),
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
                        text: Constants.lblLogIn,
                        style:
                            Styles.inputTitleStyle.copyWith(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(SignInScreen.tag);
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

  Future<void> _register() async {
    var dialog = DimLoadingDialog(context,
        blur: 3,
        dismissable: false,
        backgroundColor: const Color(0x30000000),
        animationDuration: const Duration(milliseconds: 100));
    dialog.show();
    try {
      // Check if the user already exists by email
      QuerySnapshot emailQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: _emailController.text.trim())
          .get();

      if (emailQuery.docs.isNotEmpty) {
        setState(() {
          _errorMessage ("Email already in use.");
        });
        return;
      }

      // Check if the username already exists
      QuerySnapshot usernameQuery = await _firestore
          .collection('users')
          .where('username', isEqualTo: _nameController.text.trim())
          .get();

      if (usernameQuery.docs.isNotEmpty) {
        setState(() {
          _errorMessage ("Username already taken.");
        });
        return;
      }

      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save the username and email in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': _nameController.text.trim(),
        'email': _emailController.text.trim(),

      });

      _showSuccess("Registration successful!");
      await MyPrefUtils.putString(MyPrefUtils.userEmail,_emailController.text);
      await MyPrefUtils.putString(MyPrefUtils.userName,_nameController.text);
      await MyPrefUtils.putString(MyPrefUtils.userId,userCredential.user!.uid);
      await MyPrefUtils.putBool(MyPrefUtils.isLoggedIn,true);
      dialog.dismiss();

      Get.offAllNamed(OnboardingScreen.tag);
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
  String generateUniqueKey(String name) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final uniqueKey = '$name-$timestamp';

    return uniqueKey;
  }

}
