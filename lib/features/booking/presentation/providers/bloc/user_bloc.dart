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
  }

  void _onSaveUserData(SaveUserDataEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await repository.saveUserBooking(event.userData);
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
}
