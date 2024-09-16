// File: screens/forgot_password.dart

import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isEmailSelected = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _emailError;
  String? _phoneError;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _validatePhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^\+\d{1,3}\d{4,14}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  void _handleRecovery() {
    setState(() {
      if (isEmailSelected) {
        if (_validateEmail(_emailController.text)) {
          _emailError = null;
          // Implement recovery logic using email
          Navigator.of(context).pushNamed('HomeScreen'); // Example navigation
        } else {
          _emailError = 'Please enter a valid email address';
        }
      } else {
        if (_validatePhoneNumber(_phoneController.text)) {
          _phoneError = null;
          // Implement recovery logic using phone number
          Navigator.of(context).pushNamed('HomeScreen'); // Example navigation
        } else {
          _phoneError = 'Invalid phone number';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Recover your password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Choose a method to recover your password.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isEmailSelected = true;
                          _emailError = null;
                          _phoneError = null;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isEmailSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            color: isEmailSelected ? Colors.black : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isEmailSelected = false;
                          _emailError = null;
                          _phoneError = null;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: !isEmailSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                            color: !isEmailSelected ? Colors.black : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (isEmailSelected) ...[
              const Text(
                'Enter your registered email address',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  isDense: true,
                  errorText: _emailError,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ] else ...[
              const Text(
                'Enter your registered phone number',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.phone),
                  isDense: true,
                  errorText: _phoneError,
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _handleRecovery,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Recover Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }
}
