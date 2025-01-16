import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/amenteties.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/hotel_image_box.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/hotel_map.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/report_reviewpage.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/pages/rooms_list/room_list_view.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_event.dart';

class HotelDetailPage extends StatelessWidget {
  const HotelDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
        builder: (context, state) {
          if (state is SelectedHotelLoaded) {
            final hotel = state.hotel;
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //  image
                    const HotelImageBox(),
                    //amentity
                    const Amenities(),
                    //review report

                    //rooms
                    BlocProvider(
                      create: (context) =>
                          sl<HotelRoomsBloc>()..add(LoadHotelRoomsEvent(hotel)),
                      child: const HotelRoomsListView(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    ReviewReportPage(
                      hotelId: hotel.hotelId,
                    ),
                    //  map
                    const SizedBox(
                      height: 20,
                    ),
                    const HotelMap(),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Error loading hotel details.'));
          }
        },
      ),
    );
  }
}
