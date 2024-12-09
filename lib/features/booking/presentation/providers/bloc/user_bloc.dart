import 'package:bloc/bloc.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/domain/repos/booking_repos.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitialState()) {
    on<SaveUserDataEvent>(_onSaveUserData);
    on<GetUserDataEvent>(_onGetUserData);
    on<SaveHotelBookingEvent>(_onSaveHotelBooking);
    on<GetHotelBookingsEvent>(_onGetHotelBookings);
    on<DeleteUserBookingEvent>(_onDeleteUserBooking);
    on<DeleteHotelBookingEvent>(_onDeleteHotelBooking);
    on<GetSingleUserBookingEvent>(_onGetSingleUserBooking); // New Event
  }

  void _onSaveUserData(SaveUserDataEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await repository.saveUserBooking(event.userData, event.hotelId);
      emit(UserDataSavedState());
    } catch (e) {
      emit(UserErrorState('Failed to save user data: $e'));
    }
  }

  void _onGetUserData(GetUserDataEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      final userData = await repository.getUserBookings();
      emit(UserDataLoadedState(userData));
    } catch (e) {
      emit(UserErrorState('Failed to load user data: $e'));
    }
  }

  void _onSaveHotelBooking(
      SaveHotelBookingEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await repository.saveHotelBooking(
        hotelId: event.hotelId,
        bookingData: event.bookingData,
      );
      emit(UserDataSavedState());
    } catch (e) {
      emit(UserErrorState('Failed to save hotel booking: $e'));
    }
  }

  void _onGetHotelBookings(
      GetHotelBookingsEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      final hotelBookings = await repository.getHotelBookings(event.hotelId);
      emit(UserDataLoadedState(hotelBookings));
    } catch (e) {
      emit(UserErrorState('Failed to load hotel bookings: $e'));
    }
  }

  void _onDeleteUserBooking(
      DeleteUserBookingEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await repository.deleteUserBooking(event.bookingId, event.hotelId);
      emit(UserBookingDeletedState());
      add(GetUserDataEvent());
    } catch (e) {
      emit(UserErrorState('Failed to delete user booking: $e'));
    }
  }

  void _onDeleteHotelBooking(
      DeleteHotelBookingEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await repository.deleteHotelBooking(
        hotelId: event.hotelId,
        bookingId: event.bookingId,
      );
      emit(UserBookingDeletedState());
      // add(GetHotelBookingsEvent());
    } catch (e) {
      emit(UserErrorState('Failed to delete hotel booking: $e'));
    }
  }

  void _onGetSingleUserBooking(
      GetSingleUserBookingEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      final booking = await repository.getSingleUserBooking(event.bookingId);
      emit(SingleUserBookingLoadedState(booking));
      // add(GetUserDataEvent());
    } catch (e) {
      emit(UserErrorState('Failed to load single user booking: $e'));
    }
  }
}
