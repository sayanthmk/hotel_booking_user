import 'package:flutter/material.dart';

class HotelBookingColors {
  //=====auth page=============//
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  static const Color headingblue = Color.fromARGB(255, 31, 19, 249);

  static const LinearGradient primarybuttongradient = LinearGradient(
    colors: [
      Color(0xFF5435FF),
      Color(0xFF36C8F6),
      Color(0xFFA0FBCD),
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  //=================================

  static const Color pagebackgroundcolor = Color(0xFFF5F9FF);
  static const Color basictextcolor = Color(0xFF1E91B6);
  static Color lighttextcolor = const Color(0xFF1E91B6).withOpacity(0.8);
}
