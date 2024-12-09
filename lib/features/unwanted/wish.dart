

// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// abstract class FavoritesRepository {
//   Future<void> addHotelToFavorites(String hotelId);
// }
// // lib/features/home/domain/usecases/add_hotel_to_favorites.dart

// class AddHotelToFavorites {
//   final FavoritesRepository repository;

//   AddHotelToFavorites(this.repository);

//   Future<void> call(String hotelId) {
//     return repository.addHotelToFavorites(hotelId);
//   }
// }
// // lib/features/home/data/repositories/favorites_repository_impl.dart
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import '../../domain/repositories/favorites_repository.dart';

// class FavoritesRepositoryImpl implements FavoritesRepository {
//   final FirebaseFirestore firestore;
//   final FirebaseAuth _auth; 

//   FavoritesRepositoryImpl(this.firestore, this._auth); 

//   @override
//   Future<void> addHotelToFavorites(String hotelId) async {
//     try {
//       User? currentUser = _auth.currentUser; 
//       if (currentUser == null) {
//         throw Exception('No authenticated user');
//       }
//       await firestore
//           .collection('users')
//           .doc(currentUser.uid)
//           .collection('favourites')
//           .doc()
//           .set({'hotelId': hotelId, 'addedAt': FieldValue.serverTimestamp()});
//       log('add fav called');
//     } catch (e) {
//       throw Exception('Add to favorites failed: $e');
//     }
//   }
// }

// // lib/features/home/presentation/bloc/favorites/favorites_event.dart
// abstract class FavoritesEvent {}

// class AddHotelToFavoritesEvent extends FavoritesEvent {
//   // final String userId;
//   final String hotelId;

//   AddHotelToFavoritesEvent(this.hotelId);
// }

// // lib/features/home/presentation/bloc/favorites/favorites_state.dart
// abstract class FavoritesState {}

// class FavoritesInitial extends FavoritesState {}

// class FavoritesLoading extends FavoritesState {}

// class FavoritesSuccess extends FavoritesState {
//   final String message;

//   FavoritesSuccess(this.message);
// }

// class FavoritesError extends FavoritesState {
//   final String error;

//   FavoritesError(this.error);
// }
// // lib/features/home/presentation/bloc/favorites/favorites_bloc.dart
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../../../domain/usecases/add_hotel_to_favorites.dart';
// // import 'favorites_event.dart';
// // import 'favorites_state.dart';

// class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
//   final AddHotelToFavorites addHotelToFavorites;

//   FavoritesBloc(this.addHotelToFavorites) : super(FavoritesInitial()) {
//     on<AddHotelToFavoritesEvent>(_onAddHotelToFavorites);
//   }

//   Future<void> _onAddHotelToFavorites(
//       AddHotelToFavoritesEvent event, Emitter<FavoritesState> emit) async {
//     emit(FavoritesLoading());
//     try {
//       await addHotelToFavorites(event.hotelId);
//       emit(FavoritesSuccess('Hotel added to favorites!'));
//     } catch (e) {
//       emit(FavoritesError('Failed to add hotel to favorites: ${e.toString()}'));
//     }
//   }
// }

// // class HotelImageBoxPage extends StatelessWidget {
// //   // final String userId = "currentUserId"; // Replace with actual user ID

// //   const HotelImageBoxPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (_) => FavoritesBloc(
// //         AddHotelToFavorites(
// //           FavoritesRepositoryImpl(FirebaseFirestore.instance),
// //         ),
// //       ),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Hotel Details'),
// //           backgroundColor: Colors.blue,
// //         ),
// //         body: BlocListener<FavoritesBloc, FavoritesState>(
// //           listener: (context, state) {
// //             if (state is FavoritesSuccess) {
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 SnackBar(content: Text(state.message)),
// //               );
// //             } else if (state is FavoritesError) {
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 SnackBar(content: Text(state.error)),
// //               );
// //             }
// //           },
// //           child: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
// //             builder: (context, state) {
// //               if (state is SelectedHotelLoaded) {
// //                 final hotel = state.hotel;

// //                 return Padding(
// //                   padding: const EdgeInsets.all(15.0),
// //                   child: Stack(
// //                     children: [
// //                       // Main Hotel Image
// //                       Container(
// //                         height: 500,
// //                         width: double.infinity,
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(10),
// //                           image: DecorationImage(
// //                             image: NetworkImage(hotel.images[0]),
// //                             fit: BoxFit.cover,
// //                           ),
// //                         ),
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             gradient: LinearGradient(
// //                               colors: [
// //                                 Colors.black.withOpacity(0.6),
// //                                 Colors.transparent,
// //                               ],
// //                               begin: Alignment.bottomCenter,
// //                               end: Alignment.topCenter,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       // Top Left: Interior/Exterior Labels
// //                       Positioned(
// //                         top: 10,
// //                         left: 10,
// //                         child: Container(
// //                           padding: const EdgeInsets.all(8.0),
// //                           decoration: BoxDecoration(
// //                             color: Colors.white.withOpacity(0.7),
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                           child: const Row(
// //                             children: [
// //                               Text(
// //                                 'Interior',
// //                                 style: TextStyle(color: Colors.black),
// //                               ),
// //                               SizedBox(
// //                                 height: 20,
// //                                 child: VerticalDivider(
// //                                   color: Colors.white,
// //                                   thickness: 2,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 'Exterior',
// //                                 style: TextStyle(color: Colors.blue),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                       // Top Right: Action Buttons
// //                       Positioned(
// //                         top: 10,
// //                         right: 10,
// //                         child: Row(
// //                           children: [
// //                             CustomCircleAvatar(
// //                               iconColor: Colors.red,
// //                               onTap: () {
// //                                 context.read<FavoritesBloc>().add(
// //                                       AddHotelToFavoritesEvent(
// //                                         // userId,
// //                                         hotel.hotelId,
// //                                       ),
// //                                     );
// //                               },
// //                               icon: Icons.favorite,
// //                             ),
// //                             const SizedBox(width: 10),
// //                             CustomCircleAvatar(
// //                               iconColor: Colors.black,
// //                               onTap: () {
// //                                 // Share functionality here
// //                               },
// //                               icon: Icons.share,
// //                             ),
// //                             const SizedBox(width: 10),
// //                             CustomCircleAvatar(
// //                               iconColor: Colors.white,
// //                               onTap: () {
// //                                 Navigator.of(context).pop();
// //                               },
// //                               icon: Icons.close,
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       // Bottom Left: Hotel Name and Rating
// //                       Positioned(
// //                         bottom: 20,
// //                         left: 10,
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             SizedBox(
// //                               height: 80,
// //                               width: 200,
// //                               child: Text(
// //                                 hotel.hotelName,
// //                                 textAlign: TextAlign.left,
// //                                 style: const TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 30,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 10),
// //                             Container(
// //                               padding: const EdgeInsets.all(8.0),
// //                               decoration: BoxDecoration(
// //                                 color: Colors.black.withOpacity(0.6),
// //                                 borderRadius: BorderRadius.circular(5),
// //                               ),
// //                               child: const Row(
// //                                 children: [
// //                                   Icon(Icons.star,
// //                                       color: Colors.yellow, size: 16),
// //                                   SizedBox(width: 5),
// //                                   Text(
// //                                     '4.5/5',
// //                                     style: TextStyle(color: Colors.white),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       // Bottom Right: Additional Images and Price
// //                       Positioned(
// //                         bottom: 10,
// //                         right: 10,
// //                         child: Column(
// //                           children: [
// //                             Row(
// //                               children:
// //                                   hotel.images.asMap().entries.map((entry) {
// //                                 int idx = entry.key;
// //                                 String imageUrl = entry.value;

// //                                 if (idx == 0) return const SizedBox.shrink();

// //                                 return Container(
// //                                   height: 45,
// //                                   width: 45,
// //                                   margin: const EdgeInsets.only(left: 5),
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.black.withOpacity(0.6),
// //                                     borderRadius: BorderRadius.circular(5),
// //                                     border: Border.all(
// //                                         width: 2, color: Colors.white),
// //                                     image: DecorationImage(
// //                                       image: NetworkImage(imageUrl),
// //                                       fit: BoxFit.cover,
// //                                     ),
// //                                   ),
// //                                 );
// //                               }).toList(),
// //                             ),
// //                             const SizedBox(height: 5),
// //                             Text(
// //                               '₹${hotel.propertySetup}'.toString(),
// //                               style: const TextStyle(
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.bold,
// //                                 fontSize: 26,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               } else {
// //                 return const Center(
// //                   child: Text('Error loading hotel details.'),
// //                 );
// //               }
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// context.read<FavoritesBloc>().add(LoadFavoritesEvent());