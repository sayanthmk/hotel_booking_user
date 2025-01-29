import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/review/presentation/pages/review_page/add_review_button.dart';
import 'package:hotel_booking/features/review/presentation/pages/review_page/review_card.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';
import 'package:hotel_booking/utils/custom_appbar/custom_appbar.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BookingAppbar(heading: 'Reviews'),
      body: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
        builder: (context, hotelState) {
          if (hotelState is SelectedHotelLoaded) {
            final hotelId = hotelState.hotel.hotelId;
            context.read<ReviewBloc>().add(FetchReviews(hotelId));
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hotelState.hotel.hotelName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(Icons.hotel, size: 24),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<ReviewBloc, ReviewState>(
                    builder: (context, state) {
                      if (state is ReviewLoaded) {
                        if (state.reviews.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.rate_review_outlined,
                                    size: 64, color: Colors.grey),
                                SizedBox(height: 16),
                                Text(
                                  'No reviews yet.\nBe the first to share your experience!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: state.reviews.length,
                          itemBuilder: (context, index) {
                            final review = state.reviews[index];
                            final isCurrentUserReview = review.useremail ==
                                FirebaseAuth.instance.currentUser?.email;

                            return ReviewCard(
                                review: review,
                                isCurrentUserReview: isCurrentUserReview,
                                hotelId: hotelId);
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hotel_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Please select a hotel to view reviews',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: const AddReviewButton(),
    );
  }
}
