import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:hotel_booking/features/location/data/model/location_model.dart';
import 'package:hotel_booking/features/location/domain/entity/location_entity.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationRemoteDataSource {
  Stream<LocationEntity> getCurrentLocation();
  Stream<void> updateUserLocation(LocationEntity location);
  Stream<LocationEntity> getUserLocation();
  Future<String> getAddressFromLatLng(LatLng position);
}

class LiveLocationRemoteDataSource implements LocationRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  LiveLocationRemoteDataSource(this._firestore, this._auth);

  @override
  Future<String> getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      }
      return "Unknown Location";
    } catch (e) {
      return "Error retrieving address";
    }
  }

  @override
  Stream<LocationEntity> getCurrentLocation() async* {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception("Location permission denied.");
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    yield LocationEntity(
      latitude: position.latitude,
      longitude: position.longitude,
      timestamp: DateTime.now(),
    );
  }

  @override
  Stream<void> updateUserLocation(LocationEntity location) async* {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("User not authenticated.");
    }
    log('updateUserLocation stream');
    final userDocRef = _firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('location');

    await userDocRef.add({
      'latitude': location.latitude,
      'longitude': location.longitude,
      'timestamp': Timestamp.fromDate(location.timestamp),
    });

    final locationStream =
        userDocRef.orderBy('timestamp', descending: true).limit(1).snapshots();

    await for (var snapshot in locationStream) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        yield LocationModel.fromJson(data);
      }
    }
    yield null;
  }

  @override
  Stream<LocationEntity> getUserLocation() {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("User not authenticated.");
    }
    log('user location');
    final locationStream = _firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('location')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();

    return locationStream.map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        return LocationModel.fromJson(data);
      } else {
        throw Exception("No location data found.");
      }
    });
  }
}
