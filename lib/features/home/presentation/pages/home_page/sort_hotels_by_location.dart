import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';

class SortHotelsByLocation extends StatelessWidget {
  const SortHotelsByLocation({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      const Duration(seconds: 100),
      (_) {
        if (context.mounted) {
          context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
        }
      },
    );

    final List<Map<String, String>> locations = [
      {'image': 'assets/images/mumbai_hotel.jpg', 'text': 'Mumbai'},
      {'image': 'assets/images/dehi.jpeg', 'text': 'Delhi'},
      {'image': 'assets/images/kolkata.jpg', 'text': 'Kolkata'},
      {'image': 'assets/images/chennai.jpg', 'text': 'Chennai'},
      {'image': 'assets/images/banglore.jpg', 'text': 'Bangalore'},
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 110,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];
            return GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        location['image']!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      location['text']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    // BlocBuilder<LocationBloc, LocationState>(
                    //   builder: (context, state) {
                    //     if (state is LocationLoading) {
                    //       return const Text(
                    //         'Fetching location...',
                    //         style: TextStyle(
                    //           fontSize: 17,
                    //           fontWeight: FontWeight.w600,
                    //           color: Colors
                    //               .grey, // Replace with HotelBookingColors.basictextcolor if defined
                    //         ),
                    //       );
                    //     } else if (state is LocationLoaded) {
                    //       return FutureBuilder<String>(
                    //         future: _getAddressFromLatLng(state.position),
                    //         builder: (context, snapshot) {
                    //           if (snapshot.connectionState ==
                    //               ConnectionState.waiting) {
                    //             return const Text('Loading...');
                    //           } else if (snapshot.hasError) {
                    //             return const Text('Failed to fetch location');
                    //           } else {
                    //             return Text(
                    //               snapshot.data ?? 'Unknown Location',
                    //               style: const TextStyle(
                    //                   fontSize: 14, color: Colors.black),
                    //             );
                    //           }
                    //         },
                    //       );
                    //     }
                    //     return const Text(
                    //       'Location not available',
                    //       style: TextStyle(fontSize: 14, color: Colors.red),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Future<String> _getAddressFromLatLng(LatLng position) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );

  //     if (placemarks.isNotEmpty) {
  //       final Placemark place = placemarks.first;
  //       return place.locality ?? 'Unknown Location';
  //     }
  //   } catch (e) {
  //     return 'Failed to get address: $e';
  //   }
  //   return 'Unknown Location';
  // }
}
