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
                                context
                                    .read<FavoritesBloc>()
                                    .add(RemoveFromFavoritesEvent(hotelId));
                                // Navigator.of(context).pop();
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
