// rooms_detail_page.dart
//
// Room detail screen reached by tapping a room card on the hotel detail
// page. Reuses AppColors / AppTextStyles from home_page_section.dart so it
// stays visually consistent with HotelDetailsPage.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/hotel_booking_screen.dart';
import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_state.dart';

class RoomDetailPage extends StatelessWidget {
  const RoomDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<SelectedRoomBloc, SelectedRoomState>(
        builder: (context, state) {
          if (state is RoomSelected) {
            return _RoomDetailsBody(room: state.selectedRoom);
          }
          return const Center(
            child: Text('Error loading room details.',
                style: AppTextStyles.hotelLocation),
          );
        },
      ),
    );
  }
}

class _RoomDetailsBody extends StatelessWidget {
  final RoomEntity room;
  const _RoomDetailsBody({required this.room});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildImageAppBar(context),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleRow(),
                const SizedBox(height: 16),
                _buildPriceCard(),
                const SizedBox(height: 24),
                const Text('Room Information', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                _buildInfoChips(),
                const SizedBox(height: 24),
                const Text('Included Meals', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                _buildMeals(),
                const SizedBox(height: 24),
                const Text('Room Amenities', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                _buildRoomAmenities(),
                const SizedBox(height: 24),
                const Text('Hotel Services', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                _buildHotelServices(),
                const SizedBox(height: 32),
                _buildBookNowButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageAppBar(BuildContext context) {
    final images = room.images;
    return SliverAppBar(
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.primary,
      expandedHeight: 280,
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: _CircleIconButton(
          icon: Icons.arrow_back_rounded,
          onTap: () => Navigator.pop(context),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'room-${room.roomId}',
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: images.isEmpty
                ? const Center(
                    child: Icon(Icons.bed_rounded,
                        size: 64, color: Colors.white),
                  )
                : PageView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) => Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.bed_rounded,
                            size: 64, color: Colors.white),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(room.roomType, style: AppTextStyles.username),
        ),
        const SizedBox(width: 10),
        _AreaBadge(area: room.roomArea),
      ],
    );
  }

  Widget _buildPriceCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Text('₹${room.basePrice}', style: AppTextStyles.price),
          Text(' /night', style: AppTextStyles.priceUnit),
          const Spacer(),
          Text(room.roomType,
              style: AppTextStyles.chip.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _buildInfoChips() {
    final chips = <String>[
      'Area: ${room.roomArea}',
      'Property size: ${room.propertySize} sq ft',
      'Extra adults: ${room.extraAdultsAllowed}',
      'Extra children: ${room.extraChildrenAllowed}',
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children:
          chips.map((label) => _InfoChip(label: label)).toList(growable: false),
    );
  }

  Widget _buildMeals() {
    final meals = <_Amenity>[
      _Amenity('Breakfast', Icons.free_breakfast_rounded, room.freeBreakfast),
      _Amenity('Lunch', Icons.lunch_dining_rounded, room.freeLunch),
      _Amenity('Dinner', Icons.dinner_dining_rounded, room.freeDinner),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: meals.map((a) => _AmenityTile(amenity: a)).toList(growable: false),
    );
  }

  Widget _buildRoomAmenities() {
    final amenities = <_Amenity>[
      _Amenity('Cupboard', Icons.weekend_rounded, room.cupboard),
      _Amenity('Wardrobe', Icons.door_sliding_rounded, room.wardrobe),
      _Amenity('Air conditioner', Icons.ac_unit_rounded, room.airConditioner),
      _Amenity('Kitchen', Icons.kitchen_rounded, room.kitchen),
      _Amenity('Wi-Fi', Icons.wifi_rounded, room.wifi),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: amenities
          .map((a) => _AmenityTile(amenity: a))
          .toList(growable: false),
    );
  }

  Widget _buildHotelServices() {
    final services = <_Amenity>[
      _Amenity('Laundry', Icons.local_laundry_service_rounded, room.laundry),
      _Amenity('Elevator', Icons.elevator_rounded, room.elevator),
      _Amenity(
          'Housekeeping', Icons.cleaning_services_rounded, room.houseKeeping),
      _Amenity('Parking', Icons.local_parking_rounded, room.parking),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: services
          .map((a) => _AmenityTile(amenity: a))
          .toList(growable: false),
    );
  }

  Widget _buildBookNowButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HotelBookingScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text(
          'Book Now',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _Amenity {
  final String label;
  final IconData icon;
  final bool available;
  const _Amenity(this.label, this.icon, this.available);
}

class _AmenityTile extends StatelessWidget {
  final _Amenity amenity;
  const _AmenityTile({required this.amenity});

  @override
  Widget build(BuildContext context) {
    final active = amenity.available;
    return Opacity(
      opacity: active ? 1 : 0.4,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(amenity.icon,
                size: 18,
                color: active ? AppColors.primary : AppColors.textGrey),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                amenity.label,
                style: AppTextStyles.chip.copyWith(
                  fontSize: 12.5,
                  color: AppColors.textDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: AppTextStyles.chip.copyWith(color: AppColors.primary),
      ),
    );
  }
}

class _AreaBadge extends StatelessWidget {
  final String area;
  const _AreaBadge({required this.area});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.square_foot_rounded,
              size: 14, color: AppColors.accent),
          const SizedBox(width: 3),
          Text(
            area,
            style: AppTextStyles.rating.copyWith(color: AppColors.textDark),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
