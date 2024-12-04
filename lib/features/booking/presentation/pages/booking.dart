import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';

class UserBookingsPage extends StatelessWidget {
  const UserBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(GetUserDataEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UserErrorState) {
            return buildErrorView(context, state.errorMessage);
          }

          if (state is UserDataLoadedState) {
            if (state.userData.isEmpty) {
              return buildEmptyBookingsView();
            }

            return buildBookingsList(state.userData);
          }

          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }

  Widget buildErrorView(BuildContext context, String errorMessage) {
    log(errorMessage);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            'Error Loading Bookings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            errorMessage,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<UserBloc>().add(GetUserDataEvent());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyBookingsView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No Bookings Yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBookingsList(List<UserDataModel> bookings) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return buildBookingCard(bookings[index]);
      },
    );
  }

  Widget buildBookingCard(UserDataModel booking) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booked on: ${booking.date}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Age: ${booking.age}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Place: ${booking.place}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            if (booking.id != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Booking ID: ${booking.id}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
