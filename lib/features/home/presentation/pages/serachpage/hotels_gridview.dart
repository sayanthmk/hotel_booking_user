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



        // child: Padding(
                    //   padding: const EdgeInsets.all(5.0),
                    //   child: Stack(
                    //     children: [
                    //       Container(
                    //         width: 500,
                    //         decoration: BoxDecoration(
                    //           image: DecorationImage(
                    //             fit: BoxFit.fill,
                    //             image: NetworkImage(hotel.images[0]),
                    //           ),
                    //           color: Colors.grey,
                    //           borderRadius: BorderRadius.circular(20),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.black.withOpacity(0.2),
                    //               spreadRadius: 1,
                    //               blurRadius: 4,
                    //               offset: const Offset(2, 2),
                    //             ),
                    //           ],
                    //         ),
                    //         margin: const EdgeInsets.symmetric(horizontal: 5),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(20),
                    //             gradient: LinearGradient(
                    //               colors: [
                    //                 Colors.black.withOpacity(0.2),
                    //                 Colors.transparent,
                    //               ],
                    //               begin: Alignment.bottomCenter,
                    //               end: Alignment.topCenter,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         bottom: 10,
                    //         left: 10,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               hotel.hotelName,
                    //               style: const TextStyle(
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 20,
                    //               ),
                    //             ),
                    //             Text(
                    //               hotel.city,
                    //               style: const TextStyle(
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 10,
                    //               ),
                    //             ),
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(
                    //                   '${hotel.propertySetup}/night',
                    //                   style: const TextStyle(
                    //                     color: Colors.white,
                    //                     fontWeight: FontWeight.bold,
                    //                     fontSize: 10,
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   hotel.city,
                    //                   style: const TextStyle(
                    //                     color: Colors.white,
                    //                     fontWeight: FontWeight.bold,
                    //                     fontSize: 10,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),