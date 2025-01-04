import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/widgets/section_header.dart';
import 'package:hotel_booking/features/report/presentation/pages/report_page.dart';

class Amenities extends StatelessWidget {
  const Amenities({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
      builder: (context, state) {
        if (state is SelectedHotelLoaded) {
          final hotel = state.hotel;

          final List<Map<String, dynamic>> availableAmenities = [
            if (hotel.freeCancel)
              {'name': 'Free Cancellation', 'icon': Icons.cancel},
            if (hotel.coupleFriendly)
              {'name': 'Couple Friendly', 'icon': Icons.favorite},
            if (hotel.parkingFacility)
              {'name': 'Parking Facility', 'icon': Icons.local_parking},
            if (hotel.restaurantFacility)
              {'name': 'Restaurant', 'icon': Icons.restaurant},
          ];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'About the Hotel',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 20),
                SectionHeader(
                  title: 'What This Place Offers',
                  actionText: 'More',
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HotelReportPage(),
                    ));
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: availableAmenities.length,
                    itemBuilder: (context, index) {
                      final amenity = availableAmenities[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: Colors.blue),
                              ),
                              child: Icon(
                                amenity['icon'],
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              amenity['name'],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
