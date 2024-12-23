import 'package:flutter/material.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/core/validator/validators.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/textfrom_field.dart';

class BookingCustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const BookingCustomFormField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: HotelBookingColors.basictextcolor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: controller,
          labelText: label,
          hintText: 'Enter $label',
          keyboardType: keyboardType ?? TextInputType.text,
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: CustomValidator.validateRequired,
          borderColor: Colors.grey.shade300,
          focusedBorderColor: HotelBookingColors.basictextcolor,
          enabledBorderColor: Colors.grey.shade300,
          errorBorderColor: Colors.red.shade300,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
