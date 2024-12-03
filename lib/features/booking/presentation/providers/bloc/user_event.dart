part of 'user_bloc.dart';

abstract class UserEvent {}

class SaveUserDataEvent extends UserEvent {
  final UserDataModel userData;

  SaveUserDataEvent(this.userData);
}

class GetUserDataEvent extends UserEvent {}

// New event for hotel booking
class SaveHotelBookingEvent extends UserEvent {
  final String hotelId;
  final UserDataModel bookingData;

  SaveHotelBookingEvent({
    required this.hotelId,
    required this.bookingData,
  });
}

class GetHotelBookingsEvent extends UserEvent {
  final String hotelId;

  GetHotelBookingsEvent(this.hotelId);
}
