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

// class LocationWithNotificationBar extends StatelessWidget {
//   const LocationWithNotificationBar({super.key});

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
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//       decoration: const BoxDecoration(
//           // color: HotelBookingColors.pagebackgroundcolor,
//           color: HotelBookingColors.white),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Profile Image
//           BlocProvider(
//             create: (context) => value,
//             // create: (context) => UserProfileBloc(
//             //   sl<FetchUsers>(),
//             //   sl<UpdateCurrentUser>(),
//             //   sl<UploadProfileImageUser>(),
//             // )..add(LoadUsers()),
//             child: BlocBuilder<UserProfileBloc, UserProfileState>(
//               builder: (context, state) {
//                 if (state is UserLoading) {
//                   return const CircleAvatar(
//                     radius: 25,
//                     child: CircularProgressIndicator(
//                       color: ProfileSectionColors.primary,
//                     ),
//                   );
//                 } else if (state is UserLoaded) {
//                   final imageUrl = state.user.profileImage;
//                   return CircleAvatar(
//                     radius: 25,
//                     backgroundImage: imageUrl.isNotEmpty
//                         ? NetworkImage(imageUrl) as ImageProvider
//                         : const AssetImage('assets/images/person.png'),
//                   );
//                 } else {
//                   return const CircleAvatar(
//                     radius: 20,
//                     backgroundImage: AssetImage('assets/images/person.png'),
//                   );
//                 }
//               },
//             ),
//           ),

//           const SizedBox(width: 15),

//           // Name and Location (with BlocBuilder & FutureBuilder)
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 BlocBuilder<UserProfileBloc, UserProfileState>(
//                   builder: (context, state) {
//                     if (state is UserLoaded) {
//                       return Text(
//                         state.user.name,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black87,
//                         ),
//                       );
//                     } else if (state is UserLoading) {
//                       return const Text(
//                         'Loading...',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black45,
//                         ),
//                       );
//                     } else {
//                       return const Text(
//                         'Guest User',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black54,
//                         ),
//                       );
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 2),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, size: 16, color: Colors.grey),
//                     const SizedBox(width: 4),
//                     BlocBuilder<LocationBloc, LocationState>(
//                       builder: (context, state) {
//                         if (state is LocationLoading) {
//                           return const Text(
//                             'Fetching location...',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: HotelBookingColors.basictextcolor,
//                             ),
//                           );
//                         } else if (state is LocationLoaded) {
//                           return FutureBuilder<String>(
//                             future: _getAddressFromLatLng(state.position),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return const Text(
//                                   'Fetching address...',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: HotelBookingColors.basictextcolor,
//                                   ),
//                                 );
//                               } else if (snapshot.hasData) {
//                                 return Text(
//                                   snapshot.data!,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: HotelBookingColors.basictextcolor,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1,
//                                 );
//                               } else {
//                                 return const Text(
//                                   'Unable to fetch address',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.red,
//                                   ),
//                                 );
//                               }
//                             },
//                           );
//                         } else {
//                           return const Text(
//                             'Location unavailable',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.red,
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Search Icon
//           Container(
//             margin: const EdgeInsets.only(right: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               shape: BoxShape.circle,
//             ),
//             child: IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const HotelsGridView(),
//                 ));
//               },
//               icon: const Icon(Icons.search, color: Colors.black54),
//             ),
//           ),

//           // Notification Icon
//           Container(
//             // margin: const EdgeInsets.only(right: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               shape: BoxShape.circle,
//             ),
//             child: IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const HotelBookingChat(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.mark_chat_unread_outlined,
//                   color: Colors.black54),
//             ),
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
//         // return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
//       }
//     } catch (e) {
//       return 'Failed to get address: $e';
//     }
//     return 'Unknown Location';
//   }
// }


//  // Chat Icon
//           // InkWell(
//           //   onTap: () {
//           //     Navigator.of(context).push(
//           //       MaterialPageRoute(
//           //         builder: (context) => const HotelBookingChat(),
//           //       ),
//           //     );
//           //   },
//           //   child: Container(
//           //     height: 45,
//           //     width: 45,
//           //     decoration: BoxDecoration(
//           //       color: Colors.white,
//           //       borderRadius: BorderRadius.circular(10),
//           //     ),
//           //     child: const Icon(
//           //       FontAwesomeIcons.rocketchat,
//           //       color: HotelBookingColors.basictextcolor,
//           //       size: 20,
//           //     ),
//           //   ),
//           // ),