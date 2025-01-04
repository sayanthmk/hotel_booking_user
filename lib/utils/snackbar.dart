import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    duration: const Duration(seconds: 3),
    // action: SnackBarAction(
    //   label: 'Undo',
    //   textColor: Colors.yellowAccent,
    //   onPressed: () {
    //     // Undo logic here
    //   },
    // ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
