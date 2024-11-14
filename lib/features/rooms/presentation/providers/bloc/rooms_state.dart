import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';

abstract class HotelRoomsState {}

class HotelRoomsInitial extends HotelRoomsState {}

class HotelRoomsLoading extends HotelRoomsState {}

class HotelRoomsLoaded extends HotelRoomsState {
  final List<RoomEntity> rooms;
  final HotelEntity hotel;
  HotelRoomsLoaded(this.rooms, this.hotel);
}

class HotelRoomsError extends HotelRoomsState {
  final String message;
  HotelRoomsError(this.message);
}
