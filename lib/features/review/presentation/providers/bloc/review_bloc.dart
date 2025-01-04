import 'package:bloc/bloc.dart';
import 'package:hotel_booking/features/review/domain/repos/review_repos.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository repository;

  ReviewBloc(this.repository) : super(UserInitialState()) {
    on<SaveUserReviewEvent>(_onSaveUserReview);
    on<GetUserReviewEvent>(_onGetUserReview);
    on<GetHotelReviewEvent>(_onGetHotelReview);
    on<DeleteUserReviewEvent>(_onDeleteUserReview);
    on<GetSingleUserReviewEvent>(_onGetSingleUserReview);
  }

  void _onSaveUserReview(
      SaveUserReviewEvent event, Emitter<ReviewState> emit) async {
    try {
      emit(UserReviewLoadingState());

      await repository.saveUserReview(event.userData, event.hotelId);
      emit(UserReviewSavedState());
    } catch (e) {
      emit(UserReviewErrorState('Failed to save user data: $e'));
    }
  }

  void _onGetUserReview(
      GetUserReviewEvent event, Emitter<ReviewState> emit) async {
    try {
      emit(UserReviewLoadingState());
      final userData = await repository.getUserReview();
      emit(UserReviewLoadedState(userData));
    } catch (e) {
      emit(UserReviewErrorState('Failed to load user data: $e'));
    }
  }

  void _onGetHotelReview(
      GetHotelReviewEvent event, Emitter<ReviewState> emit) async {
    try {
      emit(UserReviewLoadingState());
      final adminReports = await repository.getHotelReview(event.hotelId);
      emit(UserReviewLoadedState(adminReports));
    } catch (e) {
      emit(UserReviewErrorState('Failed to load hotel bookings: $e'));
    }
  }

  void _onDeleteUserReview(
      DeleteUserReviewEvent event, Emitter<ReviewState> emit) async {
    try {
      emit(UserReviewLoadingState());
      await repository.deleteUserReview(event.bookingId, event.hotelId);
      emit(UserReviewDeletedState());
      add(GetUserReviewEvent());
    } catch (e) {
      emit(UserReviewErrorState('Failed to delete user booking: $e'));
    }
  }

  void _onGetSingleUserReview(
      GetSingleUserReviewEvent event, Emitter<ReviewState> emit) async {
    try {
      emit(UserReviewLoadingState());
      final booking = await repository.getSingleUserReview(event.bookingId);
      emit(SingleUserReviewLoadedState(booking));
    } catch (e) {
      emit(UserReviewErrorState('Failed to load single user booking: $e'));
    }
  }
}
