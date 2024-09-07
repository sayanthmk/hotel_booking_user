import 'package:flutter/material.dart';

class SignInRow extends StatelessWidget {
  final void Function()? onTap;
  final String signInText;
  final String promptText;
  final Color signInTextColor;
  final TextStyle? promptTextStyle;
  final TextStyle? signInTextStyle;

  const SignInRow({
    super.key,
    required this.onTap,
    required this.signInText,
    required this.promptText,
    required this.signInTextColor,
    this.promptTextStyle,
    this.signInTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: promptTextStyle ?? const TextStyle(color: Colors.black),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            signInText,
            style: signInTextStyle ?? TextStyle(color: signInTextColor),
          ),
        ),
      ],
    );
  }
}
