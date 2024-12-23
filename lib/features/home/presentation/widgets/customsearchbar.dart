import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final Color borderColor;
  final Color hintTextColor;
  final Color textColor;
  final Color backgroundColor;
  final double? width;
  final Function(String) onChanged;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.borderColor,
    required this.hintTextColor,
    required this.textColor,
    required this.backgroundColor,
    this.width,
    required this.onChanged,
    this.controller,
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: controller,
          onChanged: (value) {
            onChanged(value);
          },
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: hintTextColor,
              ),
              border: InputBorder.none,
              suffixIcon: InkWell(
                // onTap: icontap,
                onTap: () {
                  controller?.clear();
                  // onChanged('');
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
              ),
              // suffixIcon: Text('Cancel'),
              prefixIcon: const Icon(Icons.search)
              // icon: Icon(
              //   Icons.search,
              //   color: hintTextColor,
              // ),
              ),
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
