import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

abstract class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object?> get props => [];
}

class HotelInitial extends HotelState {}

class HotelLoadingState extends HotelState {}

class HotelLoadedState extends HotelState {
  final List<HotelEntity> hotels;

  const HotelLoadedState(this.hotels);

  @override
  List<Object?> get props => [hotels];
}

class HotelDetailLoadedState extends HotelState {
  final HotelEntity hotel;

  const HotelDetailLoadedState(this.hotel);

  @override
  List<Object?> get props => [hotel];
}

class HotelErrorState extends HotelState {
  final String message;

  const HotelErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
