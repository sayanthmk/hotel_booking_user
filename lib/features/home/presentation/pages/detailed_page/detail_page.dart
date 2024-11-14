import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/amenteties.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/floating_action_button.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/hotel_image_box.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/hotel_map.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/pages/room_list.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_event.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_state.dart';

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
                    // Hotel image
                    const HotelImageBox(),

                    // Hotel room list (separate widget without nested Scaffold)
                    BlocProvider(
                      create: (context) =>
                          sl<HotelRoomsBloc>()..add(LoadHotelRoomsEvent(hotel)),
                      child: HotelRoomsListView(),
                    ),

                    // Additional hotel details section with amenities
                    const Amenities(),

                    // Google map
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
      floatingActionButton: CustomWideButton(
        label: 'Book Now',
        icon: Icons.book_online,
        onPressed: () {
          // Handle button press action
        },
      ),
    );
  }
}

class HotelRoomsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelRoomsBloc, HotelRoomsState>(
      builder: (context, state) {
        if (state is HotelRoomsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HotelRoomsLoaded) {
          return SizedBox(
            height: 200, // Adjust height as needed for horizontal view
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              scrollDirection: Axis.horizontal, // Enables horizontal scrolling
              itemCount: state.rooms.length,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.only(right: 16), // Space between items
                child: RoomCard(
                  room: state.rooms[index],
                ),
              ),
            ),
          );
        } else if (state is HotelRoomsError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('No rooms available'));
      },
    );
  }
}
