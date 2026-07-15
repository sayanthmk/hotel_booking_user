import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, favoritesState) {
                  if (favoritesState is FavoritesLoading) {
                    return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
                    );
                  }

                  if (favoritesState is FavoritesLoaded) {
                    if (favoritesState.favorites.isEmpty) {
                      return _buildEmptyState();
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                      itemCount: favoritesState.favorites.length,
                      itemBuilder: (context, index) {
                        final hotelId = favoritesState.favorites[index];

                        return BlocProvider(
                          create: (context) => HotelBloc(
                            hotelRepository:
                                context.read<HotelBloc>().hotelRepository,
                          )..add(LoadHotelByIdEvent(hotelId)),
                          child: BlocBuilder<HotelBloc, HotelState>(
                            builder: (context, hotelState) {
                              if (hotelState is HotelLoadingState) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 30),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                );
                              }

                              if (hotelState is HotelDetailLoadedState) {
                                return FavoritesCard(
                                  hotel: hotelState.hotel,
                                  hotelId: hotelId,
                                );
                              }

                              if (hotelState is HotelErrorState) {
                                return _buildErrorCard(
                                    context, hotelId, hotelState.message);
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        );
                      },
                    );
                  }

                  if (favoritesState is FavoritesError) {
                    return _buildErrorState(favoritesState.message);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.favorite_rounded, color: Colors.white),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Saved stays', style: AppTextStyles.greeting),
                SizedBox(height: 2),
                Text('Your Favorites', style: AppTextStyles.username),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard(
      BuildContext context, String hotelId, String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.shade100),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Error loading hotel: $message',
              style: AppTextStyles.hotelLocation
                  .copyWith(color: Colors.red.shade700),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline_rounded,
                color: Colors.red.shade700),
            onPressed: () {
              context
                  .read<FavoritesBloc>()
                  .add(RemoveFromFavoritesEvent(hotelId));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 56,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            const Text('No favorite hotels yet',
                style: AppTextStyles.sectionTitle),
            const SizedBox(height: 8),
            Text(
              'Hotels you save will show up here',
              style: AppTextStyles.hotelLocation,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 72, color: Colors.red.shade300),
            const SizedBox(height: 20),
            Text(
              'Error: $message',
              style: AppTextStyles.hotelLocation
                  .copyWith(color: Colors.red.shade600, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
