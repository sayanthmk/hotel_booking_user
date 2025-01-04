import 'package:flutter/material.dart';
import 'package:hotel_booking/core/constants/colors.dart';

class BookingAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String heading;
  const BookingAppbar({
    required this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        heading,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      centerTitle: true,
      backgroundColor: HotelBookingColors.basictextcolor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
