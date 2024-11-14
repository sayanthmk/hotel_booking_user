import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';

abstract class RoomRepository {
  Future<List<RoomEntity>> getRoomsForHotel(String hotelId);
}
