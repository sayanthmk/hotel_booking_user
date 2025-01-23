import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_booking/features/location/domain/repos/location_repos.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';

class LocationNamePage extends StatelessWidget {
  const LocationNamePage({super.key});

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
    String? address;

    Timer.periodic(const Duration(seconds: 100), (_) {
      if (context.mounted) {
        context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Map View')),
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationLoaded) {
            address = 'Fetching address...';
      
          } else if (state is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          } else if (state is LocationLoaded) {
            address = state.address;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Address: $address')),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: state is LocationLoading
                ? const CircularProgressIndicator()
                : state is LocationLoaded
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Location Details:'),
                          Text(address ?? 'Fetching address...'),
                        ],
                      )
                    : const Text('Press the button to update location.'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}























// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hotel_booking/features/location/domain/repos/location_repos.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';
// import 'package:geocoding/geocoding.dart';

// class LocationNamePage extends StatelessWidget {
//   const LocationNamePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LocationBloc(GetIt.I.get<LocationRepository>())
//         ..add(const FetchUserLocationEvent()),
//       child: const LocationNameView(),
//     );
//   }
// }

// class LocationNameView extends StatelessWidget {
//   const LocationNameView({super.key});

//   Future<String> _getAddressFromLatLng(LatLng position) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       if (placemarks.isNotEmpty) {
//         final place = placemarks.first;
//         return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//       }
//       return "Unknown Location";
//     } catch (e) {
//       return "Error retrieving address";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Current Location'),
//       ),
//       body: BlocBuilder<LocationBloc, LocationState>(
//         builder: (context, state) {
//           if (state is LocationLoaded) {
//             return FutureBuilder<String>(
//               future: _getAddressFromLatLng(state.position),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return const Center(
//                     child: Text('Error retrieving location name'),
//                   );
//                 } else {
//                   return Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Text(
//                         snapshot.data ?? 'Location not available',
//                         style: const TextStyle(fontSize: 18),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   );
//                 }
//               },
//             );
//           } else if (state is LocationLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is LocationError) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       state.message,
//                       style: const TextStyle(color: Colors.red, fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () {
//                         context
//                             .read<LocationBloc>()
//                             .add(const FetchCurrentLocationEvent());
//                       },
//                       child: const Text('Retry'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//           return const Center(
//             child: Text('Press the button to fetch location'),
//           );
//         },
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
// // import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
// // import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';

// // class LocationNamePage extends StatelessWidget {
// //   final LatLng position;

// //   const LocationNamePage({Key? key, required this.position}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Location Name'),
// //       ),
// //       body: BlocProvider(
// //         create: (context) => LocationBloc(context.read())
// //           ..add(FetchAddressFromLatLngEvent(position)),
// //         child: BlocBuilder<LocationBloc, LocationState>(
// //           builder: (context, state) {
// //             if (state is LocationLoading) {
// //               return const Center(child: CircularProgressIndicator());
// //             } else if (state is LocationError) {
// //               return Center(child: Text(state.message));
// //             } else if (state is LocationLoaded) {
// //               return Center(
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text(
// //                       'Latitude: ${state.position.latitude}, Longitude: ${state.position.longitude}',
// //                       style: const TextStyle(fontSize: 18),
// //                     ),
// //                     const SizedBox(height: 10),
// //                     Text(
// //                       'Address: ${context.read<LocationBloc>().repository.getAddressFromLatLng(position)}',
// //                       style: const TextStyle(fontSize: 18),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             }
// //             return const Center(child: Text('No data available'));
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';

// class LocationAddressPage extends StatelessWidget {
//   const LocationAddressPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Dispatch the event to fetch the current location when the page is built
//     context.read<LocationBloc>().add(const FetchCurrentLocationEvent());

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Current Location'),
//       ),
//       body: BlocBuilder<LocationBloc, LocationState>(
//         builder: (context, state) {
//           if (state is LocationLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is LocationLoaded) {
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Current Location:',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Latitude: ${state.position.latitude}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'Longitude: ${state.position.latitude}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 20),
//                   if (state.accuracy != null)
//                     Text(
//                       'Accuracy: ${state.accuracy} meters',
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                   const SizedBox(height: 20),
//                   // Display the fetched address (if available)
//                   Text(
//                     'Address: ${state.position.latitude}, ${state.position.longitude}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is LocationError) {
//             return Center(child: Text('Error: ${state.message}'));
//           }
//           return const Center(child: Text('Unknown State'));
//         },
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';

// class LocationNamePage extends StatelessWidget {
//   const LocationNamePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Location Name'),
//       ),
//       body: BlocBuilder<LocationBloc, LocationState>(
//         builder: (context, state) {
//           if (state is LocationLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is LocationError) {
//             return Center(child: Text(state.message));
//           } else if (state is LocationLoaded) {
//             // Fetch the address from the LatLng position when the location is loaded
//             context
//                 .read<LocationBloc>()
//                 .add(FetchAddressFromLatLngEvent(state.position));

//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Latitude: ${state.position.latitude}, Longitude: ${state.position.longitude}',
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                   const SizedBox(height: 10),
//                   // Display the address from the LocationBloc
//                   Text(
//                     'Address: ${state.address ?? "Loading address..."}',
//                     style: const TextStyle(fontSize: 18),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             );
//           }
//           return const Center(child: Text('No data available'));
//         },
//       ),
//     );
//   }
// }