import 'package:flutter/material.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/amenteties.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/floating_action_button.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/hotel_image_box.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/hotel_map.dart';

class HotelDetailPage extends StatelessWidget {
  const HotelDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///hotel image
              HotelImageBox(),
              // Additional hotel details section wiht amentities
              Amenities(),
              //google map
              HotelMap(),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomWideButton(
        label: 'Book Hotel',
        icon: Icons.book_online,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
