import 'package:flutter/material.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/core/validator/validators.dart';

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
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: ProfileSectionColors.primaryDark.withOpacity(0.6),
        ),
        prefixIcon: Container(
          padding: const EdgeInsets.all(12),
          child: Icon(
            icon,
            color: ProfileSectionColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: ProfileSectionColors.primaryDark.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: ProfileSectionColors.primary,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
