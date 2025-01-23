import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/features/location/presentation/pages/loc_name.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Start location updates when the widget is built
    Timer.periodic(const Duration(seconds: 100), (_) {
      if (context.mounted) {
        context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Location'),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.my_location),
          //   onPressed: () {
          //     context
          //         .read<LocationBloc>()
          //         .add(const FetchCurrentLocationEvent());
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LocationNamePage(),
              ));
            },
          ),
        ],
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return Stack(
            children: [
              _buildMap(state),
              if (state is LocationLoading)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Colors.black26,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              if (state is LocationError)
                _buildErrorWidget(context, state.message),
              // if (state is LocationLoaded) _buildAddressWidget(state.position),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
        },
        label: const Text('Update Location'),
        icon: const Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMap(LocationState state) {
    if (state is LocationLoaded) {
      return GoogleMap(
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
      );
    }

    // Default map centered at a default location
    return const GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(0, 0),
        zoom: 2,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      mapType: MapType.normal,
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Positioned(
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
                  message,
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
    );
  }
}

  // Widget _buildAddressWidget(LatLng position) {
  //   return FutureBuilder<String>(
  //     future: _getAddressFromLatLng(position),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Positioned(
  //           bottom: 16,
  //           left: 16,
  //           right: 16,
  //           child: CircularProgressIndicator(),
  //         );
  //       }

  //       if (snapshot.hasError || !snapshot.hasData) {
  //         return const Positioned(
  //           bottom: 16,
  //           left: 16,
  //           right: 16,
  //           child: Text(
  //             'Unable to fetch address',
  //             style: TextStyle(color: Colors.red),
  //           ),
  //         );
  //       }

  //       return Positioned(
  //         bottom: 16,
  //         left: 16,
  //         right: 16,
  //         child: Material(
  //           elevation: 4,
  //           borderRadius: BorderRadius.circular(8),
  //           color: Colors.white,
  //           child: Padding(
  //             padding: const EdgeInsets.all(16),
  //             child: Text(
  //               snapshot.data!,
  //               style: const TextStyle(fontSize: 16),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<String> _getAddressFromLatLng(LatLng position) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );

  //     if (placemarks.isNotEmpty) {
  //       final Placemark place = placemarks.first;
  //       return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
  //     }
  //   } catch (e) {
  //     return 'Failed to get address: $e';
  //   }
  //   return 'Unknown Location';
  // }
