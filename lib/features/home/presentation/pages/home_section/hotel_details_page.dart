// hotel_details_page.dart
//
// Hotel detail screen reached by tapping a hotel card on the home page.
// Reuses AppColors / AppTextStyles from home_page_section.dart so it stays
// visually consistent with the rest of the home experience.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';
import 'package:hotel_booking/features/report/presentation/providers/bloc/report_bloc.dart';
import 'package:hotel_booking/features/report/presentation/providers/bloc/report_event.dart';
import 'package:hotel_booking/features/report/presentation/providers/bloc/report_state.dart';
import 'package:hotel_booking/features/review/data/model/review_model.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';
import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';
import 'package:hotel_booking/features/rooms/presentation/pages/detailed_rooms_list/rooms_detail_page.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_event.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_state.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_event.dart';
import 'package:hotel_booking/features/wishlist/presentation/provider/bloc/favorites_bloc.dart';
import 'package:hotel_booking/utils/snackbar/snackbar.dart';

class HotelDetailsPage extends StatelessWidget {
  const HotelDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
        builder: (context, state) {
          if (state is SelectedHotelLoaded) {
            return _HotelDetailsBody(hotel: state.hotel);
          }
          return const Center(
            child: Text('Error loading hotel details.',
                style: AppTextStyles.hotelLocation),
          );
        },
      ),
    );
  }
}

class _HotelDetailsBody extends StatelessWidget {
  final HotelEntity hotel;
  const _HotelDetailsBody({required this.hotel});

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
                const SizedBox(height: 8),
                _buildLocationRow(),
                const SizedBox(height: 16),
                _buildPriceCard(),
                const SizedBox(height: 24),
                const Text('About this property',
                    style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                _buildInfoChips(),
                const SizedBox(height: 24),
                const Text('Amenities', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                _buildAmenities(),
                const SizedBox(height: 24),
                _buildRoomsSection(),
                const SizedBox(height: 24),
                const Text('Location', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                _HotelLocationSection(hotel: hotel),
                const SizedBox(height: 24),
                _ReviewsSection(hotel: hotel),
                const SizedBox(height: 24),
                _ReportIssueSection(hotelId: hotel.hotelId),
                const SizedBox(height: 24),
                const Text('Contact', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                _buildContactCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageAppBar(BuildContext context) {
    final imageUrl = hotel.images.isNotEmpty ? hotel.images.first : null;
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
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: _FavoriteButton(hotelId: hotel.hotelId),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'hotel-${hotel.hotelId}',
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: imageUrl == null
                ? const Center(
                    child: Icon(Icons.hotel_rounded,
                        size: 64, color: Colors.white),
                  )
                : Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.hotel_rounded,
                          size: 64, color: Colors.white),
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
          child: Text(hotel.hotelName, style: AppTextStyles.username),
        ),
        const SizedBox(width: 10),
        const _RatingBadge(rating: 4.5),
      ],
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        const Icon(Icons.location_on_rounded,
            size: 16, color: AppColors.textGrey),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            '${hotel.city}, ${hotel.state}, ${hotel.country}',
            style: AppTextStyles.hotelLocation,
          ),
        ),
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
          Text('₹${hotel.propertySetup}', style: AppTextStyles.price),
          Text(' /night', style: AppTextStyles.priceUnit),
          const Spacer(),
          Text(hotel.hotelType, style: AppTextStyles.chip.copyWith(
            color: AppColors.primary,
          )),
        ],
      ),
    );
  }

  Widget _buildInfoChips() {
    final chips = <String>[
      if (hotel.entireProperty) 'Entire property',
      if (hotel.privateProperty) 'Private property',
      if (hotel.leased) 'Leased',
    ];
    if (chips.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children:
          chips.map((label) => _InfoChip(label: label)).toList(growable: false),
    );
  }

  Widget _buildAmenities() {
    final amenities = <_Amenity>[
      _Amenity('Free cancellation', Icons.event_available_rounded,
          hotel.freeCancel),
      _Amenity('Couple friendly', Icons.favorite_rounded,
          hotel.coupleFriendly),
      _Amenity(
          'Parking', Icons.local_parking_rounded, hotel.parkingFacility),
      _Amenity('Restaurant', Icons.restaurant_rounded,
          hotel.restaurantFacility),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: amenities
          .map((a) => _AmenityTile(amenity: a))
          .toList(growable: false),
    );
  }

  Widget _buildRoomsSection() {
    return BlocProvider(
      create: (context) =>
          sl<HotelRoomsBloc>()..add(LoadHotelRoomsEvent(hotel)),
      child: BlocBuilder<HotelRoomsBloc, HotelRoomsState>(
        builder: (context, state) {
          if (state is HotelRoomsLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }
          if (state is HotelRoomsError) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(state.message, style: AppTextStyles.hotelLocation),
            );
          }
          if (state is HotelRoomsLoaded) {
            if (state.rooms.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('No rooms available',
                    style: AppTextStyles.hotelLocation),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Available Rooms', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                SizedBox(
                  height: 230,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.rooms.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) =>
                        _RoomCard(room: state.rooms[index]),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          _ContactRow(icon: Icons.call_rounded, text: hotel.contactNumber),
          const SizedBox(height: 12),
          _ContactRow(icon: Icons.email_rounded, text: hotel.emailAddress),
          const SizedBox(height: 12),
          _ContactRow(
            icon: Icons.pin_drop_rounded,
            text: '${hotel.city}, ${hotel.state} - ${hotel.pincode}',
          ),
        ],
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

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 16, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.hotelLocation.copyWith(
              color: AppColors.textDark,
              fontSize: 13.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final double rating;
  const _RatingBadge({required this.rating});

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
          const Icon(Icons.star_rounded, size: 14, color: AppColors.accent),
          const SizedBox(width: 3),
          Text(
            rating.toString(),
            style: AppTextStyles.rating.copyWith(color: AppColors.textDark),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatefulWidget {
  final String hotelId;
  const _FavoriteButton({required this.hotelId});

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(LoadFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesLoaded) {
          setState(
            () => _isFavorite = state.favorites.contains(widget.hotelId),
          );
        } else if (state is FavoriteAdded) {
          setState(() => _isFavorite = true);
          showCustomSnackBar(context, 'Added to favorites', Colors.green);
        } else if (state is FavoriteRemoved) {
          setState(() => _isFavorite = false);
          showCustomSnackBar(context, 'Removed from favorites', Colors.green);
        } else if (state is FavoritesError) {
          showCustomSnackBar(context, state.message, Colors.red);
        }
      },
      builder: (context, state) {
        return _CircleIconButton(
          icon: _isFavorite
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          iconColor: _isFavorite ? Colors.redAccent : Colors.white,
          onTap: () {
            if (_isFavorite) {
              context
                  .read<FavoritesBloc>()
                  .add(RemoveFromFavoritesEvent(widget.hotelId));
            } else {
              context
                  .read<FavoritesBloc>()
                  .add(AddToFavoritesEvent(widget.hotelId));
            }
          },
        );
      },
    );
  }
}

class _RoomCard extends StatelessWidget {
  final RoomEntity room;
  const _RoomCard({required this.room});

  @override
  Widget build(BuildContext context) {
    final imageUrl = room.images.isNotEmpty ? room.images.first : null;
    return GestureDetector(
      onTap: () {
        context.read<SelectedRoomBloc>().add(SelectRoomEvent(room));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RoomDetailPage()),
        );
      },
      child: Container(
        width: 190,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(22)),
              child: SizedBox(
                height: 110,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.primaryDark],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: imageUrl == null
                            ? const Center(
                                child: Icon(Icons.bed_rounded,
                                    size: 32, color: Colors.white),
                              )
                            : Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                  child: Icon(Icons.bed_rounded,
                                      size: 32, color: Colors.white),
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          room.roomType,
                          style: AppTextStyles.chip.copyWith(
                            color: AppColors.primary,
                            fontSize: 11.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.square_foot_rounded,
                          size: 14, color: AppColors.textGrey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Area: ${room.roomArea}',
                          style: AppTextStyles.hotelLocation,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (room.wifi)
                        const _RoomFeatureIcon(icon: Icons.wifi_rounded),
                      if (room.airConditioner)
                        const _RoomFeatureIcon(icon: Icons.ac_unit_rounded),
                      if (room.freeBreakfast)
                        const _RoomFeatureIcon(
                            icon: Icons.free_breakfast_rounded),
                      if (room.parking)
                        const _RoomFeatureIcon(
                            icon: Icons.local_parking_rounded),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${room.basePrice}', style: AppTextStyles.price),
                      Text(' /night', style: AppTextStyles.priceUnit),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoomFeatureIcon extends StatelessWidget {
  final IconData icon;
  const _RoomFeatureIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 13, color: AppColors.primary),
    );
  }
}

class _HotelLocationSection extends StatelessWidget {
  final HotelEntity hotel;
  const _HotelLocationSection({required this.hotel});

  @override
  Widget build(BuildContext context) {
    final address = '${hotel.city}, ${hotel.state}, ${hotel.country}';
    return BlocProvider(
      create: (context) =>
          sl<LocationBloc>()..add(FetchLatLngFromAddressEvent(address)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 200,
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
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationLoaded) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: state.position,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(hotel.hotelId),
                      position: state.position,
                      infoWindow: InfoWindow(title: hotel.hotelName),
                    ),
                  },
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                );
              }
              if (state is LocationError) {
                return Center(
                  child: Text(state.message, style: AppTextStyles.hotelLocation),
                );
              }
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ReviewsSection extends StatefulWidget {
  final HotelEntity hotel;
  const _ReviewsSection({required this.hotel});

  @override
  State<_ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<_ReviewsSection> {
  @override
  void initState() {
    super.initState();
    context.read<ReviewBloc>().add(FetchReviews(widget.hotel.hotelId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        final reviews =
            state is ReviewLoaded ? state.reviews : const <ReviewModel>[];
        final avgRating = reviews.isEmpty
            ? 0.0
            : reviews.fold<double>(
                  0,
                  (sum, r) => sum + (double.tryParse(r.rating ?? '0') ?? 0),
                ) /
                reviews.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Reviews', style: AppTextStyles.sectionTitle),
                    if (reviews.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      _RatingBadge(
                        rating: double.parse(avgRating.toStringAsFixed(1)),
                      ),
                    ],
                  ],
                ),
                GestureDetector(
                  onTap: () => _openWriteReviewSheet(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_rounded, size: 14, color: Colors.white),
                        SizedBox(width: 6),
                        Text(
                          'Write a review',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (state is ReviewInitial)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              )
            else if (reviews.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
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
                child: const Text(
                  'No reviews yet. Be the first to share your experience!',
                  style: AppTextStyles.hotelLocation,
                ),
              )
            else
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: reviews.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) => _ReviewTile(
                    review: reviews[index],
                    hotelId: widget.hotel.hotelId,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _openWriteReviewSheet(BuildContext context) {
    final reviewBloc = context.read<ReviewBloc>();
    final controller = TextEditingController();
    double rating = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Rate your stay',
                    style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(5, (i) {
                    return GestureDetector(
                      onTap: () => setSheetState(() => rating = i + 1),
                      child: Icon(
                        i < rating
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        size: 32,
                        color: AppColors.accent,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  maxLines: 3,
                  style: AppTextStyles.hotelLocation
                      .copyWith(color: AppColors.textDark, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Share your experience...',
                    hintStyle: AppTextStyles.hotelLocation,
                    filled: true,
                    fillColor: AppColors.background,
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (controller.text.trim().isEmpty || rating == 0) {
                        showCustomSnackBar(
                          sheetContext,
                          'Please add a rating and a comment',
                          Colors.red,
                        );
                        return;
                      }
                      reviewBloc.add(
                        AddReview(
                          ReviewModel(
                            reviewcontent: controller.text.trim(),
                            rating: rating.toString(),
                            reviewdate: DateTime.now(),
                          ),
                          widget.hotel.hotelId,
                        ),
                      );
                      Navigator.pop(sheetContext);
                    },
                    child: const Text(
                      'Post review',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final ReviewModel review;
  final String hotelId;
  const _ReviewTile({required this.review, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    final isMine = review.useremail != null &&
        review.useremail == FirebaseAuth.instance.currentUser?.email;
    final ratingValue = double.tryParse(review.rating ?? '0') ?? 0;

    return Container(
      width: 230,
      padding: const EdgeInsets.all(14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.primary.withOpacity(0.15),
                child: Text(
                  (review.useremail?.isNotEmpty ?? false)
                      ? review.useremail![0].toUpperCase()
                      : '?',
                  style: AppTextStyles.chip
                      .copyWith(color: AppColors.primary, fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  review.useremail ?? 'Guest',
                  style: AppTextStyles.chip
                      .copyWith(color: AppColors.textDark, fontSize: 12.5),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isMine)
                GestureDetector(
                  onTap: () => context
                      .read<ReviewBloc>()
                      .add(DeleteReview(review.id ?? '', hotelId)),
                  child: const Icon(Icons.close_rounded,
                      size: 16, color: AppColors.textGrey),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              5,
              (i) => Icon(
                Icons.star_rounded,
                size: 12,
                color: i < ratingValue
                    ? AppColors.accent
                    : AppColors.background,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              review.reviewcontent ?? '',
              style: AppTextStyles.hotelLocation
                  .copyWith(color: AppColors.textDark, fontSize: 12.5),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportIssueSection extends StatelessWidget {
  final String hotelId;
  const _ReportIssueSection({required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportIssueBloc, ReportIssueState>(
      listener: (context, state) {
        if (state is ReportIssueSuccessState) {
          showCustomSnackBar(context, state.successMessage, Colors.green);
        } else if (state is ReportIssueFailureState) {
          showCustomSnackBar(context, state.errorMessage, Colors.red);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
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
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.flag_rounded,
                  color: AppColors.accent, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spotted a problem?',
                    style: AppTextStyles.chip.copyWith(
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Let us know and we'll look into it.",
                    style: AppTextStyles.hotelLocation,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _openReportDialog(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('Report', style: AppTextStyles.sectionLink),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openReportDialog(BuildContext context) {
    final reportBloc = context.read<ReportIssueBloc>();
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Report an issue', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 4,
                style: AppTextStyles.hotelLocation
                    .copyWith(color: AppColors.textDark, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Describe the issue...',
                  hintStyle: AppTextStyles.hotelLocation,
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.all(14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.chip
                            .copyWith(color: AppColors.textGrey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (controller.text.trim().isEmpty) return;
                        reportBloc.add(SubmitReportEvent(
                          issueContent: controller.text.trim(),
                          hotelId: hotelId,
                        ));
                        Navigator.pop(dialogContext);
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.white,
  });

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
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}
