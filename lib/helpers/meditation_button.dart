import 'package:flutter/material.dart';

Widget buildMeditationButton({
  required String title,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade300),
        backgroundColor: Color(0XFFFFFFFF),

      ),
      child: Text(title,style: TextStyle(color: Color(0Xff6C717B)),),
    ),
  );
}
