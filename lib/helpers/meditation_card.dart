import 'package:flutter/material.dart';

Widget buildMeditationCard(String title, String imagePath,  VoidCallback onPressed,) {
  return Expanded(
    child: InkWell(
      onTap: onPressed,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(

            colors: [ Color(0xFFFFFFFF), Color(0xFF253EA7),],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}