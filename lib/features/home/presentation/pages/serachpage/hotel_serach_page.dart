import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_booking/features/home/presentation/pages/serachpage/hotels_gridview.dart';
import 'package:hotel_booking/features/home/presentation/pages/serachpage/searchbar.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_event.dart';

class HotelsGridView extends StatelessWidget {
  const HotelsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hotels'),
        ),
        body: Column(
          children: [
            const HotelSearchBar(),
            Expanded(
              child: BlocBuilder<HotelBloc, HotelState>(
                builder: (context, hotelState) {
                  if (hotelState is HotelLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (hotelState is HotelLoadedState) {
                    // Use all hotels without applying filters
                    context.read<HotelSearchBloc>().add(SearchHotelsEvent(
                        query: '', allHotels: hotelState.hotels));

                    return const HotelSearchResults();
                  } else if (hotelState is HotelErrorState) {
                    return Center(
                      child: Text(
                        hotelState.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(child: Text('No hotels found'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
