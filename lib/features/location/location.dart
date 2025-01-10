import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/features/location/domain/repos/location_repos.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Location"),
      ),
      body: BlocProvider(
        create: (_) => LocationBloc(GetIt.I.get<LocationRepository>())
          ..add(FetchUserLocationEvent()),
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LocationLoaded) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: state.position,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("currentLocation"),
                    position: state.position,
                  ),
                },
              );
            } else if (state is LocationError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text("Loading..."));
            }
          },
        ),
      ),
    );
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   MapScreenState createState() => MapScreenState();
// }

// class MapScreenState extends State<MapScreen> {
//   final Completer<GoogleMapController> _controller = Completer();
//   final Location _location = Location();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   User? currentUser;
//   LatLng? _currentPosition;
//   final Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     currentUser = _auth.currentUser;
//     _getCurrentLocation();
//   }

//   void _getCurrentLocation() async {
//     try {
//       final LocationData locationResult = await _location.getLocation();
//       setState(() {
//         _currentPosition =
//             LatLng(locationResult.latitude!, locationResult.longitude!);
//         _markers.add(Marker(
//           markerId: const MarkerId('currentLocation'),
//           position: _currentPosition!,
//           infoWindow: const InfoWindow(title: 'Current Location'),
//         ));
//       });
//       _moveCamera();
//       _updateLocationInFirestore();
//       _startLocationListener();
//     } catch (e) {
//       print('Error getting location: $e');
//     }
//   }

//   void _moveCamera() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(
//       CameraPosition(
//         target: _currentPosition!,
//         zoom: 15,
//       ),
//     ));
//   }

//   void _updateLocationInFirestore() {
//     if (currentUser != null) {
//       _firestore
//           .collection('users')
//           .doc(currentUser!.uid)
//           .collection('location')
//           .doc(currentUser!.uid)
//           .set({
//         'latitude': _currentPosition!.latitude,
//         'longitude': _currentPosition!.longitude,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//     } else {
//       print('Error: User is not logged in.');
//     }
//   }

//   void _startLocationListener() {
//     _location.onLocationChanged.listen((LocationData locationData) {
//       setState(() {
//         _currentPosition =
//             LatLng(locationData.latitude!, locationData.longitude!);
//         _markers.clear();
//         _markers.add(Marker(
//           markerId: const MarkerId('currentLocation'),
//           position: _currentPosition!,
//           infoWindow: const InfoWindow(title: 'Current Location'),
//         ));
//       });
//       _updateLocationInFirestore();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Map'),
//       ),
//       body: _currentPosition == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               mapType: MapType.normal,
//               initialCameraPosition: CameraPosition(
//                 target: _currentPosition!,
//                 zoom: 15,
//               ),
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//               markers: _markers,
//             ),
//     );
//   }
// }
// Entity
// class LocationEntity {
//   final double latitude;
//   final double longitude;
//   final DateTime timestamp;

//   LocationEntity({
//     required this.latitude,
//     required this.longitude,
//     required this.timestamp,
//   });
// }

// Model
// class LocationModel extends LocationEntity {
//   LocationModel({
//     required super.latitude,
//     required super.longitude,
//     required super.timestamp,
//   });

//   factory LocationModel.fromJson(Map<String, dynamic> json) {
//     return LocationModel(
//       longitude: json['longitude'] ?? 0.0,
//       latitude: json['latitude'] ?? 0.0,
//       timestamp: (json['timestamp'] as Timestamp).toDate(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'longitude': longitude,
//       'latitude': latitude,
//       'timestamp': Timestamp.fromDate(timestamp),
//     };
//   }
// }

// Data Source Interface
// abstract class LocationRemoteDataSource {
//   Stream<void> updateUserLocation(LocationEntity location);
//   Stream<LocationEntity> getUserLocation();
// }

// // Data Source Implementation
// class LiveLocationRemoteDataSource implements LocationRemoteDataSource {
//   final FirebaseFirestore _firestore;
//   final FirebaseAuth _auth;

//   LiveLocationRemoteDataSource(this._firestore, this._auth);

//   @override
//   Stream<void> updateUserLocation(LocationEntity location) async* {
//     final User? currentUser = _auth.currentUser;
//     if (currentUser == null) {
//       throw Exception("User not authenticated.");
//     }
//     log('updateUserLocation stream');
//     final userDocRef = _firestore
//         .collection('users')
//         .doc(currentUser.uid)
//         .collection('location');
//     //     .add({
//     //   'latitude': location.latitude,
//     //   'longitude': location.longitude,
//     //   'timestamp': Timestamp.fromDate(location.timestamp),
//     // });
//     // Add the location update to Firestore
//     await userDocRef.add({
//       'latitude': location.latitude,
//       'longitude': location.longitude,
//       'timestamp': Timestamp.fromDate(location.timestamp),
//     });

//     // Stream the latest location
//     final locationStream =
//         userDocRef.orderBy('timestamp', descending: true).limit(1).snapshots();

//     await for (var snapshot in locationStream) {
//       if (snapshot.docs.isNotEmpty) {
//         final data = snapshot.docs.first.data();
//         yield LocationModel.fromJson(data);
//       }
//     }
//     yield null;
//   }

//   @override
//   Stream<LocationEntity> getUserLocation() {
//     final User? currentUser = _auth.currentUser;
//     if (currentUser == null) {
//       throw Exception("User not authenticated.");
//     }
//     log('user location');
//     final locationStream = _firestore
//         .collection('users')
//         .doc(currentUser.uid)
//         .collection('location')
//         .orderBy('timestamp', descending: true)
//         .snapshots();

//     return locationStream.map((snapshot) {
//       if (snapshot.docs.isNotEmpty) {
//         final data = snapshot.docs.first.data();
//         return LocationModel.fromJson(data);
//       } else {
//         throw Exception("No location data found.");
//       }
//     });
//   }
// }

// Repository Interface
// abstract class LocationRepository {
//   Stream<void> updateUserLocation(LocationEntity location);
//   Stream<LocationEntity> getUserLocation();
// }

// Repository Implementation
// class LiveLocationRepositoryImpl implements LocationRepository {
//   final LocationRemoteDataSource remoteDataSource;

//   LiveLocationRepositoryImpl({required this.remoteDataSource});

//   @override
//   Stream<void> updateUserLocation(LocationEntity location) async* {
//     try {
//       remoteDataSource.updateUserLocation(location);
//     } catch (error) {
//       rethrow;
//     }
//   }

//   @override
//   Stream<LocationEntity> getUserLocation() {
//     try {
//       return remoteDataSource.getUserLocation();
//     } catch (error) {
//       rethrow;
//     }
//   }
// }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'location_repository.dart'; // Replace with the actual import path

// // Events
// abstract class LocationEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class FetchUserLocationEvent extends LocationEvent {}

// States
// abstract class LocationState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class LocationInitial extends LocationState {}

// class LocationLoading extends LocationState {}

// class LocationLoaded extends LocationState {
//   final LatLng position;

//   LocationLoaded(this.position);

//   @override
//   List<Object?> get props => [position];
// }

// class LocationError extends LocationState {
//   final String message;

//   LocationError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// Bloc
// class LocationBloc extends Bloc<LocationEvent, LocationState> {
//   final LocationRepository repository;

//   LocationBloc(this.repository) : super(LocationInitial()) {
//     on<FetchUserLocationEvent>(_onFetchUserLocation);
//   }

//   void _onFetchUserLocation(
//     FetchUserLocationEvent event,
//     Emitter<LocationState> emit,
//   ) async {
//     emit(LocationLoading());

//     try {
//       await for (final location in repository.getUserLocation()) {
//         emit(LocationLoaded(LatLng(location.latitude, location.longitude)));
//       }
//     } catch (e) {
//       emit(LocationError("Failed to fetch location: $e"));
//     }
//   }
// }
// getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
// getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

// getIt.registerLazySingleton<LocationRemoteDataSource>(
//   () => LiveLocationRemoteDataSource(getIt<FirebaseFirestore>(), getIt<FirebaseAuth>()),
// );

// getIt.registerLazySingleton<LocationRepository>(
//   () => LiveLocationRepositoryImpl(remoteDataSource: getIt<LocationRemoteDataSource>()),
// );
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'location_bloc.dart'; // Replace with the actual import path
// import 'package:get_it/get_it.dart';