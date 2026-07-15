import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_detail_page/booking_det_card.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_detail_page/booking_hotel_details.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
import 'package:hotel_booking/utils/alertbox/alertbox.dart';

class BookingDetailPageSection extends StatelessWidget {
  const BookingDetailPageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Booking Details', style: AppTextStyles.username),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        shadowColor: AppColors.cardShadow,
        leading: IconButton(
          onPressed: () {
            context.read<UserBloc>().add(GetUserDataEvent());
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textDark,
            size: 20,
          ),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is UserErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is SingleUserBookingLoadedState) {
            final booking = state.booking;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  BookingDetailPageCard(
                    booking: booking,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            if (booking.id != null) {
                              showDialog(
                                  context: context,
                                  builder: (context) => CustomAlertDialog(
                                      titleText: 'Cancel Booking',
                                      contentText:
                                          'Are you sure you want to cancel this booking? This action cannot be undone.',
                                      buttonText1: 'No, Keep it',
                                      buttonText2: 'Yes, Cancel',
                                      onPressButton1: () {
                                        Navigator.of(context).pop();
                                      },
                                      onPressButton2: () {
                                        context.read<UserBloc>().add(
                                              DeleteUserBookingEvent(
                                                  booking.id!,
                                                  booking.hotelId!),
                                            );
                                        Navigator.of(context).pop();
                                      }));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      "Booking ID is null, cannot delete."),
                                  backgroundColor: Colors.red.shade400,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'Cancel Booking',
                            style: TextStyle(color: Colors.red),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red.shade200),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HotelBookingDetailPage(
                                hotelId: booking.hotelId!,
                              ),
                            ));
                          },
                          icon: const Icon(Icons.hotel_rounded),
                          label: const Text(
                            'Hotel Details',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: AppColors.textGrey,
                ),
                const SizedBox(height: 16),
                Text(
                  'Unable to load booking details',
                  style: AppTextStyles.hotelLocation.copyWith(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
