import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/pages/serachpage/search_card.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_state.dart';

class HotelSearchResults extends StatelessWidget {
  const HotelSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSearchBloc, HotelSearchState>(
      builder: (context, searchState) {
        return BlocBuilder<HotelBloc, HotelState>(
          builder: (context, hotelState) {
            if (hotelState is! HotelLoadedState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: HotelBookingColors.basictextcolor,
                ),
              );
            }

            final hotels = searchState is HotelSearchLoadedState
                ? searchState.filteredHotels
                : hotelState.hotels;

            if (hotels.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hotel_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No hotels found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Material(
              color: HotelBookingColors.pagebackgroundcolor,
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return SearchHotelCard(hotel: hotel);
                },
              ),
            );
          },
        );
      },
    );
  }
}
