import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/roomcard_bloc/room_card_bloc.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCardBloc, RoomCardState>(
      builder: (context, state) {
        if (state is RoomCardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RoomCardLoaded) {
          final room = state.room;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAlias,
                      height: 50,
                      width: 50,
                      child: room.images.isNotEmpty
                          ? Image.network(
                              room.images[0],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            )
                          : const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ),
                  Text(
                    room.roomType,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Area: ${room.roomArea}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Base Price: \$${room.basePrice}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        } else if (state is RoomCardError) {
          return const Center(child: Text('Error loading room details'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
