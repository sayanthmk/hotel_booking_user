import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/chatbot/chat_bot.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';

class LocationWithNotificationBar extends StatelessWidget {
  const LocationWithNotificationBar({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 100), (_) {
      if (context.mounted) {
        context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
      }
    });

    return Container(
      height: 70,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: HotelBookingColors.pagebackgroundcolor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Location Section
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Location',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.locationDot,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) {
                        if (state is LocationLoading) {
                          return const Text(
                            'Fetching location...',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: HotelBookingColors.basictextcolor,
                            ),
                          );
                        } else if (state is LocationLoaded) {
                          return FutureBuilder<String>(
                            future: _getAddressFromLatLng(state.position),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text(
                                  'Fetching address...',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: HotelBookingColors.basictextcolor,
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: HotelBookingColors.basictextcolor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                );
                              } else {
                                return const Text(
                                  'Unable to fetch address',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                );
                              }
                            },
                          );
                        } else {
                          return const Text(
                            'Location unavailable',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            // Notification Icon
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HotelBookingChat(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  FontAwesomeIcons.rocketchat,
                  color: HotelBookingColors.basictextcolor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        return '${place.street}';
        // return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      }
    } catch (e) {
      return 'Failed to get address: $e';
    }
    return 'Unknown Location';
  }
}
