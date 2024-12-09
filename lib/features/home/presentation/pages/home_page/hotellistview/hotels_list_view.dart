import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
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
            return const Center(child: CircularProgressIndicator());
          } else if (state is HotelLoadedState) {
            return SizedBox(
              height: 280,
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
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Stack(
                            children: [
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        hotel.images[0],
                                      )),
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.2),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Column(
                                  children: [
                                    Text(
                                      hotel.hotelName,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      hotel.city,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${hotel.propertySetup}/night',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                        // Text(
                                        //   hotel.,
                                        //   style: const TextStyle(
                                        //       color: Colors.white,
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 10),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
