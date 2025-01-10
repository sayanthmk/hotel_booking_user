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
}
