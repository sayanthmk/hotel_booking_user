import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/review/data/model/review_model.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';
import 'package:intl/intl.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Reviews',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
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

                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 4,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                child: Text(
                                                  review.useremail
                                                          ?.substring(0, 1)
                                                          .toUpperCase() ??
                                                      'U',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      review.useremail ?? '',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      DateFormat('MMM d, yyyy')
                                                          .format(
                                                        review.reviewdate ??
                                                            DateTime.now(),
                                                      ),
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (isCurrentUserReview)
                                          IconButton(
                                            icon: const Icon(
                                                Icons.delete_outline),
                                            color: Colors.red,
                                            onPressed: () => _showDeleteDialog(
                                              context,
                                              review.id!,
                                              hotelId,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (starIndex) {
                                          double parsedRating = double.tryParse(
                                                  review.rating ?? '0') ??
                                              0.0;
                                          return Icon(
                                            Icons.star_rounded,
                                            size: 10,
                                            color: starIndex < parsedRating
                                                ? Colors.amber
                                                : Colors.grey[300],
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      review.reviewcontent ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
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

  Future<void> _showDeleteDialog(
    BuildContext context,
    String reviewId,
    String hotelId,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Delete Review?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "This action cannot be undone. Are you sure you want to delete your review?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                "CANCEL",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                "DELETE",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true && context.mounted) {
      context.read<ReviewBloc>().add(DeleteReview(reviewId, hotelId));
    }
  }
}

class AddReviewButton extends StatelessWidget {
  const AddReviewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddReviewDialog(context),
      child: const Icon(Icons.add),
    );
  }

  void _showAddReviewDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final reviewController = TextEditingController();
    double rating = 0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Write a Review'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      icon: Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () => setState(() => rating = index + 1),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: reviewController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Write your review here...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please write your review';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
              builder: (context, hotelState) {
                if (hotelState is SelectedHotelLoaded) {
                  final hotelId = hotelState.hotel.hotelId;

                  return ElevatedButton(
                    onPressed: () {
                      if (reviewController.text.isNotEmpty && rating > 0) {
                        final review = ReviewModel(
                          reviewcontent: reviewController.text,
                          rating: rating.toString(),
                          reviewdate: DateTime.now(),
                        );

                        Navigator.pop(context);
                        context
                            .read<ReviewBloc>()
                            .add(AddReview(review, hotelId));
                        reviewController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please write a review and select a rating'),
                          ),
                        );
                      }
                    },
                    child: const Text('Submit Review'),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
