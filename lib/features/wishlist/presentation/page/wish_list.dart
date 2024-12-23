import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
import 'package:hotel_booking/features/wishlist/presentation/page/favorites_card.dart';
import 'package:hotel_booking/features/wishlist/presentation/provider/bloc/favorites_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesBloc>().add(LoadFavoritesEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: HotelBookingColors.basictextcolor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(17),
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: const Text(
      //     'Favorites',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       color: Colors.white,
      //       fontSize: 22,
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: HotelBookingColors.basictextcolor,
      //   elevation: 0,
      // ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, favoritesState) {
          if (favoritesState is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }

          if (favoritesState is FavoritesLoaded) {
            if (favoritesState.favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 100,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'No favorite hotels yet',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
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
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        );
                      }

                      if (hotelState is HotelDetailLoadedState) {
                        final hotel = hotelState.hotel;

                        return FavoritesCard(
                          hotel: hotel,
                          hotelId: hotelId,
                        );
                      }

                      if (hotelState is HotelErrorState) {
                        return Card(
                          elevation: 6,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: Colors.red.shade200),
                          ),
                          child: ListTile(
                            title: Text(
                              'Error loading hotel: ${hotelState.message}',
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete,
                                  color: Colors.red.shade700),
                              onPressed: () {
                                // _showRemoveFavoriteDialog(context, hotelId);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 100,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Error: ${favoritesState.message}',
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('Initialize favorites'));
        },
      ),
    );
  }
}

  // Widget _buildHotelCard(BuildContext context, dynamic hotel) {
  //   return GestureDetector(
  //     onTap: () {
  //       context.read<SelectedHotelBloc>().add(SelectHotelEvent(hotel));
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const HotelDetailPage(),
  //         ),
  //       );
  //     },
  //     child: Card(
  //       elevation: 6,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       margin: const EdgeInsets.symmetric(vertical: 10),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(15),
  //           gradient: LinearGradient(
  //             colors: [
  //               Colors.white,
  //               Colors.blue.shade50,
  //             ],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //         ),
  //         padding: const EdgeInsets.all(16),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               height: 150,
  //               width: 220,
  //               decoration: BoxDecoration(
  //                 color: Colors.blueGrey.shade100,
  //               ),
  //               child: hotel.images.isNotEmpty
  //                   ? Image.network(
  //                       hotel.images[0],
  //                       fit: BoxFit.cover,
  //                       errorBuilder: (context, error, stackTrace) {
  //                         return Center(
  //                           child: Icon(
  //                             Icons.error_outline,
  //                             color: Colors.red.shade300,
  //                             size: 32,
  //                           ),
  //                         );
  //                       },
  //                       loadingBuilder: (context, child, loadingProgress) {
  //                         if (loadingProgress == null) return child;
  //                         return Center(
  //                           child: CircularProgressIndicator(
  //                             value: loadingProgress.expectedTotalBytes != null
  //                                 ? loadingProgress.cumulativeBytesLoaded /
  //                                     loadingProgress.expectedTotalBytes!
  //                                 : null,
  //                           ),
  //                         );
  //                       },
  //                     )
  //                   : Center(
  //                       child: Icon(
  //                         Icons.image_not_supported,
  //                         color: Colors.grey.shade400,
  //                         size: 32,
  //                       ),
  //                     ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   hotel.hotelName,
  //                   style: TextStyle(
  //                     fontSize: 22,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.blue.shade800,
  //                   ),
  //                 ),
  //                 Icon(
  //                   Icons.hotel,
  //                   color: Colors.blue.shade600,
  //                   size: 30,
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 16),
  //             _buildDetailRow(
  //               icon: Icons.location_city,
  //               label: 'City',
  //               value: hotel.city,
  //             ),
  //             _buildDetailRow(
  //               icon: Icons.phone,
  //               label: 'Contact',
  //               value: hotel.contactNumber,
  //             ),
  //             _buildDetailRow(
  //               icon: Icons.email,
  //               label: 'Email',
  //               value: hotel.emailAddress,
  //             ),
  //             _buildDetailRow(
  //               icon: Icons.category,
  //               label: 'Hotel Type',
  //               value: hotel.hotelType,
  //             ),
  //             const SizedBox(height: 16),
  //             Center(
  //               child: ElevatedButton.icon(
  //                 onPressed: () {
  //                   _showRemoveFavoriteDialog(context, hotel.hotelId);
  //                 },
  //                 icon: const Icon(Icons.favorite_border),
  //                 label: const Text('Remove from Favorites'),
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.red.shade400,
  //                   foregroundColor: Colors.white,
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 24,
  //                     vertical: 12,
  //                   ),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildDetailRow({
  //   required IconData icon,
  //   required String label,
  //   required String value,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       children: [
  //         Icon(
  //           icon,
  //           color: Colors.blue.shade600,
  //           size: 24,
  //         ),
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 label,
  //                 style: TextStyle(
  //                   color: Colors.grey.shade700,
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //               Text(
  //                 value,
  //                 style: const TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildErrorCard(
  //     BuildContext context, String hotelId, HotelErrorState hotelState) {
  //   return Card(
  //     elevation: 6,
  //     margin: const EdgeInsets.symmetric(vertical: 10),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15),
  //       side: BorderSide(color: Colors.red.shade200),
  //     ),
  //     child: ListTile(
  //       title: Text(
  //         'Error loading hotel: ${hotelState.message}',
  //         style: TextStyle(color: Colors.red.shade700),
  //       ),
  //       trailing: IconButton(
  //         icon: Icon(Icons.delete, color: Colors.red.shade700),
  //         onPressed: () {
  //           _showRemoveFavoriteDialog(context, hotelId);
  //         },
  //       ),
  //     ),
  //   );
  // }

  // void _showRemoveFavoriteDialog(BuildContext context, String hotelId) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Remove from Favorites'),
  //       content: const Text(
  //           'Are you sure you want to remove this hotel from favorites?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: const Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             context
  //                 .read<FavoritesBloc>()
  //                 .add(RemoveFromFavoritesEvent(hotelId));
  //             Navigator.of(context).pop();
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Colors.red,
  //           ),
  //           child: const Text('Remove'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

