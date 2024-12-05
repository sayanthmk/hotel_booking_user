import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/wishlist/presentation/provider/bloc/favorites_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger loading favorites when the page is first opened
    context.read<FavoritesBloc>().add(LoadFavoritesEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return const Center(
                child: Text(
                  'No favorite hotels yet',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final hotelId = state.favorites[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text('Hotel ID: $hotelId'),
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

                // return Dismissible(
                //   key: Key(hotelId),
                //   background: Container(
                //     color: Colors.red,
                //     alignment: Alignment.centerRight,
                //     padding: const EdgeInsets.symmetric(horizontal: 20),
                //     child: const Icon(
                //       Icons.delete,
                //       color: Colors.white,
                //     ),
                //   ),
                //   direction: DismissDirection.endToStart,
                //   onDismissed: (_) {
                //     context.read<FavoritesBloc>().add(
                //           RemoveFromFavoritesEvent(hotelId),
                //         );
                //   },
                //   child: Card(
                //     elevation: 4,
                //     margin: const EdgeInsets.symmetric(vertical: 8),
                //     child: ListTile(
                //       title: Text('Hotel ID: $hotelId'),
                //       trailing: IconButton(
                //         icon: const Icon(Icons.delete, color: Colors.red),
                //         onPressed: () {
                //           context.read<FavoritesBloc>().add(
                //                 RemoveFromFavoritesEvent(hotelId),
                //               );
                //         },
                //       ),
                //     ),
                //   ),
                // );
              },
            );
          }

          if (state is FavoritesError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
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
