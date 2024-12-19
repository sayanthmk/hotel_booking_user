import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/pages/serachpage/hotels_gridview.dart';
import 'package:hotel_booking/features/home/presentation/pages/serachpage/widgets/searchbar.dart';
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
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Hotels',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            centerTitle: true,
            backgroundColor: HotelBookingColors.basictextcolor,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
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
      ),
    );
  }
}
