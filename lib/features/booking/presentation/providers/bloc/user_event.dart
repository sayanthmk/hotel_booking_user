part of 'user_bloc.dart';

abstract class UserEvent {}

class SaveUserDataEvent extends UserEvent {
  final UserDataModel userData;
  final String hotelId;

  SaveUserDataEvent(this.userData, this.hotelId);
}

class GetUserDataEvent extends UserEvent {}

class GetHotelBookingsEvent extends UserEvent {
  final String hotelId;

  GetHotelBookingsEvent(this.hotelId);
}

class DeleteUserBookingEvent extends UserEvent {
  final String bookingId;
  final String hotelId;

  DeleteUserBookingEvent(this.bookingId, this.hotelId);
}

class GetSingleUserBookingEvent extends UserEvent {
  final String bookingId;
  GetSingleUserBookingEvent(this.bookingId);
}

