import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_page/widgets/booking_form_field.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/review/data/model/review_model.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';

class HotelReviewPage extends StatelessWidget {
  HotelReviewPage({super.key});

  final TextEditingController reviewController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reviews',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: HotelBookingColors.basictextcolor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey[50]!,
                Colors.white,
              ],
            ),
          ),
          child: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
            builder: (context, hotelState) {
              if (hotelState is SelectedHotelLoaded) {
                final hotelId = hotelState.hotel.hotelId;

                return BlocConsumer<ReviewBloc, ReviewState>(
                  listener: (context, state) {
                    if (state is UserReviewErrorState) {
                      showErrorSnackBar(context, state.message);
                    }
                    if (state is UserReviewSavedState) {
                      showSuccessSnackBar(context, 'Review Saved Successfully');
                      clearAllFields();
                    }
                  },
                  builder: (context, state) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            BookingCustomFormField(
                                label: 'Full Name',
                                controller: reviewController),
                            const SizedBox(height: 20),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 55,
                              child: ElevatedButton(
                                onPressed: state is! UserReviewLoadingState
                                    ? () {
                                        if (_formKey.currentState!.validate()) {
                                          final bookingData = ReviewModel();

                                          context.read<ReviewBloc>().add(
                                              SaveUserReviewEvent(
                                                  bookingData, hotelId));
                                        }
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      HotelBookingColors.basictextcolor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                child: state is UserReviewLoadingState
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Text(
                                        'Add review',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: Text(
                  'Failed to load hotel information.',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void clearAllFields() {
    reviewController.clear();
  }

  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
