import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/location/data/model/location_model.dart';
import 'package:hotel_booking/features/location/domain/entity/location_entity.dart';

abstract class LocationRemoteDataSource {
  Stream<void> updateUserLocation(LocationEntity location);
  Stream<LocationEntity> getUserLocation();
}

class LiveLocationRemoteDataSource implements LocationRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  LiveLocationRemoteDataSource(this._firestore, this._auth);

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
    //     .add({
    //   'latitude': location.latitude,
    //   'longitude': location.longitude,
    //   'timestamp': Timestamp.fromDate(location.timestamp),
    // });
    // Add the location update to Firestore
    await userDocRef.add({
      'latitude': location.latitude,
      'longitude': location.longitude,
      'timestamp': Timestamp.fromDate(location.timestamp),
    });

    // Stream the latest location
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
