import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Color dividerColor;
  final double thickness;
  final double indent;
  final double endIndent;

  const DividerWithText({
    super.key,
    required this.text,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.bold,
    this.textColor = Colors.blue,
    this.dividerColor = Colors.blue,
    this.thickness = 2.0,
    this.indent = 10.0,
    this.endIndent = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: thickness,
            endIndent: endIndent,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: thickness,
            indent: indent,
          ),
        ),
      ],
    );
  }
}
