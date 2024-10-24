import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;

  const CustomCircleAvatar({
    super.key,
    required this.onTap,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: const Color.fromARGB(140, 251, 246, 246),
          child: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}
