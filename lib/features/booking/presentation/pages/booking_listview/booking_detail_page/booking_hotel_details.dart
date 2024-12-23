import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';

class HotelBookingDetailPage extends StatelessWidget {
  final String hotelId;

  const HotelBookingDetailPage({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    context.read<HotelBloc>().add(LoadHotelByIdEvent(hotelId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Details'),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HotelErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is HotelDetailLoadedState) {
            final hotel = state.hotel;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hotel Name: ${hotel.hotelName}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Location: ${hotel.city}'),
                  Text('Hotel Type: ${hotel.hotelType}'),
                  // Add more fields as per your hotel model
                  const SizedBox(height: 16),
                  // Text('Description: ${hotel.description ?? 'No description available.'}'),
                ],
              ),
            );
          }

          return const Center(
            child: Text('No hotel details available'),
          );
        },
      ),
    );
  }
}
