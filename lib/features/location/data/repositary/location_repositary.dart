import 'dart:developer';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/features/location/data/datasourse/location_datasourse.dart';
import 'package:hotel_booking/features/location/domain/entity/location_entity.dart';
import 'package:hotel_booking/features/location/domain/repos/location_repos.dart';

class LiveLocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;

  LiveLocationRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<void> updateUserLocation(LocationEntity location) async* {
    try {
      remoteDataSource.updateUserLocation(location);
      log(location.toString());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Stream<LocationEntity> getUserLocation() {
    try {
      return remoteDataSource.getUserLocation();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Stream<LocationEntity> getCurrentLocation() {
    try {
      return remoteDataSource.getCurrentLocation();
    } catch (error) {
      throw Exception("Failed to get current location: $error");
    }
  }

  Future<String> getAddressFromLatLng(LatLng position) {
    try {
      return remoteDataSource.getAddressFromLatLng(position);
    } catch (error) {
      throw Exception("Failed to get current location: $error");
    }
  }
}
