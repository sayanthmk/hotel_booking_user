import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

abstract class HotelState {}

class HotelInitialState extends HotelState {}

class HotelLoadingState extends HotelState {}

class HotelLoadedState extends HotelState {
  final List<HotelEntity> hotels;

  HotelLoadedState(this.hotels);
}

class HotelErrorState extends HotelState {
  final String message;

  HotelErrorState(this.message);
}
