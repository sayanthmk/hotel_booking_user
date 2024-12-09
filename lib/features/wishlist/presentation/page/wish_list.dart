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
                                  Text(
                                    hotel.contactNumber,
                                  ),
                                  Text(
                                    hotel.hotelName,
                                  ),
                                  Text(
                                    hotel.bookingSince,
                                  ),
                                  Text(
                                    hotel.emailAddress,
                                  ),
                                  Text(
                                    hotel.city,
                                  ),
                                  Text(
                                    hotel.hotelType,
                                  ),
                                  Text(
                                    hotel.panNumber,
                                  ),

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
