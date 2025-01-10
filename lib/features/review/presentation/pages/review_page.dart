import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/review/data/model/review_model.dart';
import 'package:hotel_booking/features/review/domain/repos/review_repos.dart';
import 'package:hotel_booking/features/review/presentation/pages/rev.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_event.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_state.dart';
import 'package:provider/provider.dart';

class ReviewContent extends StatelessWidget {
  const ReviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if (state is HotelReviewLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HotelReviewErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                ElevatedButton(
                  onPressed: () {
                    final hotelId = (context.read<SelectedHotelBloc>().state
                            as SelectedHotelLoaded)
                        .hotel
                        .hotelId;
                    context
                        .read<ReviewBloc>()
                        .add(GetHotelReviewEvent(hotelId));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is! HotelReviewLoadedState) {
          return const Center(child: Text('No reviews available.'));
        }

        final reviews = state.userData;
        if (reviews.isEmpty) {
          return const Center(
            child: Text(
              'No reviews yet.\nBe the first to add a review!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rating: ${review.rating ?? "N/A"}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (starIndex) {
                              final rating = int.tryParse(
                                    review.rating ?? '0',
                                  ) ??
                                  0;
                              return Icon(
                                starIndex < rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      review.reviewcontent ?? 'No review content available',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    if (review.reviewdate != null)
                      Text(
                        'Date: ${review.reviewdate!.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ReviewPage extends StatelessWidget {
  ReviewPage({super.key});

  final TextEditingController reviewController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double rating = 0;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reviews',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: HotelBookingColors.basictextcolor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          actions: const [
            // IconButton(
            //     onPressed: () {
            //       Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => HotelReviewDisplaySection(),
            //       ));
            //     },
            //     icon: Icon(Icons.abc))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey[50]!,
                Colors.white,
              ],
            ),
          ),
          child: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
            builder: (context, hotelState) {
              if (hotelState is SelectedHotelLoaded) {
                final hotelId = hotelState.hotel.hotelId;
                // Create a bloc provider for reviews
                return BlocProvider(
                  create: (context) => ReviewBloc(context.read())
                    ..add(GetHotelReviewEvent(hotelId)),
                  child: Stack(
                    children: [
                      const HotelReviewPage(),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: FloatingActionButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (dialogContext) => StatefulBuilder(
                                builder: (context, setState) => AlertDialog(
                                  title: const Text('Write a Review'),
                                  content: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                            5,
                                            (index) => IconButton(
                                              icon: Icon(
                                                index < rating
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: Colors.amber,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  rating = index + 1.0;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: reviewController,
                                          maxLines: 3,
                                          decoration: const InputDecoration(
                                            hintText: 'Write your review here',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your review';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate() &&
                                            rating > 0) {
                                          final userData = ReviewModel(
                                            reviewcontent:
                                                reviewController.text,
                                            hotelId: hotelId,
                                            rating: rating.toString(),
                                            reviewdate: DateTime.now(),
                                          );
                                          dialogContext.read<ReviewBloc>().add(
                                              SaveUserReviewEvent(
                                                  userData, hotelId));
                                          Navigator.pop(context);
                                          // Clear the form
                                          reviewController.clear();
                                          rating = 0;
                                        }
                                      },
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: Text(
                  'Failed to load hotel information.',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class HotelReviewPage extends StatelessWidget {
  const HotelReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Hotel Reviews'),
    //   ),
    //   body:

    return BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
      builder: (context, hotelState) {
        if (hotelState is SelectedHotelLoaded) {
          final hotelId = hotelState.hotel.hotelId;
          // return Provider<ReviewRepository>(
          //   create: (_) => ReviewRepository(),
          //   child:

          return BlocProvider(
            create: (context) => ReviewBloc(
                Provider.of<ReviewRepository>(context, listen: false))
              ..add(GetHotelReviewEvent(hotelId)),
            child: BlocBuilder<ReviewBloc, ReviewState>(
              builder: (context, state) {
                if (state is HotelReviewLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HotelReviewLoadedState) {
                  return ListView.builder(
                    itemCount: state.userData.length,
                    itemBuilder: (context, index) {
                      final review = state.userData[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(review.rating ?? 'No Rating'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(review.reviewcontent ?? 'No Content'),
                              const SizedBox(height: 4),
                              Text(
                                'Reviewed on: ${review.reviewdate?.toString() ?? 'No Date'}',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is HotelReviewErrorState) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No reviews available.'));
                }
              },
            ),
          );
          // );
        } else {
          return const Center(child: Text('Hotel not loaded.'));
        }
      },
    );
  }
}


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
//     double rating = 0;
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
//                 BlocProvider(
//                   create: (context) => ReviewBloc(context.read())
//                     ..add(GetHotelReviewEvent(hotelId)),
//                   child: const ReviewContent(),
//                 );
//                 return FloatingActionButton(
//                   // onPressed: () => showAddReviewDialog(context, hotelId),
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (dialogContext) => StatefulBuilder(
//                         builder: (context, setState) => AlertDialog(
//                           title: const Text('Write a Review'),
//                           content: Form(
//                             key: formKey,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: List.generate(
//                                     5,
//                                     (index) => IconButton(
//                                       icon: Icon(
//                                         index < rating
//                                             ? Icons.star
//                                             : Icons.star_border,
//                                         color: Colors.amber,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           rating = index + 1.0;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 TextFormField(
//                                   controller: reviewController,
//                                   maxLines: 3,
//                                   decoration: const InputDecoration(
//                                     hintText: 'Write your review here',
//                                     border: OutlineInputBorder(),
//                                   ),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter your review';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text('Cancel'),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 if (formKey.currentState!.validate() &&
//                                     rating > 0) {
//                                   final userData = ReviewModel(
//                                     reviewcontent: reviewController.text,
//                                     hotelId: hotelId,
//                                     rating: rating.toString(),
//                                     reviewdate: DateTime.now(),
//                                   );
//                                   context.read<ReviewBloc>().add(
//                                       SaveUserReviewEvent(userData, hotelId));

//                                   Navigator.pop(context);
//                                 }
//                               },
//                               child: const Text('Submit'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   child: const Icon(Icons.add),
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

//   void clearAllFields() {
//     reviewController.clear();
//   }

//   void showErrorSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }

//   void showSuccessSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
// }
//   //   showDialog(
//   //     context: context,
//   //     builder: (dialogContext) => StatefulBuilder(
//   //       builder: (context, setState) => AlertDialog(
//   //         title: const Text('Write a Review'),
//   //         content: Form(
//   //           key: formKey,
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: [
//   //               Row(
//   //                 mainAxisAlignment: MainAxisAlignment.center,
//   //                 children: List.generate(
//   //                   5,
//   //                   (index) => IconButton(
//   //                     icon: Icon(
//   //                       index < rating ? Icons.star : Icons.star_border,
//   //                       color: Colors.amber,
//   //                     ),
//   //                     onPressed: () {
//   //                       setState(() {
//   //                         rating = index + 1.0;
//   //                       });
//   //                     },
//   //                   ),
//   //                 ),
//   //               ),
//   //               TextFormField(
//   //                 controller: reviewController,
//   //                 maxLines: 3,
//   //                 decoration: const InputDecoration(
//   //                   hintText: 'Write your review here',
//   //                   border: OutlineInputBorder(),
//   //                 ),
//   //                 validator: (value) {
//   //                   if (value == null || value.isEmpty) {
//   //                     return 'Please enter your review';
//   //                   }
//   //                   return null;
//   //                 },
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () => Navigator.pop(context),
//   //             child: const Text('Cancel'),
//   //           ),
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               if (formKey.currentState!.validate() && rating > 0) {
//   //                 // context.read<ReviewBloc>().add(
//   //                 //       AddReviewEvent(
//   //                 //         hotelId: hotelId,
//   //                 //         rating: rating.toString(),
//   //                 //         reviewContent: reviewController.text,
//   //                 //       ),
//   //                 //     );
//   //                 Navigator.pop(context);
//   //               }
//   //             },
//   //             child: const Text('Submit'),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   // void showAddReviewDialog(BuildContext context, String hotelId) {
//   //   double rating = 0;
//   //   final reviewController = TextEditingController();
//   //   final formKey = GlobalKey<FormState>();