import 'dart:developer';
import 'package:hotel_booking/features/review/data/datasource/review_datasource.dart';
import 'package:hotel_booking/features/review/data/model/review_model.dart';
import 'package:hotel_booking/features/review/domain/repos/review_repos.dart';

class FirebaseReviewRepository implements ReviewRepository {
  final FirebaseReviewDataSource dataSource;

  FirebaseReviewRepository(this.dataSource);

  @override
  Future<void> addReview(ReviewModel review, String hotelId) async {
    await dataSource.addReview(review, hotelId);
    log('add reviewRepository ');
  }

  @override
  Future<List<ReviewModel>> fetchReviews(String hotelId) async {
    return dataSource.fetchReviews(hotelId);
  }

  @override
  Future<void> deleteReview(String reviewId, String hotelId) async {
    await dataSource.deleteReview(reviewId, hotelId);
  }
}
