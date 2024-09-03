import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final FontWeight fontWeight;
  final double? height;
  final double? width;
  final IconData? icon; 

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.bold,
    this.height,
    this.width,
    this.icon, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: textColor,
                size: fontSize,
              ),
              const SizedBox(width: 8.0), 
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
