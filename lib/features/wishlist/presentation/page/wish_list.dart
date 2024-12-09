import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/wishlist/presentation/provider/bloc/favorites_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesBloc>().add(LoadFavoritesEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, favoritesState) {
          if (favoritesState is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (favoritesState is FavoritesLoaded) {
            if (favoritesState.favorites.isEmpty) {
              return const Center(
                child: Text(
                  'No favorite hotels yet',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoritesState.favorites.length,
              itemBuilder: (context, index) {
                final hotelId = favoritesState.favorites[index];

                return BlocProvider(
                  create: (context) => HotelBloc(
                    hotelRepository: context.read<HotelBloc>().hotelRepository,
                  )..add(LoadHotelByIdEvent(hotelId)),
                  child: BlocBuilder<HotelBloc, HotelState>(
                    builder: (context, hotelState) {
                      if (hotelState is HotelLoadingState) {
                        // return const Card(
                        //   child: ListTile(
                        //     title: Text('Loading hotel details...'),
                        //   ),
                        // );
                        return const CircularProgressIndicator();
                      }

                      if (hotelState is HotelDetailLoadedState) {
                        final hotel = hotelState.hotel;

                        return InkWell(
                          onTap: () {
                            context
                                .read<SelectedHotelBloc>()
                                .add(SelectHotelEvent(hotel));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HotelDetailPage(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Hotel Details
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Rating
                                      Row(
                                        children: [
                                          const Icon(Icons.star,
                                              color: Colors.amber),
                                          Text(
                                            '${hotel.contactNumber}/5',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),

                                      // Price
                                      Text(
                                        hotel.hotelName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  // Location
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.red),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          hotel.city,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  // Description
                                  Text(
                                    'Description',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    hotel.city,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 16),

                                  // Book Now Button
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<FavoritesBloc>().add(
                                          RemoveFromFavoritesEvent(
                                              hotel.hotelId));
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   const SnackBar(
                                      //       content: Text(
                                      //           'Booking not implemented')),
                                      // );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Remove'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      if (hotelState is HotelErrorState) {
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                                'Error loading hotel: ${hotelState.message}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                context.read<FavoritesBloc>().add(
                                      RemoveFromFavoritesEvent(hotelId),
                                    );
                              },
                            ),
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                );
              },
            );
          }

          if (favoritesState is FavoritesError) {
            return Center(
              child: Text(
                'Error: ${favoritesState.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const Center(child: Text('Initialize favorites'));
        },
      ),
    );
  }
}
  // Triggering the HotelBloc event to load hotel details by ID
                // context.read<HotelBloc>().add(LoadHotelByIdEvent(hotelId));
// class HotelDetailsPage extends StatelessWidget {
//   final String hotelId;

//   const HotelDetailsPage({super.key, required this.hotelId});

//   @override
//   Widget build(BuildContext context) {
//     // Trigger loading hotel details when the page is first built
//     context.read<HotelBloc>().add(LoadHotelByIdEvent(hotelId));

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hotel Details'),
//         centerTitle: true,
//       ),
//       body: BlocBuilder<HotelBloc, HotelState>(
//         builder: (context, state) {
//           // Loading state
//           if (state is HotelLoadingState) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           // Loaded state with hotel details
//           if (state is HotelDetailLoadedState) {
//             final hotel = state.hotel;
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Hotel Image (placeholder)
//                   Container(
//                     height: 250,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Center(child: Text('Hotel Image')),
//                   ),
//                   const SizedBox(height: 16),

//                   // Hotel Name
//                   Text(
//                     hotel.emailAddress,
//                     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   const SizedBox(height: 8),

//                   // Rating and Price
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Rating
//                       Row(
//                         children: [
//                           const Icon(Icons.star, color: Colors.amber),
//                           Text(
//                             '${hotel.contactNumber}/5',
//                             style: Theme.of(context).textTheme.bodyMedium,
//                           ),
//                         ],
//                       ),

//                       // Price
//                       Text(
//                         '\$${hotel.contactNumber} per night',
//                         style:
//                             Theme.of(context).textTheme.titleMedium?.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green,
//                                 ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Location
//                   Row(
//                     children: [
//                       const Icon(Icons.location_on, color: Colors.red),
//                       const SizedBox(width: 8),
//                       Text(
//                         hotel.city,
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Description
//                   Text(
//                     'Description',
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     hotel.city,
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   const SizedBox(height: 16),

//                   // Book Now Button
//                   ElevatedButton(
//                     onPressed: () {
//                       // TODO: Implement booking functionality
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text('Booking not implemented')),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(double.infinity, 50),
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text('Book Now'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           // Error state
//           if (state is HotelErrorState) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     color: Colors.red,
//                     size: 60,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     state.message,
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                           color: Colors.red,
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       context
//                           .read<HotelBloc>()
//                           .add(LoadHotelByIdEvent(hotelId));
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           // Fallback state
//           return const Center(child: Text('Unable to load hotel details'));
//         },
//       ),
//     );
//   }
// }
