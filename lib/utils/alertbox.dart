import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String titleText;
  final String contentText;
  final String buttonText1;
  final String buttonText2;
  final VoidCallback onPressButton1;
  final VoidCallback onPressButton2;

  const CustomAlertDialog({
    super.key,
    required this.titleText,
    required this.contentText,
    required this.buttonText1,
    required this.buttonText2,
    required this.onPressButton1,
    required this.onPressButton2,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: [
        TextButton(
          onPressed: onPressButton1,
          child: Text(buttonText1),
        ),
        TextButton(
          onPressed: onPressButton2,
          child: Text(buttonText2),
        ),
      ],
    );
  }
}
