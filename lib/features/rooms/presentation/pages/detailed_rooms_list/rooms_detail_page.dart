import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_page/booking_ui.dart';
import 'package:hotel_booking/features/rooms/presentation/pages/detailed_rooms_list/detail_room_widgets.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_state.dart';

class RoomDetailPage extends StatelessWidget {
  const RoomDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text(
      //     'Room Details',
      //     style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      //   ),
      // ),
      appBar: AppBar(
        title: const Text(
          'Room Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: HotelBookingColors.basictextcolor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                color: HotelBookingColors.basictextcolor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '₹${room.basePrice}/night',
                                style: const TextStyle(
                                  color: HotelBookingColors.basictextcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
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
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HotelBookingPage(),
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  HotelBookingColors.basictextcolor,
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
                                  color: Colors.white),
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
