import 'package:equatable/equatable.dart';

abstract class HotelEvent extends Equatable {
  const HotelEvent();

  @override
  List<Object?> get props => [];
}

class LoadHotelsEvent extends HotelEvent {}

class LoadHotelByIdEvent extends HotelEvent {
  final String hotelId;

  const LoadHotelByIdEvent(this.hotelId);

  @override
  List<Object?> get props => [hotelId];
}
