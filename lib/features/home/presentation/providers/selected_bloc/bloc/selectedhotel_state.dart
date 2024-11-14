part of 'selectedhotel_bloc.dart';

abstract class SelectedHotelState {}

class SelectedHotelInitial extends SelectedHotelState {}

class SelectedHotelLoaded extends SelectedHotelState {
  final HotelEntity hotel;
  SelectedHotelLoaded(this.hotel);
}
