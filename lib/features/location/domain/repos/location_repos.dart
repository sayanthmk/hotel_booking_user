import 'package:hotel_booking/features/location/domain/entity/location_entity.dart';

abstract class LocationRepository {
  Stream<void> updateUserLocation(LocationEntity location);
  Stream<LocationEntity> getUserLocation();
}
