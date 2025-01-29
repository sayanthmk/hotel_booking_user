import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/review/data/model/review_model.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';

class AddReviewButton extends StatelessWidget {
  const AddReviewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showAddReviewDialog(context),
      icon: const Icon(Icons.rate_review, color: Color(0xFFFFFBF8)),
      label: const Text(
        'Write Review',
        style: TextStyle(color: Color(0xFFFFFBF8)),
      ),
      backgroundColor: const Color(0xFF7D5A50),
      elevation: 4,
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
          backgroundColor: const Color(0xFFFFFBF8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Stack(
            alignment: Alignment.center,
            children: [
              const Text(
                'Write a Review',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7D5A50),
                ),
                textAlign: TextAlign.center,
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFF9C7B73),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rate your experience',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9C7B73),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3ECE8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        5,
                        (index) => InkWell(
                          onTap: () => setState(() => rating = index + 1),
                          child: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: const Color(0xFFD4A373),
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Share your thoughts',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9C7B73),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: reviewController,
                    maxLines: 2,
                    style: const TextStyle(color: Color(0xFF5E4238)),
                    decoration: InputDecoration(
                      hintText: 'Tell us about your experience...',
                      hintStyle: const TextStyle(color: Color(0xFF9C7B73)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFB4846C)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF7D5A50),
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF3ECE8),
                      contentPadding: const EdgeInsets.all(16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFB4846C)),
                      ),
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
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
                    builder: (context, hotelState) {
                      if (hotelState is SelectedHotelLoaded) {
                        final hotelId = hotelState.hotel.hotelId;

                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: const Color(0xFF7D5A50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate() &&
                                  rating > 0) {
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
                                      'Please complete both rating and review',
                                      style:
                                          TextStyle(color: Color(0xFFFFFBF8)),
                                    ),
                                    backgroundColor: Color(0xFF7D5A50),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Submit Review',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFBF8),
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
