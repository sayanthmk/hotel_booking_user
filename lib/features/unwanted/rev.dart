// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/review/data/model/review_model.dart';
// import 'package:hotel_booking/features/review/domain/repos/review_repos.dart';
// import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
// import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
// import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';

// class HotelReviewPage extends StatelessWidget {
//   final String hotelId;

//   const HotelReviewPage({
//     Key? key,
//     required this.hotelId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Hotel Reviews',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: HotelBookingColors.basictextcolor,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: BlocProvider(
//         create: (context) => ReviewBloc(
//           context.read<ReviewRepository>(),
//         )..add(GetHotelReviewEvent(hotelId)),
//         child: const ReviewContent(),
//       ),
//       floatingActionButton: const AddReviewButton(),
//     );
//   }
// }

// class ReviewContent extends StatelessWidget {
//   const ReviewContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReviewBloc, ReviewState>(
//       builder: (context, state) {
//         if (state is HotelReviewLoadingState) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         if (state is HotelReviewErrorState) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   state.message,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     color: Colors.red,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<ReviewBloc>().add(
//                           GetHotelReviewEvent(
//                             (context.read<HotelReviewPage>()).hotelId,
//                           ),
//                         );
//                   },
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (state is HotelReviewLoadedState) {
//           if (state.reviews.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No reviews yet.\nBe the first to write a review!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey,
//                 ),
//               ),
//             );
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: state.reviews.length,
//             itemBuilder: (context, index) {
//               return ReviewCard(review: state.reviews[index]);
//             },
//           );
//         }

//         return const SizedBox.shrink();
//       },
//     );
//   }
// }

// class ReviewCard extends StatelessWidget {
//   final ReviewModel review;

//   const ReviewCard({
//     Key? key,
//     required this.review,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 RatingStars(rating: int.tryParse(review.rating ?? '0') ?? 0),
//                 if (review.reviewdate != null)
//                   Text(
//                     _formatDate(review.reviewdate!),
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 12,
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Text(
//               review.reviewcontent ?? 'No review content',
//               style: const TextStyle(
//                 fontSize: 14,
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }

// class RatingStars extends StatelessWidget {
//   final int rating;

//   const RatingStars({
//     Key? key,
//     required this.rating,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List.generate(5, (index) {
//         return Icon(
//           index < rating ? Icons.star : Icons.star_border,
//           color: Colors.amber,
//           size: 20,
//         );
//       }),
//     );
//   }
// }

// class AddReviewButton extends StatelessWidget {
//   const AddReviewButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: () => _showAddReviewDialog(context),
//       child: const Icon(Icons.add),
//     );
//   }

//   void _showAddReviewDialog(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     final reviewController = TextEditingController();
//     double rating = 0;

//     showDialog(
//       context: context,
//       builder: (context) => StatefulBuilder(
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
//                       onPressed: () => setState(() => rating = index + 1),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: reviewController,
//                   maxLines: 3,
//                   decoration: const InputDecoration(
//                     hintText: 'Write your review here...',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Please write your review';
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
//                   final hotelId = (context
//                           .findAncestorWidgetOfExactType<HotelReviewPage>())!
//                       .hotelId;

//                   final review = ReviewModel(
//                     reviewcontent: reviewController.text.trim(),
//                     rating: rating.toString(),
//                     hotelId: hotelId,
//                     reviewdate: DateTime.now(),
//                   );

//                   context
//                       .read<ReviewBloc>()
//                       .add(SaveUserReviewEvent(review, hotelId));
//                   Navigator.pop(context);
//                 } else if (rating == 0) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Please select a rating'),
//                     ),
//                   );
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


// // // review_page.dart
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
// // import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
// // import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
// // import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';

// // class ReviewDisplayPage extends StatelessWidget {
// //   const ReviewDisplayPage({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Hotel Reviews'),
// //         elevation: 0,
// //       ),
// //       body: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
// //         builder: (context, selectedHotelState) {
// //           if (selectedHotelState is! SelectedHotelLoaded) {
// //             return const Center(
// //               child: Text(
// //                 'No hotel selected',
// //                 style: TextStyle(fontSize: 16, color: Colors.grey),
// //               ),
// //             );
// //           }

// //           final hotelId = selectedHotelState.hotel.hotelId;
// //           return BlocProvider(
// //             create: (context) =>
// //                 ReviewBloc(context.read())..add(GetHotelReviewEvent(hotelId)),
// //             child: ReviewContent(),
// //           );
// //         },
// //       ),
// //       floatingActionButton: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
// //         builder: (context, state) {
// //           if (state is SelectedHotelLoaded) {
// //             return FloatingActionButton(
// //               onPressed: () =>
// //                   _showAddReviewDialog(context, state.hotel.hotelId),
// //               child: const Icon(Icons.add),
// //             );
// //           }
// //           return const SizedBox.shrink();
// //         },
// //       ),
// //     );
// //   }

// //   void _showAddReviewDialog(BuildContext context, String hotelId) {
// //     double rating = 0;
// //     final reviewController = TextEditingController();
// //     final formKey = GlobalKey<FormState>();

// //     showDialog(
// //       context: context,
// //       builder: (dialogContext) => StatefulBuilder(
// //         builder: (context, setState) => AlertDialog(
// //           title: const Text('Write a Review'),
// //           content: Form(
// //             key: formKey,
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: List.generate(
// //                     5,
// //                     (index) => IconButton(
// //                       icon: Icon(
// //                         index < rating ? Icons.star : Icons.star_border,
// //                         color: Colors.amber,
// //                       ),
// //                       onPressed: () {
// //                         setState(() {
// //                           rating = index + 1.0;
// //                         });
// //                       },
// //                     ),
// //                   ),
// //                 ),
// //                 TextFormField(
// //                   controller: reviewController,
// //                   maxLines: 3,
// //                   decoration: const InputDecoration(
// //                     hintText: 'Write your review here',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter your review';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.pop(context),
// //               child: const Text('Cancel'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 if (formKey.currentState!.validate() && rating > 0) {
// //                   // context.read<ReviewBloc>().add(
// //                   //       AddReviewEvent(
// //                   //         hotelId: hotelId,
// //                   //         rating: rating.toString(),
// //                   //         reviewContent: reviewController.text,
// //                   //       ),
// //                   //     );
// //                   Navigator.pop(context);
// //                 }
// //               },
// //               child: const Text('Submit'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class ReviewContent extends StatelessWidget {
// //   const ReviewContent({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<ReviewBloc, ReviewState>(
// //       builder: (context, state) {
// //         if (state is UserReviewLoadingState) {
// //           return const Center(child: CircularProgressIndicator());
// //         }

// //         if (state is UserReviewErrorState) {
// //           return Center(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Text(
// //                   state.message,
// //                   textAlign: TextAlign.center,
// //                   style: const TextStyle(color: Colors.red),
// //                 ),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     final hotelId = (context.read<SelectedHotelBloc>().state
// //                             as SelectedHotelLoaded)
// //                         .hotel
// //                         .hotelId;
// //                     context
// //                         .read<ReviewBloc>()
// //                         .add(GetHotelReviewEvent(hotelId));
// //                   },
// //                   child: const Text('Retry'),
// //                 ),
// //               ],
// //             ),
// //           );
// //         }

// //         if (state is! UserReviewLoadedState) {
// //           return const Center(child: Text('No reviews available.'));
// //         }

// //         final reviews = state.userData;
// //         if (reviews.isEmpty) {
// //           return const Center(
// //             child: Text(
// //               'No reviews yet.\nBe the first to add a review!',
// //               textAlign: TextAlign.center,
// //               style: TextStyle(fontSize: 16, color: Colors.grey),
// //             ),
// //           );
// //         }

// //         return ListView.builder(
// //           padding: const EdgeInsets.all(8),
// //           itemCount: reviews.length,
// //           itemBuilder: (context, index) {
// //             final review = reviews[index];
// //             return Card(
// //               margin: const EdgeInsets.symmetric(
// //                 vertical: 4,
// //                 horizontal: 8,
// //               ),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(16),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           'Rating: ${review.rating ?? "N/A"}',
// //                           style: const TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         Row(
// //                           children: List.generate(
// //                             5,
// //                             (starIndex) {
// //                               final rating = int.tryParse(
// //                                     review.rating ?? '0',
// //                                   ) ??
// //                                   0;
// //                               return Icon(
// //                                 starIndex < rating
// //                                     ? Icons.star
// //                                     : Icons.star_border,
// //                                 color: Colors.amber,
// //                               );
// //                             },
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Text(
// //                       review.reviewcontent ?? 'No review content available',
// //                       style: const TextStyle(fontSize: 14),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     if (review.reviewdate != null)
// //                       Text(
// //                         'Date: ${review.reviewdate!.toLocal().toString().split(' ')[0]}',
// //                         style: TextStyle(
// //                           color: Colors.grey.shade600,
// //                           fontSize: 12,
// //                         ),
// //                       ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// // }

