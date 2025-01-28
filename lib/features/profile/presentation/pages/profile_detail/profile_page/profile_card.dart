import 'package:flutter/material.dart';
import 'package:hotel_booking/core/constants/colors.dart';

class CustDivider extends StatelessWidget {
  const CustDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ProfileSectionColors.primaryDark.withOpacity(0.1),
      height: 1,
      thickness: 1,
      indent: 16,
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
    this.labelColor = const Color(0xFF757575),
    this.valueColor = const Color(0xFF212121),
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
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: labelColor.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
