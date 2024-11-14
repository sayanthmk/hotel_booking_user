import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_state.dart';

class HotelRoomsListView extends StatelessWidget {
  const HotelRoomsListView({super.key});

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
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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

class RoomCard extends StatelessWidget {
  final RoomEntity room;

  const RoomCard({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(room.roomType, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Area: ${room.roomArea}',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('Extra Adults: ${room.extraAdultsAllowed}',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('Price: \$${room.basePrice}',
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
