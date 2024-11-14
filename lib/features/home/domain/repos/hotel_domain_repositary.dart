import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

abstract class HotelRepository {
  Future<List<HotelEntity>> fetchHotels();
  Future<HotelEntity?> fetchHotelById(String hotelId);
}
