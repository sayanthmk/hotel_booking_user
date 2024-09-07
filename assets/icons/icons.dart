import 'package:flutter/material.dart';

Widget? _buildPrefixIcon() {
  // You can add logic here to determine which widget to return
  return Padding(
    padding: const EdgeInsets.all(8.0), // Adjust padding as needed
    child: Image.asset(
      'assets/indian_flag.png', // Path to your flag image
      width: 30, // Adjust the width as needed
      height: 20, // Adjust the height as needed
    ),
  );
}
