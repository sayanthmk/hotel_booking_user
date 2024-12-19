import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';

class HotelSearchResults extends StatelessWidget {
  const HotelSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSearchBloc, HotelSearchState>(
      builder: (context, searchState) {
        return BlocBuilder<HotelBloc, HotelState>(
          builder: (context, hotelState) {
            if (hotelState is! HotelLoadedState) {
              return const Center(child: CircularProgressIndicator());
            }

            final hotels = searchState is HotelSearchLoadedState
                ? searchState.filteredHotels
                : hotelState.hotels;

            return Material(
              color: HotelBookingColors.pagebackgroundcolor,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return InkWell(
                    onTap: () {
                      context
                          .read<SelectedHotelBloc>()
                          .add(SelectHotelEvent(hotel));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HotelDetailPage(),
                        ),
                      );
                    },
                    child: Card(
                      child: Container(
                        height: 100,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 80,
                                width: 250,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      hotel.images[0],
                                    ),
                                  ),
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    hotel.hotelName,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    ' ₹${hotel.propertySetup}/night',
                                    style: const TextStyle(
                                        color:
                                            HotelBookingColors.basictextcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.red[600],
                                        ),
                                        Text(
                                          '${hotel.city}/${hotel.country}',
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(hotel.hotelType),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
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