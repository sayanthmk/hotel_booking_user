import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';
import 'package:hotel_booking/utils/custom_appbar/custom_appbar.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

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

    return Scaffold(
      appBar: const BookingAppbar(
        heading: 'Location',
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return Stack(
            children: [
              // Checking if the state is LocationLoaded and displaying the map
              if (state is LocationLoaded)
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: state.position,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('currentLocation'),
                      position: state.position,
                      infoWindow: const InfoWindow(title: 'Current Location'),
                    ),
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  mapType: MapType.normal,
                ),
              // Default map centered at a default location if state is not LocationLoaded
              if (state is! LocationLoaded)
                const GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 2,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: true,
                  mapType: MapType.normal,
                ),
              // If the state is loading, show a loading indicator
              if (state is LocationLoading)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Colors.black26,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              // If the state is an error, show the error widget
              if (state is LocationError)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state
                                  .message, // Make sure to use state.message here
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: () {
                              context
                                  .read<LocationBloc>()
                                  .add(const FetchCurrentLocationEvent());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
        },
        backgroundColor: HotelBookingColors.basictextcolor,
        foregroundColor: HotelBookingColors.white,
        child: const Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }
}
