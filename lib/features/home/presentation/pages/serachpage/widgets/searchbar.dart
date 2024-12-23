import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_event.dart';
import 'package:hotel_booking/features/home/presentation/widgets/customsearchbar.dart';

class HotelSearchBar extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  HotelSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelBloc, HotelState>(
      builder: (context, hotelState) {
        if (hotelState is HotelLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomSearchBar(
              onChanged: (query) {
                context.read<HotelSearchBloc>().add(
                      SearchHotelsEvent(
                        query: query,
                        allHotels: hotelState.hotels,
                      ),
                    );
              },
              width: 340,
              hintText: 'Search',
              controller: searchController,
              borderColor: HotelBookingColors.basictextcolor,
              hintTextColor: HotelBookingColors.basictextcolor,
              textColor: HotelBookingColors.basictextcolor,
              backgroundColor: Colors.white,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
