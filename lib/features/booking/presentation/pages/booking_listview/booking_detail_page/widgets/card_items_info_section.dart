import 'package:flutter/material.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';

class BookCardItemsInfoSection extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const BookCardItemsInfoSection({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.hotelLocation),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTextStyles.hotelName.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
