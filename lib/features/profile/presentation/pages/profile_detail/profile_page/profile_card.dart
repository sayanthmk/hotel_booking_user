import 'package:flutter/material.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';

class CustDivider extends StatelessWidget {
  const CustDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.background,
      height: 1,
      thickness: 1.5,
      indent: 62,
      endIndent: 16,
    );
  }
}

class ProfileCardWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final Color labelColor;
  final Color valueColor;

  const ProfileCardWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    this.labelColor = AppColors.textGrey,
    this.valueColor = AppColors.textDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.hotelLocation.copyWith(
                    color: labelColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.hotelName.copyWith(
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
