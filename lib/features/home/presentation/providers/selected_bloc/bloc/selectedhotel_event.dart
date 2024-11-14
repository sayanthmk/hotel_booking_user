part of 'selectedhotel_bloc.dart';

abstract class SelectedHotelEvent {}

class SelectHotelEvent extends SelectedHotelEvent {
  final HotelEntity hotel;
  SelectHotelEvent(this.hotel);
}
