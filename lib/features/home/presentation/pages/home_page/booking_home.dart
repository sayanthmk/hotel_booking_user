// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:hotel_booking/core/constants/colors.dart';
// // import 'package:hotel_booking/features/home/presentation/pages/home_page/carousel_slider.dart';
// // import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/hotel_vertical_view.dart';
// // import 'package:hotel_booking/features/home/presentation/pages/home_page/sort_hotels_by_location.dart';
// // import 'package:hotel_booking/features/home/presentation/pages/serachpage/hotel_serach_page.dart';
// // import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/hotels_list_view.dart';
// // import 'package:hotel_booking/features/home/presentation/pages/home_page/location_notification_bar.dart';
// // import 'package:hotel_booking/features/home/presentation/widgets/section_header.dart';
// // import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
// // import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';

// // class RoomBookingHome extends StatelessWidget {
// //   const RoomBookingHome({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: HotelBookingColors.white,
// //         body: RefreshIndicator(
// //           onRefresh: () async {
// //             context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
// //           },
// //           child: SingleChildScrollView(
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Column(
// //                 children: [
// //                   const LocationWithNotificationBar(),
// //                   const SizedBox(height: 10),

// //                   CarouselWidget(),
// //                   const SizedBox(height: 10),
// //                   SectionHeader(
// //                     title: 'Hotel Near You',
// //                     actionText: 'View All',
// //                     ontap: () {
// //                       Navigator.of(context).push(MaterialPageRoute(
// //                         builder: (context) => const HotelsGridView(),
// //                       ));
// //                     },
// //                   ),

// //                   const SizedBox(
// //                     height: 10,
// //                   ),
// //                   // MyHorizontalListView(),

// //                   const HotelsListView(),
// //                   // TestListView(),

// //                   SectionHeader(
// //                     title: 'Explore By City',
// //                     actionText: 'View All',
// //                     ontap: () {},
// //                   ),
// //                   const SortHotelsByLocation(),
// //                   SectionHeader(
// //                     title: 'Suggested Hotels',
// //                     actionText: 'View All',
// //                     ontap: () {
// //                       Navigator.of(context).push(
// //                         MaterialPageRoute(
// //                           builder: (context) => const HotelsGridView(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                   const SizedBox(
// //                     height: 10,
// //                   ),
// //                   // const HotelsListView(),
// //                   HotelsVerticalListView()
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/home/presentation/pages/serachpage/hotels_gridview.dart';
// import 'package:hotel_booking/features/home/presentation/pages/serachpage/widgets/searchbar.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
// import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_event.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
// import 'package:hotel_booking/features/chatbot/chat_bot.dart';
// import 'package:hotel_booking/features/home/presentation/pages/serachpage/hotel_serach_page.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';
// import 'package:hotel_booking/features/profile/domain/usecase/profile_usecase.dart';
// import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_bloc.dart';
// import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_event.dart';
// import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_page/carousel_slider.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/hotel_vertical_view.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_page/sort_hotels_by_location.dart';
// import 'package:hotel_booking/features/home/presentation/pages/serachpage/hotel_serach_page.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/hotels_list_view.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_page/location_notification_bar.dart';
// import 'package:hotel_booking/features/home/presentation/widgets/section_header.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
// import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
// import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/widgets/hote_shimmer.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
// import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/widgets/hote_shimmer.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
// import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/widgets/hote_shimmer.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
// import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/widgets/hote_shimmer.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';

// /// Core color tokens for the app.
// /// Theme: deep forest green as primary, soft mint as accent,
// /// warm amber reserved exclusively for ratings so it reads as a highlight.
// import 'package:flutter/material.dart';

// /// Core color tokens for the app.
// /// Theme: deep forest green as primary, soft mint as accent,
// /// warm amber reserved exclusively for ratings so it reads as a highlight.
// class NewHotelBookingColors {
//   NewHotelBookingColors._();

//   // Brand / primary — sampled directly from the reference theme image
//   static const Color primary =
//       Color(0xFF00D09E); // vivid spring green (header block)
//   static const Color primaryDark =
//       Color(0xFF00A57E); // pressed / status bar tone
//   static const Color primaryLight = Color(0xFF33DBB2);

//   // Accent
//   static const Color accent =
//       Color(0xFF00B98D); // deeper green for icons/text on light cards
//   static const Color accentLight = Color(0xFFBFF2E1); // pale mint ring/border
//   static const Color accentSoft = Color(0xFFE3FBF1); // soft mint chip fill

//   // Surfaces — F1FFF3 sampled from the image as the card/background mint
//   static const Color background = Color(0xFFF1FFF3);
//   static const Color pagebackgroundcolor = Color(0xFFF1FFF3);
//   static const Color surface = Color(0xFFFFFFFF);
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color divider = Color(0xFFDFF3E9);

//   // Text
//   static const Color textPrimary = Color(0xFF0B2B22);
//   static const Color textSecondary = Color(0xFF5C8577);
//   // Kept for backward compatibility with existing call sites — now maps
//   // into the green system instead of the old neutral tone.
//   static const Color basictextcolor = Color(0xFF00A57E);

//   // Feedback
//   static const Color gold = Color(0xFFD4A94D); // ratings only
//   static const Color error = Color(0xFFD64545);

//   // Shadows (green-tinted instead of flat black, ties surfaces to the palette)
//   static Color shadow({double opacity = 0.08}) => primary.withOpacity(opacity);
// }

// class ProfileSectionColors {
//   ProfileSectionColors._();
//   static const Color primary = NewHotelBookingColors.primary;
// }

// /// A small, consistent type scale so hierarchy stays intentional
// /// instead of ad-hoc TextStyles scattered across widgets.
// class HotelBookingTextStyles {
//   HotelBookingTextStyles._();

//   static const String _fontFamily = 'Inter';

//   static const TextStyle display = TextStyle(
//     fontFamily: _fontFamily,
//     fontSize: 26,
//     fontWeight: FontWeight.w800,
//     letterSpacing: -0.4,
//     color: NewHotelBookingColors.textPrimary,
//     height: 1.15,
//   );

//   static const TextStyle sectionTitle = TextStyle(
//     fontFamily: _fontFamily,
//     fontSize: 19,
//     fontWeight: FontWeight.w700,
//     letterSpacing: -0.2,
//     color: NewHotelBookingColors.textPrimary,
//   );

//   static const TextStyle body = TextStyle(
//     fontFamily: _fontFamily,
//     fontSize: 15,
//     fontWeight: FontWeight.w500,
//     color: NewHotelBookingColors.textPrimary,
//   );

//   static const TextStyle bodyMuted = TextStyle(
//     fontFamily: _fontFamily,
//     fontSize: 14,
//     fontWeight: FontWeight.w500,
//     color: NewHotelBookingColors.textSecondary,
//   );

//   static const TextStyle caption = TextStyle(
//     fontFamily: _fontFamily,
//     fontSize: 12,
//     fontWeight: FontWeight.w600,
//     color: NewHotelBookingColors.textSecondary,
//     letterSpacing: 0.2,
//   );

//   static const TextStyle price = TextStyle(
//     fontFamily: _fontFamily,
//     fontSize: 16,
//     fontWeight: FontWeight.w800,
//     color: NewHotelBookingColors.primary,
//     letterSpacing: -0.2,
//   );
// }

// /// Home page shell. All navigation targets and bloc events are unchanged;
// /// this pass focuses on rhythm — consistent section spacing (24px between
// /// sections instead of a mix of 6/10/12/18), a themed refresh indicator,
// /// and horizontal padding that gives content room to breathe.
// class RoomBookingHome extends StatelessWidget {
//   const RoomBookingHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: NewHotelBookingColors.background,
//         body: RefreshIndicator(
//           color: NewHotelBookingColors.primary,
//           backgroundColor: NewHotelBookingColors.white,
//           onRefresh: () async {
//             context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
//           },
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const LocationWithNotificationBar(),
//                   const SizedBox(height: 8),
//                   CarouselWidget(),
//                   const SizedBox(height: 26),
//                   SectionHeader(
//                     title: 'Hotels Near You',
//                     actionText: 'View All',
//                     ontap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => const HotelsGridView(),
//                       ));
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   const HotelsListView(),
//                   const SizedBox(height: 24),
//                   SectionHeader(
//                     title: 'Explore By City',
//                     actionText: 'View All',
//                     ontap: () {},
//                   ),
//                   const SizedBox(height: 2),
//                   const SortHotelsByLocation(),
//                   const SizedBox(height: 20),
//                   SectionHeader(
//                     title: 'Suggested Hotels',
//                     actionText: 'View All',
//                     ontap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => const HotelsGridView(),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   HotelsVerticalListView(),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Top bar: greeting + name, live location, and quick actions.
// /// All existing bloc wiring, timers and navigation are unchanged —
// /// only layout, spacing and color have been redesigned.
// class LocationWithNotificationBar extends StatelessWidget {
//   const LocationWithNotificationBar({super.key});

//   String get _greeting {
//     final hour = DateTime.now().hour;
//     if (hour < 12) return 'Good morning';
//     if (hour < 17) return 'Good afternoon';
//     return 'Good evening';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final value = UserProfileBloc(
//       sl<FetchUsers>(),
//       sl<UpdateCurrentUser>(),
//       sl<UploadProfileImageUser>(),
//     )..add(LoadUsers());
//     Timer.periodic(const Duration(seconds: 100), (_) {
//       if (context.mounted) {
//         context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
//       }
//     });

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
//       color: NewHotelBookingColors.background,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Profile image, ringed in the accent color so it reads as
//           // the anchor of the row instead of a plain circle avatar.
//           BlocProvider(
//             create: (context) => value,
//             child: BlocBuilder<UserProfileBloc, UserProfileState>(
//               builder: (context, state) {
//                 Widget avatar;
//                 if (state is UserLoading) {
//                   avatar = const CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: NewHotelBookingColors.primary,
//                   );
//                 } else if (state is UserLoaded) {
//                   final imageUrl = state.user.profileImage;
//                   avatar = CircleAvatar(
//                     radius: 24,
//                     backgroundColor: NewHotelBookingColors.accentSoft,
//                     backgroundImage: imageUrl.isNotEmpty
//                         ? NetworkImage(imageUrl) as ImageProvider
//                         : const AssetImage('assets/images/person.png'),
//                   );
//                 } else {
//                   avatar = const CircleAvatar(
//                     radius: 24,
//                     backgroundImage: AssetImage('assets/images/person.png'),
//                   );
//                 }
//                 return Container(
//                   padding: const EdgeInsets.all(2.5),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: NewHotelBookingColors.accentLight,
//                       width: 1.5,
//                     ),
//                   ),
//                   child: avatar,
//                 );
//               },
//             ),
//           ),

//           const SizedBox(width: 14),

//           // Greeting, name and location
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(_greeting, style: HotelBookingTextStyles.caption),
//                 const SizedBox(height: 2),
//                 BlocBuilder<UserProfileBloc, UserProfileState>(
//                   builder: (context, state) {
//                     String name = 'Guest User';
//                     if (state is UserLoaded) {
//                       name = state.user.name;
//                     } else if (state is UserLoading) {
//                       name = 'Loading...';
//                     }
//                     return Text(
//                       name,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: NewHotelBookingColors.textPrimary,
//                         letterSpacing: -0.2,
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on_rounded,
//                         size: 15, color: NewHotelBookingColors.accent),
//                     const SizedBox(width: 3),
//                     Expanded(
//                       child: BlocBuilder<LocationBloc, LocationState>(
//                         builder: (context, state) {
//                           if (state is LocationLoading) {
//                             return const Text(
//                               'Fetching location...',
//                               style: HotelBookingTextStyles.bodyMuted,
//                             );
//                           } else if (state is LocationLoaded) {
//                             return FutureBuilder<String>(
//                               future: _getAddressFromLatLng(state.position),
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return const Text(
//                                     'Fetching address...',
//                                     style: HotelBookingTextStyles.bodyMuted,
//                                   );
//                                 } else if (snapshot.hasData) {
//                                   return Text(
//                                     snapshot.data!,
//                                     style: HotelBookingTextStyles.bodyMuted
//                                         .copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: NewHotelBookingColors.textPrimary,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                   );
//                                 } else {
//                                   return const Text(
//                                     'Unable to fetch address',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: NewHotelBookingColors.error,
//                                     ),
//                                   );
//                                 }
//                               },
//                             );
//                           } else {
//                             return const Text(
//                               'Location unavailable',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: NewHotelBookingColors.error,
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(width: 6),

//           _CircleIconButton(
//             icon: Icons.search_rounded,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => const HotelsGridView(),
//               ));
//             },
//           ),
//           const SizedBox(width: 8),
//           _CircleIconButton(
//             icon: Icons.mark_chat_unread_outlined,
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => const HotelBookingChat(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future<String> _getAddressFromLatLng(LatLng position) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         final Placemark place = placemarks.first;
//         return '${place.locality}';
//       }
//     } catch (e) {
//       return 'Failed to get address: $e';
//     }
//     return 'Unknown Location';
//   }
// }

// /// Shared circular action button used for search / notifications.
// /// Extracted so both icons share identical tap feedback and sizing.
// class _CircleIconButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;

//   const _CircleIconButton({required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: NewHotelBookingColors.accentSoft,
//       shape: const CircleBorder(),
//       child: InkWell(
//         customBorder: const CircleBorder(),
//         splashColor: NewHotelBookingColors.accentLight.withOpacity(0.6),
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Icon(icon, color: NewHotelBookingColors.primary, size: 21),
//         ),
//       ),
//     );
//   }
// }

// /// Promo carousel. Same three images and same underlying package —
// /// redesign adds a soft green shadow (ties it to the palette instead of a
// /// generic black drop shadow) and a live dot indicator so the carousel
// /// reads as an interactive element rather than a static banner.
// class CarouselWidget extends StatefulWidget {
//   CarouselWidget({super.key});

//   final List<String> imageUrls = [
//     'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//     'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//     'https://images.unsplash.com/photo-1529290130-4ca3753253ae?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//   ];

//   @override
//   State<CarouselWidget> createState() => _CarouselWidgetState();
// }

// class _CarouselWidgetState extends State<CarouselWidget> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(18.0),
//             boxShadow: [
//               BoxShadow(
//                 color: NewHotelBookingColors.shadow(opacity: 0.14),
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: CarouselSlider(
//             options: CarouselOptions(
//               height: 175.0,
//               autoPlay: true,
//               enlargeCenterPage: true,
//               aspectRatio: 17 / 9,
//               viewportFraction: 1,
//               onPageChanged: (index, reason) {
//                 setState(() => _currentIndex = index);
//               },
//             ),
//             items: widget.imageUrls.map((imageUrl) {
//               return ClipRRect(
//                 borderRadius: BorderRadius.circular(18.0),
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     Image.network(imageUrl, fit: BoxFit.cover),
//                     // Subtle green wash keeps the banner tied to the
//                     // theme even before any text/CTA is placed on it.
//                     DecoratedBox(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             NewHotelBookingColors.primaryDark.withOpacity(0.0),
//                             NewHotelBookingColors.primaryDark.withOpacity(0.35),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: widget.imageUrls.asMap().entries.map((entry) {
//             final bool isActive = _currentIndex == entry.key;
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               curve: Curves.easeOut,
//               margin: const EdgeInsets.symmetric(horizontal: 3),
//               width: isActive ? 20 : 6,
//               height: 6,
//               decoration: BoxDecoration(
//                 color: isActive
//                     ? NewHotelBookingColors.primary
//                     : NewHotelBookingColors.accentLight,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:hotel_booking/core/constants/colors.dart';

// /// Section header used across the home page. Redesigned to give each
// /// section a clearer visual anchor (a small accent tick) and to turn the
// /// "View All" action into a tappable pill instead of bare text, which
// /// reads more clearly as an interactive control.
// class SectionHeader extends StatelessWidget {
//   final String title;
//   final String actionText;
//   final VoidCallback? ontap;

//   const SectionHeader({
//     super.key,
//     required this.title,
//     required this.actionText,
//     this.ontap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 6, bottom: 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 4,
//                 height: 18,
//                 decoration: BoxDecoration(
//                   color: NewHotelBookingColors.accent,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(title, style: HotelBookingTextStyles.sectionTitle),
//             ],
//           ),
//           Material(
//             color: Colors.transparent,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(20),
//               splashColor: NewHotelBookingColors.accentLight.withOpacity(0.5),
//               onTap: ontap,
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
//                 decoration: BoxDecoration(
//                   color: NewHotelBookingColors.accentSoft,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       actionText,
//                       style: const TextStyle(
//                         color: NewHotelBookingColors.primary,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(width: 2),
//                     const Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 11,
//                       color: NewHotelBookingColors.primary,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HotelsListView extends StatelessWidget {
//   const HotelsListView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
//         child: BlocBuilder<HotelBloc, HotelState>(builder: (context, state) {
//           if (state is HotelLoadingState) {
//             return const HotelCardShimmerSection();
//           } else if (state is HotelLoadedState) {
//             return SizedBox(
//               height: 265,
//               child: Material(
//                 color: NewHotelBookingColors.background,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     itemCount: state.hotels.length,
//                     itemBuilder: (context, index) {
//                       HotelEntity hotel = state.hotels[index];
//                       return _HotelCard(
//                         hotel: hotel,
//                         onTap: () {
//                           context
//                               .read<SelectedHotelBloc>()
//                               .add(SelectHotelEvent(hotel));
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const HotelDetailPage(),
//                             ),
//                           );
//                         },
//                       );
//                     }),
//               ),
//             );
//           } else if (state is HotelErrorState) {
//             return Center(
//               child: Text(
//                 state.message,
//                 style: const TextStyle(color: NewHotelBookingColors.error),
//               ),
//             );
//           }
//           return const Center(
//             child: Text('No hotels found',
//                 style: HotelBookingTextStyles.bodyMuted),
//           );
//         }));
//   }
// }

// /// A single hotel card. Extracted into its own widget so the favorite
// /// toggle can carry local state without complicating the parent list.
// class _HotelCard extends StatefulWidget {
//   final HotelEntity hotel;
//   final VoidCallback onTap;

//   const _HotelCard({required this.hotel, required this.onTap});

//   @override
//   State<_HotelCard> createState() => _HotelCardState();
// }

// class _HotelCardState extends State<_HotelCard> {
//   bool _isFavorite = false;

//   @override
//   Widget build(BuildContext context) {
//     final hotel = widget.hotel;
//     return InkWell(
//       borderRadius: BorderRadius.circular(18),
//       onTap: widget.onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
//         child: Container(
//           width: 220,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(18),
//             boxShadow: [
//               BoxShadow(
//                 color: NewHotelBookingColors.shadow(opacity: 0.12),
//                 blurRadius: 16,
//                 offset: const Offset(0, 8),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(18),
//             child: Stack(
//               children: [
//                 // Background Image
//                 Container(
//                   height: 260,
//                   width: 220,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(hotel.images[0]),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),

//                 // Green-tinted gradient overlay, ties every card back to
//                 // the theme instead of a flat black scrim.
//                 Container(
//                   height: 260,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       stops: const [0.35, 1.0],
//                       colors: [
//                         Colors.transparent,
//                         NewHotelBookingColors.primaryDark.withOpacity(0.82),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Rating chip
//                 Positioned(
//                   top: 14,
//                   left: 14,
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.92),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: const Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.star_rounded,
//                             color: NewHotelBookingColors.gold, size: 15),
//                         SizedBox(width: 3),
//                         Text(
//                           '4.5',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w700,
//                             color: NewHotelBookingColors.textPrimary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Favorite Icon
//                 Positioned(
//                   top: 12,
//                   right: 12,
//                   child: Material(
//                     color: Colors.white.withOpacity(0.92),
//                     shape: const CircleBorder(),
//                     child: InkWell(
//                       customBorder: const CircleBorder(),
//                       onTap: () => setState(() => _isFavorite = !_isFavorite),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8),
//                         child: Icon(
//                           _isFavorite
//                               ? Icons.favorite_rounded
//                               : Icons.favorite_border_rounded,
//                           color: NewHotelBookingColors.error,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Content
//                 Positioned(
//                   bottom: 18,
//                   left: 18,
//                   right: 18,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         hotel.hotelName.toUpperCase(),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 0.1,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           const Icon(Icons.location_on_rounded,
//                               size: 13,
//                               color: NewHotelBookingColors.accentLight),
//                           const SizedBox(width: 3),
//                           Expanded(
//                             child: Text(
//                               '${hotel.city}, ${hotel.state}',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.white70,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Text(
//                             '₹${hotel.propertySetup}',
//                             style: const TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w800,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const Text(
//                             ' / night',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.white70,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class HotelsListView extends StatelessWidget {
// //   const HotelsListView({
// //     super.key,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //         create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
// //         child: BlocBuilder<HotelBloc, HotelState>(builder: (context, state) {
// //           if (state is HotelLoadingState) {
// //             return const HotelCardShimmerSection();
// //           } else if (state is HotelLoadedState) {
// //             return SizedBox(
// //               height: 265,
// //               child: Material(
// //                 color: HotelBookingColors.background,
// //                 child: ListView.builder(
// //                     scrollDirection: Axis.horizontal,
// //                     padding: const EdgeInsets.symmetric(vertical: 4),
// //                     itemCount: state.hotels.length,
// //                     itemBuilder: (context, index) {
// //                       HotelEntity hotel = state.hotels[index];
// //                       return _HotelCard(
// //                         hotel: hotel,
// //                         onTap: () {
// //                           context
// //                               .read<SelectedHotelBloc>()
// //                               .add(SelectHotelEvent(hotel));
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) => const HotelDetailPage(),
// //                             ),
// //                           );
// //                         },
// //                       );
// //                     }),
// //               ),
// //             );
// //           } else if (state is HotelErrorState) {
// //             return Center(
// //               child: Text(
// //                 state.message,
// //                 style: const TextStyle(color: HotelBookingColors.error),
// //               ),
// //             );
// //           }
// //           return const Center(
// //             child: Text('No hotels found', style: HotelBookingTextStyles.bodyMuted),
// //           );
// //         }));
// //   }
// // }

// // /// A single hotel card. Extracted into its own widget so the favorite
// // /// toggle can carry local state without complicating the parent list.
// // class _HotelCard extends StatefulWidget {
// //   final HotelEntity hotel;
// //   final VoidCallback onTap;

// //   const _HotelCard({required this.hotel, required this.onTap});

// //   @override
// //   State<_HotelCard> createState() => _HotelCardState();
// // }

// // class _HotelCardState extends State<_HotelCard> {
// //   bool _isFavorite = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     final hotel = widget.hotel;
// //     return InkWell(
// //       borderRadius: BorderRadius.circular(18),
// //       onTap: widget.onTap,
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
// //         child: Container(
// //           width: 220,
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(18),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: HotelBookingColors.shadow(opacity: 0.12),
// //                 blurRadius: 16,
// //                 offset: const Offset(0, 8),
// //               ),
// //             ],
// //           ),
// //           child: ClipRRect(
// //             borderRadius: BorderRadius.circular(18),
// //             child: Stack(
// //               children: [
// //                 // Background Image
// //                 Container(
// //                   height: 260,
// //                   width: 220,
// //                   decoration: BoxDecoration(
// //                     image: DecorationImage(
// //                       image: NetworkImage(hotel.images[0]),
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                 ),

// //                 // Green-tinted gradient overlay, ties every card back to
// //                 // the theme instead of a flat black scrim.
// //                 Container(
// //                   height: 260,
// //                   decoration: BoxDecoration(
// //                     gradient: LinearGradient(
// //                       begin: Alignment.topCenter,
// //                       end: Alignment.bottomCenter,
// //                       stops: const [0.35, 1.0],
// //                       colors: [
// //                         Colors.transparent,
// //                         HotelBookingColors.primaryDark.withOpacity(0.82),
// //                       ],
// //                     ),
// //                   ),
// //                 ),

// //                 // Rating chip
// //                 Positioned(
// //                   top: 14,
// //                   left: 14,
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(
// //                         horizontal: 8, vertical: 5),
// //                     decoration: BoxDecoration(
// //                       color: Colors.white.withOpacity(0.92),
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     child: const Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Icon(Icons.star_rounded,
// //                             color: HotelBookingColors.gold, size: 15),
// //                         SizedBox(width: 3),
// //                         Text(
// //                           '4.5',
// //                           style: TextStyle(
// //                             fontSize: 12,
// //                             fontWeight: FontWeight.w700,
// //                             color: HotelBookingColors.textPrimary,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),

// //                 // Favorite Icon
// //                 Positioned(
// //                   top: 12,
// //                   right: 12,
// //                   child: Material(
// //                     color: Colors.white.withOpacity(0.92),
// //                     shape: const CircleBorder(),
// //                     child: InkWell(
// //                       customBorder: const CircleBorder(),
// //                       onTap: () => setState(() => _isFavorite = !_isFavorite),
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(8),
// //                         child: Icon(
// //                           _isFavorite
// //                               ? Icons.favorite_rounded
// //                               : Icons.favorite_border_rounded,
// //                           color: HotelBookingColors.error,
// //                           size: 18,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),

// //                 // Content
// //                 Positioned(
// //                   bottom: 18,
// //                   left: 18,
// //                   right: 18,
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         hotel.hotelName.toUpperCase(),
// //                         maxLines: 1,
// //                         overflow: TextOverflow.ellipsis,
// //                         style: const TextStyle(
// //                           fontSize: 17,
// //                           fontWeight: FontWeight.w700,
// //                           letterSpacing: 0.1,
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Row(
// //                         children: [
// //                           const Icon(Icons.location_on_rounded,
// //                               size: 13, color: HotelBookingColors.accentLight),
// //                           const SizedBox(width: 3),
// //                           Expanded(
// //                             child: Text(
// //                               '${hotel.city}, ${hotel.state}',
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                               style: const TextStyle(
// //                                 fontSize: 13,
// //                                 color: Colors.white70,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 10),
// //                       Row(
// //                         children: [
// //                           Text(
// //                             '₹${hotel.propertySetup}',
// //                             style: const TextStyle(
// //                               fontSize: 17,
// //                               fontWeight: FontWeight.w800,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                           const Text(
// //                             ' / night',
// //                             style: TextStyle(
// //                               fontSize: 12,
// //                               color: Colors.white70,
// //                               fontWeight: FontWeight.w500,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class HotelsListView extends StatelessWidget {
// //   const HotelsListView({
// //     super.key,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //         create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
// //         child: BlocBuilder<HotelBloc, HotelState>(builder: (context, state) {
// //           if (state is HotelLoadingState) {
// //             return const HotelCardShimmerSection();
// //           } else if (state is HotelLoadedState) {
// //             return SizedBox(
// //               height: 265,
// //               child: Material(
// //                 color: HotelBookingColors.background,
// //                 child: ListView.builder(
// //                     scrollDirection: Axis.horizontal,
// //                     padding: const EdgeInsets.symmetric(vertical: 4),
// //                     itemCount: state.hotels.length,
// //                     itemBuilder: (context, index) {
// //                       HotelEntity hotel = state.hotels[index];
// //                       return _HotelCard(
// //                         hotel: hotel,
// //                         onTap: () {
// //                           context
// //                               .read<SelectedHotelBloc>()
// //                               .add(SelectHotelEvent(hotel));
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) => const HotelDetailPage(),
// //                             ),
// //                           );
// //                         },
// //                       );
// //                     }),
// //               ),
// //             );
// //           } else if (state is HotelErrorState) {
// //             return Center(
// //               child: Text(
// //                 state.message,
// //                 style: const TextStyle(color: HotelBookingColors.error),
// //               ),
// //             );
// //           }
// //           return const Center(
// //             child: Text('No hotels found', style: HotelBookingTextStyles.bodyMuted),
// //           );
// //         }));
// //   }
// // }

// /// A single hotel card. Extracted into its own widget so the favorite
// /// toggle can carry local state without complicating the parent list.
// // class _HotelCard extends StatefulWidget {
// //   final HotelEntity hotel;
// //   final VoidCallback onTap;

// //   const _HotelCard({required this.hotel, required this.onTap});

// //   @override
// //   State<_HotelCard> createState() => _HotelCardState();
// // }

// // class _HotelCardState extends State<_HotelCard> {
// //   bool _isFavorite = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     final hotel = widget.hotel;
// //     return InkWell(
// //       borderRadius: BorderRadius.circular(18),
// //       onTap: widget.onTap,
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
// //         child: Container(
// //           width: 220,
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(18),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: HotelBookingColors.shadow(opacity: 0.12),
// //                 blurRadius: 16,
// //                 offset: const Offset(0, 8),
// //               ),
// //             ],
// //           ),
// //           child: ClipRRect(
// //             borderRadius: BorderRadius.circular(18),
// //             child: Stack(
// //               children: [
// //                 // Background Image
// //                 Container(
// //                   height: 260,
// //                   width: 220,
// //                   decoration: BoxDecoration(
// //                     image: DecorationImage(
// //                       image: NetworkImage(hotel.images[0]),
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                 ),

// //                 // Green-tinted gradient overlay, ties every card back to
// //                 // the theme instead of a flat black scrim.
// //                 Container(
// //                   height: 260,
// //                   decoration: BoxDecoration(
// //                     gradient: LinearGradient(
// //                       begin: Alignment.topCenter,
// //                       end: Alignment.bottomCenter,
// //                       stops: const [0.35, 1.0],
// //                       colors: [
// //                         Colors.transparent,
// //                         HotelBookingColors.primaryDark.withOpacity(0.82),
// //                       ],
// //                     ),
// //                   ),
// //                 ),

// //                 // Rating chip
// //                 Positioned(
// //                   top: 14,
// //                   left: 14,
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(
// //                         horizontal: 8, vertical: 5),
// //                     decoration: BoxDecoration(
// //                       color: Colors.white.withOpacity(0.92),
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     child: const Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Icon(Icons.star_rounded,
// //                             color: HotelBookingColors.gold, size: 15),
// //                         SizedBox(width: 3),
// //                         Text(
// //                           '4.5',
// //                           style: TextStyle(
// //                             fontSize: 12,
// //                             fontWeight: FontWeight.w700,
// //                             color: HotelBookingColors.textPrimary,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),

// //                 // Favorite Icon
// //                 Positioned(
// //                   top: 12,
// //                   right: 12,
// //                   child: Material(
// //                     color: Colors.white.withOpacity(0.92),
// //                     shape: const CircleBorder(),
// //                     child: InkWell(
// //                       customBorder: const CircleBorder(),
// //                       onTap: () => setState(() => _isFavorite = !_isFavorite),
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(8),
// //                         child: Icon(
// //                           _isFavorite
// //                               ? Icons.favorite_rounded
// //                               : Icons.favorite_border_rounded,
// //                           color: HotelBookingColors.error,
// //                           size: 18,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),

// //                 // Content
// //                 Positioned(
// //                   bottom: 18,
// //                   left: 18,
// //                   right: 18,
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         hotel.hotelName.toUpperCase(),
// //                         maxLines: 1,
// //                         overflow: TextOverflow.ellipsis,
// //                         style: const TextStyle(
// //                           fontSize: 17,
// //                           fontWeight: FontWeight.w700,
// //                           letterSpacing: 0.1,
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Row(
// //                         children: [
// //                           const Icon(Icons.location_on_rounded,
// //                               size: 13, color: HotelBookingColors.accentLight),
// //                           const SizedBox(width: 3),
// //                           Expanded(
// //                             child: Text(
// //                               '${hotel.city}, ${hotel.state}',
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                               style: const TextStyle(
// //                                 fontSize: 13,
// //                                 color: Colors.white70,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 10),
// //                       Row(
// //                         children: [
// //                           Text(
// //                             '₹${hotel.propertySetup}',
// //                             style: const TextStyle(
// //                               fontSize: 17,
// //                               fontWeight: FontWeight.w800,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                           const Text(
// //                             ' / night',
// //                             style: TextStyle(
// //                               fontSize: 12,
// //                               color: Colors.white70,
// //                               fontWeight: FontWeight.w500,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// class HotelsVerticalListView extends StatelessWidget {
//   const HotelsVerticalListView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
//         child: BlocBuilder<HotelBloc, HotelState>(builder: (context, state) {
//           if (state is HotelLoadingState) {
//             return const HotelCardShimmerSection();
//           } else if (state is HotelLoadedState) {
//             return SizedBox(
//               height: 260,
//               child: Material(
//                 color: NewHotelBookingColors.background,
//                 child: ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     itemCount: state.hotels.length,
//                     itemBuilder: (context, index) {
//                       HotelEntity hotel = state.hotels[index];
//                       return InkWell(
//                         borderRadius: BorderRadius.circular(16),
//                         onTap: () {
//                           context
//                               .read<SelectedHotelBloc>()
//                               .add(SelectHotelEvent(hotel));
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const HotelDetailPage(),
//                             ),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 2.0, vertical: 5.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: NewHotelBookingColors.surface,
//                               borderRadius: BorderRadius.circular(16),
//                               border: Border.all(
//                                 color: NewHotelBookingColors.divider,
//                                 width: 1,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: NewHotelBookingColors.shadow(
//                                       opacity: 0.05),
//                                   blurRadius: 12,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 // Hotel Image
//                                 ClipRRect(
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(16),
//                                     bottomLeft: Radius.circular(16),
//                                   ),
//                                   child: Container(
//                                     width: 104,
//                                     height: 92,
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                         image: NetworkImage(hotel.images[0]),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 ),

//                                 // Hotel Content
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 14, vertical: 12),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           hotel.hotelName.toUpperCase(),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: const TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w700,
//                                             letterSpacing: 0.1,
//                                             color: NewHotelBookingColors
//                                                 .textPrimary,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 6),
//                                         Row(
//                                           children: [
//                                             const Icon(
//                                                 Icons.location_on_rounded,
//                                                 size: 14,
//                                                 color: NewHotelBookingColors
//                                                     .accent),
//                                             const SizedBox(width: 4),
//                                             Expanded(
//                                               child: Text(
//                                                 '${hotel.city}, ${hotel.state}',
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: HotelBookingTextStyles
//                                                     .bodyMuted,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 10),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             RichText(
//                                               text: TextSpan(
//                                                 children: [
//                                                   TextSpan(
//                                                     text:
//                                                         '₹${hotel.propertySetup}',
//                                                     style:
//                                                         HotelBookingTextStyles
//                                                             .price,
//                                                   ),
//                                                   const TextSpan(
//                                                     text: ' /night',
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color:
//                                                           NewHotelBookingColors
//                                                               .textSecondary,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 7,
//                                                       vertical: 4),
//                                               decoration: BoxDecoration(
//                                                 color: NewHotelBookingColors
//                                                     .accentSoft,
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                               ),
//                                               child: const Row(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   Icon(Icons.star_rounded,
//                                                       color:
//                                                           NewHotelBookingColors
//                                                               .gold,
//                                                       size: 14),
//                                                   SizedBox(width: 3),
//                                                   Text(
//                                                     '4.5',
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                       color:
//                                                           NewHotelBookingColors
//                                                               .textPrimary,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//             );
//           } else if (state is HotelErrorState) {
//             return Center(
//               child: Text(
//                 state.message,
//                 style: const TextStyle(color: NewHotelBookingColors.error),
//               ),
//             );
//           }
//           return const Center(
//             child: Text('No hotels found',
//                 style: HotelBookingTextStyles.bodyMuted),
//           );
//         }));
//   }
// }

// /// "Explore by City" row. Same data and same underlying timer/bloc
// /// behavior — redesigned so the selected city gets a clear accent ring
// /// and label color change, giving the row a real selected state instead
// /// of looking identical regardless of interaction.
// class SortHotelsByLocation extends StatefulWidget {
//   const SortHotelsByLocation({super.key});

//   @override
//   State<SortHotelsByLocation> createState() => _SortHotelsByLocationState();
// }

// class _SortHotelsByLocationState extends State<SortHotelsByLocation> {
//   int _selectedIndex = 0;

//   final List<Map<String, String>> _locations = const [
//     {'image': 'assets/images/mumbai_hotel.jpg', 'text': 'Mumbai'},
//     {'image': 'assets/images/dehi.jpeg', 'text': 'Delhi'},
//     {'image': 'assets/images/kolkata.jpg', 'text': 'Kolkata'},
//     {'image': 'assets/images/chennai.jpg', 'text': 'Chennai'},
//     {'image': 'assets/images/banglore.jpg', 'text': 'Bangalore'},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(
//       const Duration(seconds: 100),
//       (_) {
//         if (mounted) {
//           context.read<LocationBloc>().add(const FetchCurrentLocationEvent());
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 108,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//         itemCount: _locations.length,
//         itemBuilder: (context, index) {
//           final location = _locations[index];
//           final bool isSelected = _selectedIndex == index;
//           return GestureDetector(
//             onTap: () => setState(() => _selectedIndex = index),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     padding: EdgeInsets.all(isSelected ? 3 : 0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: isSelected
//                             ? NewHotelBookingColors.primary
//                             : Colors.transparent,
//                         width: 2,
//                       ),
//                     ),
//                     child: ClipOval(
//                       child: Image.asset(
//                         location['image']!,
//                         width: 58,
//                         height: 58,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     location['text']!,
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight:
//                           isSelected ? FontWeight.w700 : FontWeight.w500,
//                       color: isSelected
//                           ? NewHotelBookingColors.primary
//                           : NewHotelBookingColors.textSecondary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// /// Search results page. Same bloc wiring and navigation — app bar and
// /// loading/error states restyled to match the green theme instead of
// /// the previous flat basictextcolor bar with default spinner colors.
// class HotelsGridView extends StatelessWidget {
//   const HotelsGridView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
//       child: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Scaffold(
//           backgroundColor: NewHotelBookingColors.background,
//           appBar: AppBar(
//             title: const Text(
//               'Hotels',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 22,
//                 letterSpacing: -0.2,
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: NewHotelBookingColors.primary,
//             elevation: 0,
//             iconTheme: const IconThemeData(color: Colors.white),
//           ),
//           body: Column(
//             children: [
//               HotelSearchBar(),
//               Expanded(
//                 child: BlocBuilder<HotelBloc, HotelState>(
//                   builder: (context, hotelState) {
//                     if (hotelState is HotelLoadingState) {
//                       return const Center(
//                         child: CircularProgressIndicator(
//                           color: NewHotelBookingColors.primary,
//                         ),
//                       );
//                     } else if (hotelState is HotelLoadedState) {
//                       context.read<HotelSearchBloc>().add(SearchHotelsEvent(
//                           query: '', allHotels: hotelState.hotels));

//                       return const HotelSearchResults();
//                     } else if (hotelState is HotelErrorState) {
//                       return Center(
//                         child: Text(
//                           hotelState.message,
//                           style: const TextStyle(
//                               color: NewHotelBookingColors.error),
//                         ),
//                       );
//                     }
//                     return const Center(
//                       child: Text('No hotels found',
//                           style: HotelBookingTextStyles.bodyMuted),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
