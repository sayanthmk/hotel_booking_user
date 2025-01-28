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

  // static const Color pagebackgroundcolor = Color(0xFFF5F9FF);
  // static const Color basictextcolor = Color(0xFF1E91B6);
  // static Color lighttextcolor = const Color(0xFF1E91B6).withOpacity(0.8);
  // static Color buttoncolor = Color(0xFF1E91B6).withOpacity(0.8);
  static const Color basictextcolor = Color(0xFF7D5A50);
  static const Color pagebackgroundcolor = Color(0xFFFDF6F0);
  static const Color lighttextcolor = Color(0xFF000000);
  static const Color buttoncolor = Color.fromARGB(255, 242, 187, 142);
}

// class ProfileCustomColors {
//   static const Color pagebackgroundcolor = Color(0xFF7D5A50);
//   static const Color basictextcolor = Color(0xFFFDF6F0);
//   static const Color lighttextcolor = Color(0xFF000000);
// }

class ProfileSectionColors {
  static const Color profileprimaryColor = Color(0xFF1E91B6);
  static const Color profilesecondaryColor = Color(0xFFF5F9FF);
  static const Color profileprimaryText = Color(0xFF000000);
  static const Color profileCardBg = Colors.white;
  static const Color accentColor = Color(0xFF00BFA5);
  static const Color warningColor = Color(0xFFFFA726);
}


// class ProfileCustomColors {
//   static const Color primaryColor = Color(0xFF7D5A50);
//   static const Color secondaryColor = Color(0xFFFDF6F0);
//   static const Color primaryText = Color(0xFF000000);
// }