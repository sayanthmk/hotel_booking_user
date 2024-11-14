import 'package:hotel_booking/features/rooms/data/datasourse/room_remote_datasourse.dart';
import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';
import 'package:hotel_booking/features/rooms/domain/repos/rooms_domain_repositary.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource remoteDataSource;

  RoomRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<RoomEntity>> getRoomsForHotel(String hotelId) async {
    try {
      return await remoteDataSource.getRoomsForHotel(hotelId);
    } catch (e) {
      throw Exception('Failed to get rooms: $e');
    }
  }
}
