// // review_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
// import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
// import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
// import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';

// class ReviewDisplayPage extends StatelessWidget {
//   const ReviewDisplayPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hotel Reviews'),
//         elevation: 0,
//       ),
//       body: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
//         builder: (context, selectedHotelState) {
//           if (selectedHotelState is! SelectedHotelLoaded) {
//             return const Center(
//               child: Text(
//                 'No hotel selected',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             );
//           }

//           final hotelId = selectedHotelState.hotel.hotelId;
//           return BlocProvider(
//             create: (context) =>
//                 ReviewBloc(context.read())..add(GetHotelReviewEvent(hotelId)),
//             child: ReviewContent(),
//           );
//         },
//       ),
//       floatingActionButton: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
//         builder: (context, state) {
//           if (state is SelectedHotelLoaded) {
//             return FloatingActionButton(
//               onPressed: () =>
//                   _showAddReviewDialog(context, state.hotel.hotelId),
//               child: const Icon(Icons.add),
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }

//   void _showAddReviewDialog(BuildContext context, String hotelId) {
//     double rating = 0;
//     final reviewController = TextEditingController();
//     final formKey = GlobalKey<FormState>();

//     showDialog(
//       context: context,
//       builder: (dialogContext) => StatefulBuilder(
//         builder: (context, setState) => AlertDialog(
//           title: const Text('Write a Review'),
//           content: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     5,
//                     (index) => IconButton(
//                       icon: Icon(
//                         index < rating ? Icons.star : Icons.star_border,
//                         color: Colors.amber,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           rating = index + 1.0;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 TextFormField(
//                   controller: reviewController,
//                   maxLines: 3,
//                   decoration: const InputDecoration(
//                     hintText: 'Write your review here',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your review';
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (formKey.currentState!.validate() && rating > 0) {
//                   // context.read<ReviewBloc>().add(
//                   //       AddReviewEvent(
//                   //         hotelId: hotelId,
//                   //         rating: rating.toString(),
//                   //         reviewContent: reviewController.text,
//                   //       ),
//                   //     );
//                   Navigator.pop(context);
//                 }
//               },
//               child: const Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ReviewContent extends StatelessWidget {
//   const ReviewContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReviewBloc, ReviewState>(
//       builder: (context, state) {
//         if (state is UserReviewLoadingState) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (state is UserReviewErrorState) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   state.message,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     final hotelId = (context.read<SelectedHotelBloc>().state
//                             as SelectedHotelLoaded)
//                         .hotel
//                         .hotelId;
//                     context
//                         .read<ReviewBloc>()
//                         .add(GetHotelReviewEvent(hotelId));
//                   },
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (state is! UserReviewLoadedState) {
//           return const Center(child: Text('No reviews available.'));
//         }

//         final reviews = state.userData;
//         if (reviews.isEmpty) {
//           return const Center(
//             child: Text(
//               'No reviews yet.\nBe the first to add a review!',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(8),
//           itemCount: reviews.length,
//           itemBuilder: (context, index) {
//             final review = reviews[index];
//             return Card(
//               margin: const EdgeInsets.symmetric(
//                 vertical: 4,
//                 horizontal: 8,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Rating: ${review.rating ?? "N/A"}',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Row(
//                           children: List.generate(
//                             5,
//                             (starIndex) {
//                               final rating = int.tryParse(
//                                     review.rating ?? '0',
//                                   ) ??
//                                   0;
//                               return Icon(
//                                 starIndex < rating
//                                     ? Icons.star
//                                     : Icons.star_border,
//                                 color: Colors.amber,
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       review.reviewcontent ?? 'No review content available',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(height: 8),
//                     if (review.reviewdate != null)
//                       Text(
//                         'Date: ${review.reviewdate!.toLocal().toString().split(' ')[0]}',
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 12,
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

