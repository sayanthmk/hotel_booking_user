// hotel_booking_home_page.dart
//
// Advanced Hotel Booking App - Home Page
// Features:
//  - Animated header with fade + slide entrance
//  - Custom TextStyle system (see AppTextStyles)
//  - Animated search bar with scale/tap feedback
//  - Animated category chips (selectable, scaled on tap)
//  - Horizontal "Featured Hotels" list with Hero animations + staggered entrance
//  - Vertical "Popular Nearby" list with animated rating badges
//  - Floating animated bottom nav bar
//
// Drop this file into your Flutter project (e.g. lib/screens/home_page.dart)
// and run it, or wire HomePage() into your MaterialApp's home.
//
// Dependencies: none beyond Flutter SDK (pure Flutter animations, no packages).
// If you want smoother physics-based animations, consider adding:
//   flutter pub add google_fonts cached_network_image
// This file is written to work without them (uses Icons/Container placeholders
// for images so it compiles out of the box).

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_bloc.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_event.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/hotel_details_page.dart';

// ----------------------------------------------------------------------
// DESIGN TOKENS
// ----------------------------------------------------------------------

class AppColors {
  static const primary = Color(0xFF2E5BFF);
  static const primaryDark = Color(0xFF1A3AC7);
  static const accent = Color(0xFFFFB020);
  static const background = Color(0xFFF7F8FC);
  static const cardShadow = Color(0x1A2E5BFF);
  static const textDark = Color(0xFF12163A);
  static const textGrey = Color(0xFF8B90A8);
}

class AppTextStyles {
  static const TextStyle greeting = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
    letterSpacing: 0.2,
  );

  static const TextStyle username = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textDark,
    letterSpacing: -0.3,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    letterSpacing: -0.2,
  );

  static const TextStyle sectionLink = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle hotelName = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static const TextStyle hotelLocation = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );

  static const TextStyle price = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
  );

  static const TextStyle priceUnit = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );

  static const TextStyle chip = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle rating = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
}

const List<Map<String, dynamic>> categories = [
  {'label': 'All', 'icon': Icons.apps_rounded},
  {'label': 'Beach', 'icon': Icons.beach_access_rounded},
  {'label': 'Mountain', 'icon': Icons.terrain_rounded},
  {'label': 'City', 'icon': Icons.location_city_rounded},
  {'label': 'Villa', 'icon': Icons.villa_rounded},
];

// ----------------------------------------------------------------------
// HOME PAGE
// ----------------------------------------------------------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;

  int _selectedCategory = 0;
  // int _currentNavIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HotelBloc>().add(LoadHotelsEvent());
    context.read<UserProfileBloc>().add(LoadUsers());
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _headerFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _headerSlide =
        Tween<Offset>(begin: const Offset(0, -0.15), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<HotelBloc, HotelState>(
          builder: (context, state) {
            final hotels = state is HotelLoadedState
                ? state.hotels
                : const <HotelEntity>[];
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _headerFade,
                    child: SlideTransition(
                      position: _headerSlide,
                      child: _buildHeader(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: _buildSearchBar(hotels)),
                SliverToBoxAdapter(child: _buildCategories()),
                ..._buildHotelSlivers(state),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            );
          },
        ),
      ),
    );
  }

  // ---------------- Hotel data slivers ----------------
  List<Widget> _buildHotelSlivers(HotelState state) {
    if (state is HotelErrorState) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Text(state.message, style: AppTextStyles.hotelLocation),
          ),
        ),
      ];
    }

    if (state is HotelLoadedState) {
      final hotels = state.hotels;
      if (hotels.isEmpty) {
        return const [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child:
                  Text('No hotels found', style: AppTextStyles.hotelLocation),
            ),
          ),
        ];
      }
      return [
        SliverToBoxAdapter(
          child: _buildSectionHeader('Featured Hotels', 'See all'),
        ),
        SliverToBoxAdapter(child: _buildFeaturedList(hotels)),
        SliverToBoxAdapter(
          child: _buildSectionHeader('Popular Nearby', 'See all'),
        ),
        _buildNearbyList(hotels),
      ];
    }

    // HotelInitial, HotelLoadingState, HotelDetailLoadedState
    return _buildLoadingShimmerSlivers();
  }

  // ---------------- Loading shimmer ----------------
  List<Widget> _buildLoadingShimmerSlivers() {
    return [
      SliverToBoxAdapter(
        child: _buildSectionHeader('Featured Hotels', 'See all'),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 230,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) => const _FeaturedCardShimmer(),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: _buildSectionHeader('Popular Nearby', 'See all'),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => const Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: _NearbyTileShimmer(),
            ),
            childCount: 4,
          ),
        ),
      ),
    ];
  }

  // ---------------- Header ----------------
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Good afternoon 👋', style: AppTextStyles.greeting),
                const SizedBox(height: 4),
                BlocBuilder<UserProfileBloc, UserProfileState>(
                  builder: (context, state) {
                    final name =
                        state is UserLoaded && state.user.name.isNotEmpty
                            ? state.user.name
                            : 'Guest';
                    return Text('Where to next, $name?',
                        style: AppTextStyles.username);
                  },
                ),
              ],
            ),
          ),
          Hero(
            tag: 'profile-avatar',
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Icons.person_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Search bar ----------------
  Widget _buildSearchBar(List<HotelEntity> hotels) {
    void runSearch(String query) {
      context
          .read<HotelSearchBloc>()
          .add(SearchHotelsEvent(query: query, allHotels: hotels));
      setState(() {});
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                const Icon(Icons.search_rounded, color: AppColors.textGrey),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: runSearch,
                    style: AppTextStyles.hotelLocation.copyWith(
                      color: AppColors.textDark,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'Search destination, hotel...',
                      hintStyle: AppTextStyles.hotelLocation.copyWith(
                        color: AppColors.textGrey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      runSearch('');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.close_rounded,
                        color: AppColors.textGrey,
                        size: 20,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
          if (_searchController.text.isNotEmpty) _buildSearchResults(),
        ],
      ),
    );
  }

  // ---------------- Search results dropdown ----------------
  Widget _buildSearchResults() {
    return BlocBuilder<HotelSearchBloc, HotelSearchState>(
      builder: (context, state) {
        Widget content;
        if (state is HotelSearchLoadingState) {
          content = const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: _SearchResultsShimmer(),
          );
        } else if (state is HotelSearchErrorState) {
          content = Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(state.message, style: AppTextStyles.hotelLocation),
          );
        } else if (state is HotelSearchLoadedState) {
          final results = state.filteredHotels;
          if (results.isEmpty) {
            content = const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('No hotels match your search',
                  style: AppTextStyles.hotelLocation),
            );
          } else {
            content = ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 6),
              itemCount: results.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: AppColors.background),
              itemBuilder: (context, index) {
                final hotel = results[index];
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: _HotelImage(hotel: hotel, iconSize: 20),
                    ),
                  ),
                  title: Text(
                    hotel.hotelName,
                    style: AppTextStyles.hotelName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${hotel.city}, ${hotel.state}',
                    style: AppTextStyles.hotelLocation,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text('₹${hotel.propertySetup}',
                      style: AppTextStyles.price),
                );
              },
            );
          }
        } else {
          content = const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.only(top: 8),
          constraints: const BoxConstraints(maxHeight: 280),
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
          child: content,
        );
      },
    );
  }

  // ---------------- Categories ----------------
  Widget _buildCategories() {
    return SizedBox(
      height: 59,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final selected = _selectedCategory == index;
          final cat = categories[index];
          return _AnimatedTapScale(
            onTap: () => setState(() => _selectedCategory = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: selected
                        ? AppColors.primary.withOpacity(0.35)
                        : AppColors.cardShadow,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    cat['icon'] as IconData,
                    size: 17,
                    color: selected ? Colors.white : AppColors.textGrey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    cat['label'] as String,
                    style: AppTextStyles.chip.copyWith(
                      color: selected ? Colors.white : AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- Section header ----------------
  Widget _buildSectionHeader(String title, String action) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.sectionTitle),
          Text(action, style: AppTextStyles.sectionLink),
        ],
      ),
    );
  }

  // ---------------- Featured horizontal list ----------------
  Widget _buildFeaturedList(List<HotelEntity> hotels) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: hotels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return _StaggeredEntrance(
            index: index,
            child: _FeaturedHotelCard(hotel: hotel),
          );
        },
      ),
    );
  }

  // ---------------- Nearby vertical list ----------------
  Widget _buildNearbyList(List<HotelEntity> hotels) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final hotel = hotels[index];
          return _StaggeredEntrance(
            index: index,
            horizontal: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _NearbyHotelTile(hotel: hotel),
            ),
          );
        }, childCount: hotels.length),
      ),
    );
  }

  // ---------------- Bottom nav ----------------
}

// ----------------------------------------------------------------------
// REUSABLE ANIMATED WIDGETS
// ----------------------------------------------------------------------

/// Wraps a child with a subtle scale-down animation on tap for tactile feedback.
class _AnimatedTapScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _AnimatedTapScale({required this.child, required this.onTap});

  @override
  State<_AnimatedTapScale> createState() => _AnimatedTapScaleState();
}

class _AnimatedTapScaleState extends State<_AnimatedTapScale> {
  double _scale = 1.0;

  void _setScale(double value) => setState(() => _scale = value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _setScale(0.96),
      onTapUp: (_) => _setScale(1.0),
      onTapCancel: () => _setScale(1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

/// Fades and slides in a child based on its index, creating a staggered
/// entrance effect for list items.
class _StaggeredEntrance extends StatefulWidget {
  final Widget child;
  final int index;
  final bool horizontal;

  const _StaggeredEntrance({
    required this.child,
    required this.index,
    this.horizontal = true,
  });

  @override
  State<_StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<_StaggeredEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: widget.horizontal ? const Offset(0.25, 0) : const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: 90 * widget.index), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

// ----------------------------------------------------------------------
// HOTEL CARDS
// ----------------------------------------------------------------------

class _FeaturedHotelCard extends StatelessWidget {
  final HotelEntity hotel;
  const _FeaturedHotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return _AnimatedTapScale(
      onTap: () {
        context.read<SelectedHotelBloc>().add(SelectHotelEvent(hotel));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HotelDetailsPage(),
          ),
        );
      },
      child: Container(
        width: 200,
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
            Hero(
              tag: 'hotel-${hotel.hotelId}',
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
                child: SizedBox(
                  height: 130,
                  child: Stack(
                    children: [
                      Positioned.fill(child: _HotelImage(hotel: hotel)),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: const _RatingBadge(rating: 4.5),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.hotelName,
                    style: AppTextStyles.hotelName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 13,
                        color: AppColors.textGrey,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          '${hotel.city}, ${hotel.state}',
                          style: AppTextStyles.hotelLocation,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${hotel.propertySetup}',
                          style: AppTextStyles.price),
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

/// Shows the hotel's first network image, falling back to a gradient +
/// icon placeholder when no image is available or it fails to load.
class _HotelImage extends StatelessWidget {
  final HotelEntity hotel;
  final double iconSize;

  const _HotelImage({required this.hotel, this.iconSize = 40});

  @override
  Widget build(BuildContext context) {
    final imageUrl = hotel.images.isNotEmpty ? hotel.images.first : null;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: imageUrl == null
          ? Center(
              child: Icon(Icons.hotel_rounded,
                  size: iconSize, color: Colors.white),
            )
          : Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Icon(Icons.hotel_rounded,
                    size: iconSize, color: Colors.white),
              ),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.25),
                  highlightColor: Colors.white.withOpacity(0.55),
                  child: Container(color: Colors.white),
                );
              },
            ),
    );
  }
}

class _NearbyHotelTile extends StatelessWidget {
  final HotelEntity hotel;
  const _NearbyHotelTile({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return _AnimatedTapScale(
      onTap: () {
        context.read<SelectedHotelBloc>().add(SelectHotelEvent(hotel));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HotelDetailsPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 78,
                height: 78,
                child: _HotelImage(hotel: hotel, iconSize: 30),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hotel.hotelName, style: AppTextStyles.hotelName),
                  const SizedBox(height: 4),
                  Text('${hotel.city}, ${hotel.state}',
                      style: AppTextStyles.hotelLocation),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const _RatingBadge(rating: 4.5, compact: true),
                      const Spacer(),
                      Text('₹${hotel.propertySetup}',
                          style: AppTextStyles.price),
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

class _RatingBadge extends StatelessWidget {
  final double rating;
  final bool compact;
  const _RatingBadge({required this.rating, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 8,
        vertical: compact ? 3 : 4,
      ),
      decoration: BoxDecoration(
        color: compact
            ? AppColors.accent.withOpacity(0.15)
            : Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            size: compact ? 13 : 14,
            color: compact ? AppColors.accent : AppColors.accent,
          ),
          const SizedBox(width: 3),
          Text(
            rating.toString(),
            style: compact
                ? AppTextStyles.rating.copyWith(color: AppColors.textDark)
                : AppTextStyles.rating,
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------
// SHIMMER LOADING PLACEHOLDERS
// ----------------------------------------------------------------------

/// A rounded, solid-color block used as the skeleton shape inside a
/// [Shimmer.fromColors] child tree.
class _ShimmerBlock extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const _ShimmerBlock({
    this.width,
    required this.height,
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Mirrors [_FeaturedHotelCard]'s layout as a shimmering skeleton.
class _FeaturedCardShimmer extends StatelessWidget {
  const _FeaturedCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ShimmerBlock(height: 130, borderRadius: 22),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _ShimmerBlock(height: 14, width: 120),
                  SizedBox(height: 8),
                  _ShimmerBlock(height: 10, width: 90),
                  SizedBox(height: 14),
                  _ShimmerBlock(height: 14, width: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Mirrors [_NearbyHotelTile]'s layout as a shimmering skeleton.
class _NearbyTileShimmer extends StatelessWidget {
  const _NearbyTileShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const _ShimmerBlock(width: 78, height: 78, borderRadius: 16),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _ShimmerBlock(height: 14, width: 140),
                  SizedBox(height: 8),
                  _ShimmerBlock(height: 10, width: 100),
                  SizedBox(height: 10),
                  _ShimmerBlock(height: 12, width: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Mirrors the search results [ListTile] rows as a shimmering skeleton.
class _SearchResultsShimmer extends StatelessWidget {
  const _SearchResultsShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: const [
                _ShimmerBlock(width: 44, height: 44, borderRadius: 10),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ShimmerBlock(height: 13, width: 140),
                      SizedBox(height: 6),
                      _ShimmerBlock(height: 10, width: 90),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                _ShimmerBlock(height: 13, width: 40),
              ],
            ),
          );
        }),
      ),
    );
  }
}
