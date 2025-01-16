// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
// import 'package:hotel_booking/features/review/data/model/review_model.dart';
// import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
// import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
// import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';

// class ReviewPage extends StatelessWidget {
//   ReviewPage({super.key});

//   final TextEditingController reviewController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Reviews',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           centerTitle: true,
//           backgroundColor: HotelBookingColors.basictextcolor,
//           elevation: 0,
//           iconTheme: const IconThemeData(color: Colors.white),
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(15),
//             ),
//           ),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.grey[50]!,
//                 Colors.white,
//               ],
//             ),
//           ),
//           child: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
//             builder: (context, hotelState) {
//               if (hotelState is SelectedHotelLoaded) {
//                 final hotelId = hotelState.hotel.hotelId;
//                 return BlocProvider(
//                   create: (context) => ReviewBloc(context.read())
//                     ..add(GetHotelReviewEvent(hotelId)),
//                   child: Stack(
//                     children: [
//                       _ReviewContent(),
//                       Positioned(
//                         bottom: 16,
//                         right: 16,
//                         child: _AddReviewButton(
//                           formKey: formKey,
//                           reviewController: reviewController,
//                           hotelId: hotelId,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//               return const Center(
//                 child: Text(
//                   'Failed to load hotel information.',
//                   style: TextStyle(fontSize: 16, color: Colors.red),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ReviewContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReviewBloc, ReviewState>(
//       builder: (context, state) {
//         if (state is HotelReviewLoadingState) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (state is HotelReviewErrorState) {
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

//         if (state is! HotelReviewLoadedState) {
//           return const Center(child: Text('No reviews available.'));
//         }

//         final reviews = state.reviews;
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
//             return _ReviewCard(review: review);
//           },
//         );
//       },
//     );
//   }
// }

// class _ReviewCard extends StatelessWidget {
//   final ReviewModel review;

//   const _ReviewCard({required this.review});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Rating: ${review.rating ?? "N/A"}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 _StarRating(rating: int.tryParse(review.rating ?? '0') ?? 0),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               review.reviewcontent ?? 'No review content available',
//               style: const TextStyle(fontSize: 14),
//             ),
//             const SizedBox(height: 8),
//             if (review.reviewdate != null)
//               Text(
//                 'Date: ${review.reviewdate!.toLocal().toString().split(' ')[0]}',
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: 12,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _StarRating extends StatelessWidget {
//   final int rating;

//   const _StarRating({required this.rating});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List.generate(
//         5,
//         (index) => Icon(
//           index < rating ? Icons.star : Icons.star_border,
//           color: Colors.amber,
//         ),
//       ),
//     );
//   }
// }

// class _AddReviewButton extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final TextEditingController reviewController;
//   final String hotelId;

//   const _AddReviewButton({
//     required this.formKey,
//     required this.reviewController,
//     required this.hotelId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: () => _showAddReviewDialog(context),
//       child: const Icon(Icons.add),
//     );
//   }

//   void _showAddReviewDialog(BuildContext context) {
//     double rating = 0;

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
//                       onPressed: () => setState(() => rating = index + 1.0),
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
//                   final userData = ReviewModel(
//                     reviewcontent: reviewController.text,
//                     hotelId: hotelId,
//                     rating: rating.toString(),
//                     reviewdate: DateTime.now(),
//                   );
//                   dialogContext.read<ReviewBloc>().add(
//                         SaveUserReviewEvent(userData, hotelId),
//                       );
//                   Navigator.pop(context);
//                   reviewController.clear();
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


// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:hotel_booking/core/constants/colors.dart';
// // import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
// // import 'package:hotel_booking/features/review/data/model/review_model.dart';
// // import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
// // import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
// // import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';

// // class ReviewPage extends StatelessWidget {
// //   ReviewPage({super.key});

// //   final TextEditingController reviewController = TextEditingController();

// //   final formKey = GlobalKey<FormState>();

// //   @override
// //   Widget build(BuildContext context) {
// //     double rating = 0;
// //     return GestureDetector(
// //       onTap: () => FocusScope.of(context).unfocus(),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text(
// //             'Reviews',
// //             style: TextStyle(
// //               color: Colors.white,
// //               fontSize: 24,
// //               fontWeight: FontWeight.w600,
// //             ),
// //           ),
// //           centerTitle: true,
// //           backgroundColor: HotelBookingColors.basictextcolor,
// //           elevation: 0,
// //           iconTheme: const IconThemeData(color: Colors.white),
// //           shape: const RoundedRectangleBorder(
// //             borderRadius: BorderRadius.vertical(
// //               bottom: Radius.circular(15),
// //             ),
// //           ),
// //         ),
// //         body: Container(
// //           decoration: BoxDecoration(
// //             gradient: LinearGradient(
// //               begin: Alignment.topCenter,
// //               end: Alignment.bottomCenter,
// //               colors: [
// //                 Colors.grey[50]!,
// //                 Colors.white,
// //               ],
// //             ),
// //           ),
// //           child: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
// //             builder: (context, hotelState) {
// //               if (hotelState is SelectedHotelLoaded) {
// //                 final hotelId = hotelState.hotel.hotelId;
// //                 BlocProvider(
// //                   create: (context) => ReviewBloc(context.read())
// //                     ..add(GetHotelReviewEvent(hotelId)),
// //                   child: const ReviewContent(),
// //                 );
// //                 return FloatingActionButton(
// //                   // onPressed: () => showAddReviewDialog(context, hotelId),
// //                   onPressed: () {
// //                     showDialog(
// //                       context: context,
// //                       builder: (dialogContext) => StatefulBuilder(
// //                         builder: (context, setState) => AlertDialog(
// //                           title: const Text('Write a Review'),
// //                           content: Form(
// //                             key: formKey,
// //                             child: Column(
// //                               mainAxisSize: MainAxisSize.min,
// //                               children: [
// //                                 Row(
// //                                   mainAxisAlignment: MainAxisAlignment.center,
// //                                   children: List.generate(
// //                                     5,
// //                                     (index) => IconButton(
// //                                       icon: Icon(
// //                                         index < rating
// //                                             ? Icons.star
// //                                             : Icons.star_border,
// //                                         color: Colors.amber,
// //                                       ),
// //                                       onPressed: () {
// //                                         setState(() {
// //                                           rating = index + 1.0;
// //                                         });
// //                                       },
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 TextFormField(
// //                                   controller: reviewController,
// //                                   maxLines: 3,
// //                                   decoration: const InputDecoration(
// //                                     hintText: 'Write your review here',
// //                                     border: OutlineInputBorder(),
// //                                   ),
// //                                   validator: (value) {
// //                                     if (value == null || value.isEmpty) {
// //                                       return 'Please enter your review';
// //                                     }
// //                                     return null;
// //                                   },
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           actions: [
// //                             TextButton(
// //                               onPressed: () => Navigator.pop(context),
// //                               child: const Text('Cancel'),
// //                             ),
// //                             ElevatedButton(
// //                               onPressed: () {
// //                                 if (formKey.currentState!.validate() &&
// //                                     rating > 0) {
// //                                   final userData = ReviewModel(
// //                                     reviewcontent: reviewController.text,
// //                                     hotelId: hotelId,
// //                                     rating: rating.toString(),
// //                                     reviewdate: DateTime.now(),
// //                                   );
// //                                   context.read<ReviewBloc>().add(
// //                                       SaveUserReviewEvent(userData, hotelId));

// //                                   Navigator.pop(context);
// //                                 }
// //                               },
// //                               child: const Text('Submit'),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                   child: const Icon(Icons.add),
// //                 );
// //               }
// //               return const Center(
// //                 child: Text(
// //                   'Failed to load hotel information.',
// //                   style: TextStyle(fontSize: 16, color: Colors.red),
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void clearAllFields() {
// //     reviewController.clear();
// //   }

// //   void showErrorSnackBar(BuildContext context, String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message),
// //         backgroundColor: Colors.red,
// //         behavior: SnackBarBehavior.floating,
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //       ),
// //     );
// //   }

// //   void showSuccessSnackBar(BuildContext context, String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message),
// //         backgroundColor: Colors.green,
// //         behavior: SnackBarBehavior.floating,
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //   //   showDialog(
// //   //     context: context,
// //   //     builder: (dialogContext) => StatefulBuilder(
// //   //       builder: (context, setState) => AlertDialog(
// //   //         title: const Text('Write a Review'),
// //   //         content: Form(
// //   //           key: formKey,
// //   //           child: Column(
// //   //             mainAxisSize: MainAxisSize.min,
// //   //             children: [
// //   //               Row(
// //   //                 mainAxisAlignment: MainAxisAlignment.center,
// //   //                 children: List.generate(
// //   //                   5,
// //   //                   (index) => IconButton(
// //   //                     icon: Icon(
// //   //                       index < rating ? Icons.star : Icons.star_border,
// //   //                       color: Colors.amber,
// //   //                     ),
// //   //                     onPressed: () {
// //   //                       setState(() {
// //   //                         rating = index + 1.0;
// //   //                       });
// //   //                     },
// //   //                   ),
// //   //                 ),
// //   //               ),
// //   //               TextFormField(
// //   //                 controller: reviewController,
// //   //                 maxLines: 3,
// //   //                 decoration: const InputDecoration(
// //   //                   hintText: 'Write your review here',
// //   //                   border: OutlineInputBorder(),
// //   //                 ),
// //   //                 validator: (value) {
// //   //                   if (value == null || value.isEmpty) {
// //   //                     return 'Please enter your review';
// //   //                   }
// //   //                   return null;
// //   //                 },
// //   //               ),
// //   //             ],
// //   //           ),
// //   //         ),
// //   //         actions: [
// //   //           TextButton(
// //   //             onPressed: () => Navigator.pop(context),
// //   //             child: const Text('Cancel'),
// //   //           ),
// //   //           ElevatedButton(
// //   //             onPressed: () {
// //   //               if (formKey.currentState!.validate() && rating > 0) {
// //   //                 // context.read<ReviewBloc>().add(
// //   //                 //       AddReviewEvent(
// //   //                 //         hotelId: hotelId,
// //   //                 //         rating: rating.toString(),
// //   //                 //         reviewContent: reviewController.text,
// //   //                 //       ),
// //   //                 //     );
// //   //                 Navigator.pop(context);
// //   //               }
// //   //             },
// //   //             child: const Text('Submit'),
// //   //           ),
// //   //         ],
// //   //       ),
// //   //     ),
// //   //   );
// //   // }

// //   // void showAddReviewDialog(BuildContext context, String hotelId) {
// //   //   double rating = 0;
// //   //   final reviewController = TextEditingController();
// //   //   final formKey = GlobalKey<FormState>();