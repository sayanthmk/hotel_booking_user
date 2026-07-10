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

class HotelsVerticalListView extends StatelessWidget {
  const HotelsVerticalListView({
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
                    scrollDirection: Axis.vertical,
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
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Hotel Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                                    child: Container(
                                      width: 100,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(hotel.images[0]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Hotel Content
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hotel.hotelName.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on,
                                                  size: 14, color: Colors.grey),
                                              SizedBox(width: 4),
                                              Text(
                                                '${hotel.city}, ${hotel.state}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '₹${hotel.propertySetup}/night',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blue[600],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 16,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    '4.5',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
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
