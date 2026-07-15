import 'package:flutter/material.dart';
import 'package:hotel_booking/core/validator/validators.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ?? CustomValidator.validateRequired,
      style: AppTextStyles.hotelName.copyWith(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.hotelLocation.copyWith(
          color: AppColors.textGrey,
        ),
        prefixIcon: Container(
          padding: const EdgeInsets.all(12),
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.background, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.background,
      ),
    );
  }
}
