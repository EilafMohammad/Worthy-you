// File: screens/first_registration.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:worthy_you/screens/forgot_password.dart'; // Import the ForgotPassword screen

class FirstRegistration extends StatefulWidget {
  const FirstRegistration({super.key});

  @override
  _FirstRegistrationState createState() => _FirstRegistrationState();
}

class _FirstRegistrationState extends State<FirstRegistration> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isSignUpSelected = true;
  String? firstNameError;
  String? lastNameError;
  String? emailError;
  String? phoneError;
  String? passwordError;
  String selectedCountryCode = '+1';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _validateFields() {
    setState(() {
      firstNameError = _firstNameController.text.isEmpty ||
          RegExp(r'^\d').hasMatch(_firstNameController.text)
          ? 'First name must start with a letter'
          : null;
      lastNameError = _lastNameController.text.isEmpty ||
          RegExp(r'^\d').hasMatch(_lastNameController.text)
          ? 'Last name must start with a letter'
          : null;
      emailError = _emailController.text.isEmpty ||
          !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text)
          ? 'Please enter a valid email address'
          : null;
      phoneError = _phoneController.text.isEmpty ||
          !RegExp(r'^\d+$').hasMatch(_phoneController.text)
          ? 'Invalid phone number'
          : null;
      passwordError = _passwordController.text.isEmpty ||
          _passwordController.text.length < 8 ||
          !RegExp(r'[A-Z]').hasMatch(_passwordController.text) ||
          !RegExp(r'[0-9]').hasMatch(_passwordController.text)
          ? 'Password must be at least 8 characters, include a number, an uppercase letter, and a lowercase letter'
          : null;
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
        title: const SizedBox.shrink(), // Removing default title
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Wrap the logo in a SizedBox to control its size
            SizedBox(
              height: 100, // Adjusted height
              width: 100,  // Adjusted width
              child: Image.asset(
                'images/diamond.png', // Replace with your logo path
                fit: BoxFit.contain, // Adjust image scaling behavior
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Get Started now',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Create an account or log in to explore\nabout our app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Custom Toggle Buttons using GestureDetector and AnimatedContainer
            Container(
              width: 300,
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
                          isSignUpSelected = true;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isSignUpSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: isSignUpSelected ? Colors.black : Colors.grey,
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
                          isSignUpSelected = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: !isSignUpSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: !isSignUpSelected ? Colors.black : Colors.grey,
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
            Expanded(
              child: ListView(
                children: [
                  if (isSignUpSelected) ...[
                    // Fields for Sign Up
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'First Name',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              const SizedBox(height: 5),
                              TextField(
                                controller: _firstNameController,
                                onChanged: (_) => _validateFields(),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  isDense: true,
                                  errorText: firstNameError,
                                ),
                              ),
                              const SizedBox(height: 5), // Space for error message
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Last Name',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              const SizedBox(height: 5),
                              TextField(
                                controller: _lastNameController,
                                onChanged: (_) => _validateFields(),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  isDense: true,
                                  errorText: lastNameError,
                                ),
                              ),
                              const SizedBox(height: 5), // Space for error message
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _emailController,
                      onChanged: (_) => _validateFields(),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        errorText: emailError,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 5), // Space for error message
                    const SizedBox(height: 20),
                    const Text(
                      'Birth of date',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _birthDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Phone Number',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: selectedCountryCode,
                          items: <String>['+1', '+91', '+44', '+966'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCountryCode = newValue!;
                            });
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            onChanged: (_) => _validateFields(),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              errorText: phoneError,
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5), // Space for error message
                    const SizedBox(height: 20),
                    const Text(
                      'Set Password',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _passwordController,
                      onChanged: (_) => _validateFields(),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: Icon(Icons.visibility_off),
                        isDense: true,
                        errorText: passwordError,
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 5), // Space for error message
                  ] else ...[
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _emailController,
                      onChanged: (_) => _validateFields(),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        errorText: emailError,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 5), // Space for error message
                    const SizedBox(height: 20),
                    const Text(
                      'Password',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _passwordController,
                      onChanged: (_) => _validateFields(),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: Icon(Icons.visibility_off),
                        isDense: true,
                        errorText: passwordError,
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 5), // Space for error message
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const ForgotPassword()),
                          ); // Navigate to ForgotPassword screen
                        },
                        child: const Text(
                          'Forgot your password?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      _validateFields();
                      if (firstNameError == null &&
                          lastNameError == null &&
                          emailError == null &&
                          phoneError == null &&
                          passwordError == null) {
                        // Navigate to HomeScreen if all fields are valid
                        Navigator.of(context).pushNamed('HomeScreen');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50), // Full-width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      isSignUpSelected ? 'Register' : 'Login',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Bottom padding
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
