import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/features/location/domain/repos/location_repos.dart';
import 'package:hotel_booking/features/location/presentation/pages/loc_name.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(GetIt.I.get<LocationRepository>())
        ..add(const FetchUserLocationEvent()),
      child: const MapView(),
    );
  }
}

class MapView extends StatelessWidget {
  const MapView({super.key});

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
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              context
                  .read<LocationBloc>()
                  .add(const FetchCurrentLocationEvent());
            },
          ),
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LocationNamePage(),
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
        myLocationButtonEnabled: false,
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

  // Widget _buildActionButton(BuildContext context) {
  //   return FloatingActionButton.extended(
  //     onPressed: () {
  //       context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
  //     },
  //     label: const Text('Update Location'),
  //     icon: const Icon(Icons.location_on),
  //   );
  // }
}
