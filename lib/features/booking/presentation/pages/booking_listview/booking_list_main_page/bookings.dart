import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_list_main_page/booking_show_card.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';

class UserBookingsPage extends StatelessWidget {
  const UserBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(GetUserDataEvent());

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'My Bookings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: HotelBookingColors.basictextcolor,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        HotelBookingColors.basictextcolor),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading your bookings...',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is UserErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      size: 60, color: Colors.red.shade300),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: TextStyle(color: Colors.red.shade300),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is UserDataLoadedState) {
            if (state.userData.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No Bookings Yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your future bookings will appear here',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.userData.length,
              itemBuilder: (context, index) {
                final booking = state.userData[index];

                return BookingShowCard(
                  booking: booking,
                );
              },
            );
          }

          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}
