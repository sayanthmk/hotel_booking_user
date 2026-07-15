import 'package:flutter/material.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';

class HotelContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const HotelContactInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.hotelLocation),
              const SizedBox(height: 3),
              Text(
                value,
                style: AppTextStyles.hotelName.copyWith(fontSize: 14.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
