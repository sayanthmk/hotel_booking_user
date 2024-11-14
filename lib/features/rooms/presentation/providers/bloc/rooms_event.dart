import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

abstract class HotelRoomsEvent {}

class LoadHotelRoomsEvent extends HotelRoomsEvent {
  final HotelEntity hotel;
  LoadHotelRoomsEvent(this.hotel);
}
