import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';

class BookingDetailPageSection extends StatelessWidget {
  const BookingDetailPageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                context.read<UserBloc>().add(GetUserDataEvent());
                Navigator.pop(context);
              },
              icon: const Icon(Icons.abc_sharp))
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is SingleUserBookingLoadedState) {
            final booking = state.booking;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Booking ID: ${booking.id}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Place: ${booking.place}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start Date: ${booking.startdate}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'End Date: ${booking.enddate}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Booking ID: ${booking.id}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (booking.id != null) {
                        context.read<UserBloc>().add(DeleteUserBookingEvent(
                            booking.id!, booking.hotelId!));
                        Navigator.pop(context); // Navigate back after deletion
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Booking ID is null, cannot delete.")),
                        );
                      }
                    },
                    child: const Text('Cancel Booking'),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text('Unable to load booking details'),
          );
        },
      ),
    );
  }
}
