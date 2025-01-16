import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/review/data/model/review_model.dart';
import 'package:hotel_booking/features/review/domain/repos/review_repos.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository repository;
  List<ReviewModel> reviews = [];

  ReviewBloc(this.repository) : super(ReviewInitial()) {
    on<AddReview>((event, emit) async {
      await repository.addReview(event.review, event.hotelId);
      emit(ReviewLoaded(reviews));
      add(FetchReviews(event.hotelId));
    });
    on<FetchReviews>((event, emit) async {
      try {
        reviews = await repository.fetchReviews(event.hotelId);
        emit(ReviewLoaded(reviews));
      } catch (e) {
        emit(ReviewInitial());
      }
    });

    on<DeleteReview>((event, emit) async {
      try {
        await repository.deleteReview(event.reviewId, event.hotelId);
        reviews = await repository.fetchReviews(event.hotelId);
        emit(ReviewLoaded(reviews));
        add(FetchReviews(event.hotelId));
      } catch (e) {
        log('Error deleting review: $e');
      }
    });
  }
}
