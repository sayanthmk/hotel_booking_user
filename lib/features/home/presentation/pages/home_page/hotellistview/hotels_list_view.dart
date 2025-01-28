import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/widgets/hote_shimmer.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';

class HotelsListView extends StatelessWidget {
  const HotelsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
        child: BlocBuilder<HotelBloc, HotelState>(builder: (context, state) {
          if (state is HotelLoadingState) {
            // return const Center(child: CircularProgressIndicator());
            return const HotelCardShimmerSection();
          } else if (state is HotelLoadedState) {
            return SizedBox(
              height: 260,
              child: Material(
                color: HotelBookingColors.pagebackgroundcolor,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.hotels.length,
                    itemBuilder: (context, index) {
                      HotelEntity hotel = state.hotels[index];
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
                                    height: 130,
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
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        hotel.hotelName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        ' ₹${hotel.propertySetup}/night',
                                        style: const TextStyle(
                                            color: HotelBookingColors
                                                .basictextcolor,
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
                                              '${hotel.city}/${hotel.state}',
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
          } else if (state is HotelErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text('No hotels found'));
        }));
  }
}
