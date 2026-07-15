import 'package:flutter/material.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';

class AboutFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const AboutFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 26, color: AppColors.primary),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: AppTextStyles.hotelName,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTextStyles.hotelLocation,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
