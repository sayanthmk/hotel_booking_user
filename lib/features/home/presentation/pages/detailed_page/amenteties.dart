import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/about_the_hotel.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/report/presentation/pages/add_report_page.dart';

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
                const AboutHotel(),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 5.0,
                    top: 10,
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'What This Place Offers',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ReportIssuePage(),
                          ));
                        },
                        child: const Text(
                          '',
                          style: TextStyle(
                            color: HotelBookingColors.basictextcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SectionHeader(
                //   title: 'What This Place Offers',
                //   actionText: '',
                //   ontap: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => const ReportIssuePage(),
                //     ));
                //   },
                // ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: availableAmenities.length,
                    itemBuilder: (context, index) {
                      final amenity = availableAmenities[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 2,
                                    color: HotelBookingColors.basictextcolor),
                              ),
                              child: Icon(
                                amenity['icon'],
                                color: HotelBookingColors.basictextcolor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              amenity['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: HotelBookingColors.basictextcolor,
                              ),
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
