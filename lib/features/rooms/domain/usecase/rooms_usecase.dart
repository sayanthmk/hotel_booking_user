import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';
import 'package:hotel_booking/features/rooms/domain/repos/rooms_domain_repositary.dart';

class GetHotelRoomsUseCase {
  final RoomRepository repository;

  GetHotelRoomsUseCase(this.repository);

  Future<List<RoomEntity>> execute(String hotelId) {
    return repository.getRoomsForHotel(hotelId);
  }
}
