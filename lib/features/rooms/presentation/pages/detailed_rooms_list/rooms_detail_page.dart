import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_state.dart';

class RoomDetailPage extends StatelessWidget {
  const RoomDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Room Details',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<SelectedRoomBloc, SelectedRoomState>(
        builder: (context, state) {
          if (state is RoomSelected) {
            final room = state.selectedRoom;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Carousel
                  SizedBox(
                    height: 250,
                    child: PageView.builder(
                      itemCount: room.images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              room.images[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.error_outline,
                                      color: Colors.red, size: 40),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Room Info Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Room Type and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                room.roomType,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '\$${room.basePrice}/night',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Basic Information Section
                        const SectionTitle(title: 'Basic Information'),
                        const SizedBox(height: 12),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 2.5,
                          children: [
                            FeatureCard(
                                icon: Icons.square_foot,
                                title: 'Room Area',
                                value: room.roomArea),
                            FeatureCard(
                                icon: Icons.house,
                                title: 'Property Size',
                                value: '${room.propertySize} sq ft'),
                            FeatureCard(
                                icon: Icons.person_add,
                                title: 'Extra Adults',
                                value: '${room.extraAdultsAllowed}'),
                            FeatureCard(
                                icon: Icons.child_care,
                                title: 'Extra Children',
                                value: '${room.extraChildrenAllowed}'),
                          ],
                        ),

                        const SizedBox(height: 24),
                        // Meals Section
                        const SectionTitle(title: 'Included Meals'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            MealChip(
                                title: 'Breakfast',
                                included: room.freeBreakfast),
                            const SizedBox(width: 8),
                            MealChip(title: 'Lunch', included: room.freeLunch),
                            const SizedBox(width: 8),
                            MealChip(
                                title: 'Dinner', included: room.freeDinner),
                          ],
                        ),

                        const SizedBox(height: 24),
                        // Amenities Section
                        const SectionTitle(title: 'Room Amenities'),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            if (room.cupboard)
                              const AmenityChip(
                                  icon: Icons.weekend, title: 'Cupboard'),
                            if (room.wardrobe)
                              const AmenityChip(
                                  icon: Icons.door_sliding, title: 'Wardrobe'),
                            if (room.airConditioner)
                              const AmenityChip(
                                  icon: Icons.ac_unit, title: 'AC'),
                            if (room.kitchen)
                              const AmenityChip(
                                  icon: Icons.kitchen, title: 'Kitchen'),
                            if (room.wifi)
                              const AmenityChip(
                                  icon: Icons.wifi, title: 'Wi-Fi'),
                          ],
                        ),

                        const SizedBox(height: 24),
                        // Services Section
                        const SectionTitle(title: 'Hotel Services'),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            if (room.laundry)
                              const AmenityChip(
                                  icon: Icons.local_laundry_service,
                                  title: 'Laundry'),
                            if (room.elevator)
                              const AmenityChip(
                                  icon: Icons.elevator, title: 'Elevator'),
                            if (room.houseKeeping)
                              const AmenityChip(
                                  icon: Icons.cleaning_services,
                                  title: 'Housekeeping'),
                            if (room.parking)
                              const AmenityChip(
                                  icon: Icons.local_parking, title: 'Parking'),
                          ],
                        ),

                        const SizedBox(height: 32),
                        // Book Now Button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              // Add booking functionality here
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              'Book Now',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text(
              'No room selected',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const FeatureCard({
    required this.icon,
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MealChip extends StatelessWidget {
  final String title;
  final bool included;

  const MealChip({required this.title, required this.included, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: included
            ? Theme.of(context).primaryColor.withOpacity(0.1)
            : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: included ? Theme.of(context).primaryColor : Colors.grey[300]!,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: included ? Theme.of(context).primaryColor : Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class AmenityChip extends StatelessWidget {
  final IconData icon;
  final String title;

  const AmenityChip({required this.icon, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 16),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
