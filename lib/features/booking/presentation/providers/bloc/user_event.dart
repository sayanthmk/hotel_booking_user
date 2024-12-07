part of 'user_bloc.dart';

abstract class UserEvent {}

class SaveUserDataEvent extends UserEvent {
  final UserDataModel userData;

  SaveUserDataEvent(this.userData);
}

class GetUserDataEvent extends UserEvent {}

class SaveHotelBookingEvent extends UserEvent {
  final String hotelId;
  final UserDataModel bookingData;

  SaveHotelBookingEvent({required this.hotelId, required this.bookingData});
}

class GetHotelBookingsEvent extends UserEvent {
  final String hotelId;

  GetHotelBookingsEvent(this.hotelId);
}

// New Events for Deletion
class DeleteUserBookingEvent extends UserEvent {
  final String bookingId;

  DeleteUserBookingEvent(this.bookingId);
}

class DeleteHotelBookingEvent extends UserEvent {
  final String hotelId;
  final String bookingId;

  DeleteHotelBookingEvent({required this.hotelId, required this.bookingId});
}
