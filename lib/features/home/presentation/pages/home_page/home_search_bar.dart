import 'package:flutter/material.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/widgets/customsearchbar.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSearchBar(
          hintText: 'Search',
          borderColor: HotelBookingColors.basictextcolor,
          hintTextColor: HotelBookingColors.basictextcolor,
          textColor: Colors.green,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
