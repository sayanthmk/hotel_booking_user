import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_page/book_ui.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/amenteties.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/floating_action_button.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/hotel_image_box.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/hotel_map.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/pages/rooms_list/room_list_view.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_event.dart';

class HotelDetailPage extends StatelessWidget {
  const HotelDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    //rooms
                    BlocProvider(
                      create: (context) =>
                          sl<HotelRoomsBloc>()..add(LoadHotelRoomsEvent(hotel)),
                      child: const HotelRoomsListView(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //  map

                    // Center(
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => HotelBookingPage(),
                    //       ));
                    //     },
                    //     child: Text('press'),
                    //   ),
                    // ),
                    const HotelMap(),
                    // const SizedBox(
                    //   height: 100,
                    // )
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Error loading hotel details.'));
          }
        },
      ),
      // floatingActionButton: CustomWideButton(
      //   label: 'Book Now',
      //   icon: Icons.book_online,
      //   onPressed: () {
      //     Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => HotelBookingPage(),
      //     ));
      //   },
      // ),
    );
  }
}
