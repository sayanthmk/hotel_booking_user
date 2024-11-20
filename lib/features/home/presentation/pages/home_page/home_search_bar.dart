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
          width: 340,
          hintText: 'Search',
          borderColor: HotelBookingColors.basictextcolor,
          hintTextColor: HotelBookingColors.basictextcolor,
          textColor: HotelBookingColors.basictextcolor,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
