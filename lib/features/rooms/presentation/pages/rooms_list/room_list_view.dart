import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/home/presentation/widgets/section_header.dart';
import 'package:hotel_booking/features/rooms/presentation/pages/detailed_rooms_list/rooms_detail_page.dart';
import 'package:hotel_booking/features/rooms/presentation/pages/rooms_list/room_card.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_state.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/roomcard_bloc/room_card_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_event.dart';

class HotelRoomsListView extends StatelessWidget {
  const HotelRoomsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelRoomsBloc, HotelRoomsState>(
      builder: (context, state) {
        if (state is HotelRoomsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HotelRoomsLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SectionHeader(
                  title: 'Available Rooms',
                  actionText: 'Show All',
                  ontap: () {},
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(0),
                    itemCount: state.rooms.length,
                    itemBuilder: (context, index) {
                      final room = state.rooms[index];
                      context
                          .read<RoomCardBloc>()
                          .add(LoadRoomEvent(state.rooms[index]));
                      return InkWell(
                        onTap: () {
                          context
                              .read<SelectedRoomBloc>()
                              .add(SelectRoomEvent(room));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RoomDetailPage(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: RoomCard(),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
