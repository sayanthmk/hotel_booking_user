import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final Color borderColor;
  final Color hintTextColor;
  final Color textColor;
  final Color backgroundColor;
  final double? width;
  final Function(String) onChanged; // Add the onChanged callback

  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.borderColor,
    required this.hintTextColor,
    required this.textColor,
    required this.backgroundColor,
    this.width,
    required this.onChanged, // Initialize the onChanged parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          onChanged: (value) {
            onChanged(value); // Call the passed onChanged callback
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintTextColor,
            ),
            border: InputBorder.none,
            icon: Icon(
              Icons.search,
              color: hintTextColor,
            ),
          ),
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
