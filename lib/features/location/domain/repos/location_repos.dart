import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/features/location/domain/entity/location_entity.dart';

abstract class LocationRepository {
  Stream<void> updateUserLocation(LocationEntity location);
  Stream<LocationEntity> getUserLocation();
  Stream<LocationEntity> getCurrentLocation();
  Future<String> getAddressFromLatLng(LatLng position);
}
