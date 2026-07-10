import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/features/chatbot/chat_bot.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/carousel_slider.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/widgets/hote_shimmer.dart';
import 'package:hotel_booking/features/home/presentation/pages/serachpage/hotel_serach_page.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'dart:async';

import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';

// Enhanced RoomBookingHome with better UI
class UpdatedRoomBookingHome extends StatelessWidget {
  const UpdatedRoomBookingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
          },
          color: const Color(0xFF4A90E2),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Enhanced Header with Gradient
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: LocationWithNotificationBar(),
                  ),
                ),

                const SizedBox(height: 20),

                // Enhanced Carousel with better spacing
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CarouselWidget(),
                ),

                const SizedBox(height: 24),

                // Hotels Near You Section
                SectionHeader(
                  title: 'Hotels Near You',
                  actionText: 'View All',
                  icon: Icons.location_on,
                  ontap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HotelsGridView(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: animation.drive(
                              Tween(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero),
                            ),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),
                const HotelsListView(),

                const SizedBox(height: 24),

                // Explore by City Section
                SectionHeader(
                  title: 'Explore By City',
                  actionText: 'View All',
                  icon: Icons.explore,
                  ontap: () {},
                ),
                const SizedBox(height: 16),
                const SortHotelsByLocation(),

                const SizedBox(height: 24),

                // Suggested Hotels Section
                SectionHeader(
                  title: 'Suggested Hotels',
                  actionText: 'View All',
                  icon: Icons.recommend,
                  ontap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HotelsGridView(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: animation.drive(
                              Tween(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero),
                            ),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),
                const HotelsListView(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Enhanced LocationWithNotificationBar
class LocationWithNotificationBar extends StatelessWidget {
  const LocationWithNotificationBar({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 100), (_) {
      if (context.mounted) {
        context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
      }
    });

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Location',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      // child: const FaIcon(
                      //   FontAwesomeIcons.locationDot,
                      //   size: 14,
                      //   color: Colors.white,
                      // ),
                      child: const Icon(
                        Icons.location_city, // 🔁 replaced icon
                        color: Color(0xFF4A90E2),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, state) {
                          if (state is LocationLoading) {
                            return const _LoadingLocationText();
                          } else if (state is LocationLoaded) {
                            return FutureBuilder<String>(
                              future: _getAddressFromLatLng(state.position),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const _LoadingLocationText();
                                } else if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  );
                                } else {
                                  return const Text(
                                    'Unable to fetch address',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white70,
                                    ),
                                  );
                                }
                              },
                            );
                          } else {
                            return const Text(
                              'Location unavailable',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white70,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Enhanced Notification Button
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const HotelBookingChat(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                ),
              );
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.white, Color(0xFFF0F0F0)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.chat, // 🔁 replaced icon
                color: Color(0xFF4A90E2),
                size: 20,
              ),
              // child: const FaIcon(
              //   FontAwesomeIcons.rocketchat,
              //   color: Color(0xFF4A90E2),
              //   size: 20,
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        return '${place.locality}';
      }
    } catch (e) {
      return 'Failed to get address: $e';
    }
    return 'Unknown Location';
  }
}

class _LoadingLocationText extends StatelessWidget {
  const _LoadingLocationText();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor:
                AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.8)),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Fetching location...',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

// Enhanced SectionHeader
class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final IconData? icon;
  final VoidCallback? ontap;

  const SectionHeader({
    super.key,
    required this.title,
    required this.actionText,
    this.icon,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF4A90E2).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 20,
                color: const Color(0xFF4A90E2),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
          ),
          GestureDetector(
            onTap: ontap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF4A90E2).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF4A90E2).withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    actionText,
                    style: const TextStyle(
                      color: Color(0xFF4A90E2),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Color(0xFF4A90E2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Enhanced HotelsListView
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class HotelsListView extends StatelessWidget {
  const HotelsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
      child: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelLoadingState) {
            return const HotelCardShimmerSection();
          } else if (state is HotelLoadedState) {
            return SizedBox(
              height: 300,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: state.hotels.length,
                itemBuilder: (context, index) {
                  HotelEntity hotel = state.hotels[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == state.hotels.length - 1 ? 0 : 16,
                    ),
                    child: AnimatedHotelCard(
                      hotel: hotel,
                      index: index,
                    ),
                  );
                },
              ),
            );
          } else if (state is HotelErrorState) {
            return Center(
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red.withOpacity(0.6),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: TextStyle(
                      color: Colors.red.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text(
              'No hotels found',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF7F8C8D),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedHotelCard extends StatefulWidget {
  final HotelEntity hotel;
  final int index;

  const AnimatedHotelCard({
    super.key,
    required this.hotel,
    required this.index,
  });

  @override
  State<AnimatedHotelCard> createState() => _AnimatedHotelCardState();
}

class _AnimatedHotelCardState extends State<AnimatedHotelCard>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _heartController;
  late AnimationController _shimmerController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _heartAnimation;
  late Animation<double> _shimmerAnimation;

  bool _isPressed = false;
  bool _isLiked = false;
  bool _imageLoaded = false;

  @override
  void initState() {
    super.initState();

    // Slide animation for initial appearance
    _slideController = AnimationController(
      duration: Duration(milliseconds: 600 + (widget.index * 100)),
      vsync: this,
    );

    // Scale animation for press effect
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    // Heart animation for like effect
    _heartController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Shimmer animation for image loading
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    _heartAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _heartController,
      curve: Curves.elasticOut,
    ));

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _slideController.forward();
    _shimmerController.repeat();

    // Stop shimmer after image loads
    Future.delayed(Duration(milliseconds: 800 + (widget.index * 200)), () {
      if (mounted) {
        setState(() => _imageLoaded = true);
        _shimmerController.stop();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    _heartController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _scaleController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _scaleController.reverse();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _scaleController.reverse();
  }

  void _onTap() {
    // Add haptic feedback
    HapticFeedback.lightImpact();

    context.read<SelectedHotelBloc>().add(SelectHotelEvent(widget.hotel));
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HotelDetailPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeOutCubic)),
            ),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  void _toggleLike() {
    setState(() => _isLiked = !_isLiked);
    _heartController.forward().then((_) {
      _heartController.reverse();
    });
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTapCancel: _onTapCancel,
              onTap: _onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 270,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: _isPressed
                          ? Colors.black.withOpacity(0.15)
                          : Colors.black.withOpacity(0.08),
                      blurRadius: _isPressed ? 20 : 16,
                      offset: Offset(0, _isPressed ? 6 : 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enhanced Image Container with Shimmer and Like Button
                    Stack(
                      children: [
                        Container(
                          height: 160,
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[200],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                // Image
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: _imageLoaded ? 1.0 : 0.0,
                                  child: Image.network(
                                    widget.hotel.images[0],
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey,
                                          size: 40,
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                // Shimmer Effect
                                if (!_imageLoaded)
                                  AnimatedBuilder(
                                    animation: _shimmerAnimation,
                                    builder: (context, child) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            transform: GradientRotation(
                                                _shimmerAnimation.value *
                                                    3.14159),
                                            colors: [
                                              Colors.grey[200]!,
                                              Colors.grey[100]!,
                                              Colors.grey[200]!,
                                            ],
                                            stops: const [0.0, 0.5, 1.0],
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                // Gradient Overlay
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.3),
                                      ],
                                    ),
                                  ),
                                ),

                                // Hotel Type Badge with Animation
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xFF4A90E2),
                                          const Color(0xFF357ABD),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF4A90E2)
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      widget.hotel.hotelType,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                // Animated Like Button
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: GestureDetector(
                                    onTap: _toggleLike,
                                    child: AnimatedBuilder(
                                      animation: _heartAnimation,
                                      builder: (context, child) {
                                        return Transform.scale(
                                          scale: _heartAnimation.value,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              _isLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: _isLiked
                                                  ? Colors.red
                                                  : Colors.grey[600],
                                              size: 18,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Hotel Information with Staggered Animation
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Hotel Name and Price with Slide Animation
                          TweenAnimationBuilder<double>(
                            duration: Duration(
                                milliseconds: 400 + (widget.index * 50)),
                            tween: Tween(begin: 0.0, end: 1.0),
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, 20 * (1 - value)),
                                child: Opacity(
                                  opacity: value,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.hotel.hotelName,
                                          style: const TextStyle(
                                            color: Color(0xFF2C3E50),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xFF4A90E2)
                                                      .withOpacity(0.1),
                                                  const Color(0xFF357ABD)
                                                      .withOpacity(0.1),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              '₹${widget.hotel.propertySetup}',
                                              style: const TextStyle(
                                                color: Color(0xFF4A90E2),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            '/night',
                                            style: TextStyle(
                                              color: Color(0xFF7F8C8D),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 8),

                          // Location with Slide Animation
                          TweenAnimationBuilder<double>(
                            duration: Duration(
                                milliseconds: 500 + (widget.index * 50)),
                            tween: Tween(begin: 0.0, end: 1.0),
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, 20 * (1 - value)),
                                child: Opacity(
                                  opacity: value,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red[50],
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: Colors.red[400],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          '${widget.hotel.city}, ${widget.hotel.state}',
                                          style: const TextStyle(
                                            color: Color(0xFF7F8C8D),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EnhancedHotelCard extends StatelessWidget {
  final HotelEntity hotel;

  const _EnhancedHotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SelectedHotelBloc>().add(SelectHotelEvent(hotel));
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HotelDetailPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(0.0, 1.0), end: Offset.zero),
                ),
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhanced Image Container
            Container(
              height: 150,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(hotel.images[0]),
                ),
              ),
              child: Stack(
                children: [
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                  // Hotel Type Badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90E2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        hotel.hotelType,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Hotel Information
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel Name and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          hotel.hotelName,
                          style: const TextStyle(
                            color: Color(0xFF2C3E50),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${hotel.propertySetup}',
                            style: const TextStyle(
                              color: Color(0xFF4A90E2),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            '/night',
                            style: TextStyle(
                              color: Color(0xFF7F8C8D),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.red[400],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${hotel.city}, ${hotel.state}',
                          style: const TextStyle(
                            color: Color(0xFF7F8C8D),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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

// Enhanced SortHotelsByLocation
class SortHotelsByLocation extends StatelessWidget {
  const SortHotelsByLocation({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      const Duration(seconds: 100),
      (_) {
        if (context.mounted) {
          context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
        }
      },
    );

    final List<Map<String, String>> locations = [
      {'image': 'assets/images/mumbai_hotel.jpg', 'text': 'Mumbai'},
      {'image': 'assets/images/dehi.jpeg', 'text': 'Delhi'},
      {'image': 'assets/images/kolkata.jpg', 'text': 'Kolkata'},
      {'image': 'assets/images/chennai.jpg', 'text': 'Chennai'},
      {'image': 'assets/images/banglore.jpg', 'text': 'Bangalore'},
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == locations.length - 1 ? 0 : 16,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        location['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    location['text']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
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
}
