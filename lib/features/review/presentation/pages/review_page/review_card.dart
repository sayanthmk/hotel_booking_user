import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/review/data/model/review_model.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
import 'package:hotel_booking/utils/alertbox/alertbox.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
    required this.isCurrentUserReview,
    required this.hotelId,
  });

  final ReviewModel review;
  final bool isCurrentUserReview;
  final String hotelId;

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: ProfileSectionColors.primaryLight,
                        child: Text(
                          review.useremail?.substring(0, 1).toUpperCase() ??
                              'U',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.useremail ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              DateFormat('MMM d, yyyy').format(
                                review.reviewdate ?? DateTime.now(),
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
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red,
                    onPressed: () => showDeleteDialog(
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
                  double parsedRating =
                      double.tryParse(review.rating ?? '0') ?? 0.0;
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
  }

  Future<void> showDeleteDialog(
    BuildContext context,
    String reviewId,
    String hotelId,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleText: "Delete Review?",
          contentText:
              "This action cannot be undone. Are you sure you want to delete your review?",
          buttonText1: "CANCEL",
          buttonText2: "DELETE",
          onPressButton1: () {
            Navigator.of(context).pop(false);
          },
          onPressButton2: () {
            Navigator.of(context).pop(true);
          },
        );
      },
    );

    if (confirm == true && context.mounted) {
      context.read<ReviewBloc>().add(DeleteReview(reviewId, hotelId));
    }
  }
}
