import 'package:flutter/material.dart';

class AmenitiesList extends StatelessWidget {
  final String imageUrl;
  final String text;
  final VoidCallback onTap;

  const AmenitiesList({
    super.key,
    required this.imageUrl,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
