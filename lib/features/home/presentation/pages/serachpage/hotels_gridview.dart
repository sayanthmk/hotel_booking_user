import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
import 'package:hotel_booking/features/home/presentation/pages/serachpage/searchbar.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_event.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_state.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';

class HotelSearchResults extends StatelessWidget {
  const HotelSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSearchBloc, HotelSearchState>(
      builder: (context, searchState) {
        return BlocBuilder<HotelBloc, HotelState>(
          builder: (context, hotelState) {
            if (hotelState is! HotelLoadedState) {
              return const Center(child: CircularProgressIndicator());
            }

            final hotels = searchState is HotelSearchLoadedState
                ? searchState.filteredHotels
                : hotelState.hotels;

            return Material(
              color: HotelBookingColors.pagebackgroundcolor,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
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
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Stack(
                        children: [
                          Container(
                            width: 500,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(hotel.images[0]),
                              ),
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.2),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotel.hotelName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  hotel.city,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${hotel.propertySetup}/night',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      hotel.city,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}





// abstract class HotelSearchEvent extends Equatable {
//   const HotelSearchEvent();

//   @override
//   List<Object> get props => [];
// }

// class InitializeHotelSearchEvent extends HotelSearchEvent {}

// class SearchHotelsEvent extends HotelSearchEvent {
//   final String query;
//   final List<HotelEntity> allHotels;

//   const SearchHotelsEvent({required this.query, required this.allHotels});

//   @override
//   List<Object> get props => [query, allHotels];
// }

// hotel_search_state.dart
// import 'package:equatable/equatable.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

// abstract class HotelSearchState extends Equatable {
//   const HotelSearchState();

//   @override
//   List<Object> get props => [];
// }

// class HotelSearchInitialState extends HotelSearchState {}

// class HotelSearchLoadingState extends HotelSearchState {}

// class HotelSearchLoadedState extends HotelSearchState {
//   final List<HotelEntity> filteredHotels;

//   const HotelSearchLoadedState({required this.filteredHotels});

//   @override
//   List<Object> get props => [filteredHotels];
// }

// class HotelSearchErrorState extends HotelSearchState {
//   final String message;

//   const HotelSearchErrorState({required this.message});

//   @override
//   List<Object> get props => [message];
// }

// hotel_search_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'hotel_search_event.dart';
// import 'hotel_search_state.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

// class HotelSearchBloc extends Bloc<HotelSearchEvent, HotelSearchState> {
//   HotelSearchBloc() : super(HotelSearchInitialState()) {
//     on<InitializeHotelSearchEvent>(_onInitializeSearch);
//     on<SearchHotelsEvent>(_onSearchHotels);
//   }

//   void _onInitializeSearch(
//       InitializeHotelSearchEvent event, Emitter<HotelSearchState> emit) {
//     emit(HotelSearchInitialState());
//   }

//   void _onSearchHotels(
//       SearchHotelsEvent event, Emitter<HotelSearchState> emit) {
//     emit(HotelSearchLoadingState());

//     try {
//       // Perform case-insensitive search on hotel name and city
//       final filteredHotels = event.allHotels.where((hotel) {
//         final query = event.query.toLowerCase();
//         return hotel.hotelName.toLowerCase().contains(query) ||
//             hotel.city.toLowerCase().contains(query);
//       }).toList();

//       emit(HotelSearchLoadedState(filteredHotels: filteredHotels));
//     } catch (e) {
//       emit(HotelSearchErrorState(
//           message: 'Error searching hotels: ${e.toString()}'));
//     }
//   }
// }

// hotels_grid_view.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
// import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
// import 'hotel_search_bloc.dart';
// import 'hotel_search_event.dart';
// import 'hotel_search_state.dart';
// class HotelsGridView extends StatelessWidget {
//   const HotelsGridView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
//         ),
//         BlocProvider(
//           create: (context) => HotelSearchBloc(),
//         ),

//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Hotels'),
//         ),
//         body: Column(
//           children: [
//             const HotelSearchBar(),
//             Expanded(
//               child: BlocBuilder<HotelBloc, HotelState>(
//                 builder: (context, hotelState) {
//                   if (hotelState is HotelLoadingState) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (hotelState is HotelLoadedState) {
//                     return const HotelSearchResults();
//                   } else if (hotelState is HotelErrorState) {
//                     return Center(
//                       child: Text(
//                         hotelState.message,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     );
//                   }
//                   return const Center(child: Text('No hotels found'));
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// First, update the filter event in filter_bloc
// part of 'filter_bloc.dart';

// abstract class FilterEvent {}

// class ApplyHotelFiltersEvent extends FilterEvent {
//   final bool? hasParking;
//   final bool? hasRestaurant;

//   ApplyHotelFiltersEvent({this.hasParking, this.hasRestaurant});
// }

// // Update the filter state
// // part of 'filter_bloc.dart';

// class FilterState {
//   final bool? hasParking;
//   final bool? hasRestaurant;

//   FilterState({this.hasParking, this.hasRestaurant});

//   FilterState copyWith({bool? hasParking, bool? hasRestaurant}) {
//     return FilterState(
//       hasParking: hasParking ?? this.hasParking,
//       hasRestaurant: hasRestaurant ?? this.hasRestaurant,
//     );
//   }
// }

// // Implement the filter bloc
// // part of 'filter_bloc.dart';

// class FilterBloc extends Bloc<FilterEvent, FilterState> {
//   FilterBloc() : super(FilterState()) {
//     on<ApplyHotelFiltersEvent>(_onApplyHotelFilters);
//   }

//   void _onApplyHotelFilters(
//       ApplyHotelFiltersEvent event, Emitter<FilterState> emit) {
//     emit(state.copyWith(
//         hasParking: event.hasParking, hasRestaurant: event.hasRestaurant));
//   }
// }

// Create a new filter widget
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/filter_bloc/filter_bloc.dart';

// class HotelFilterWidget extends StatelessWidget {
//   const HotelFilterWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FilterBloc, FilterState>(
//       builder: (context, filterState) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             FilterChip(
//               label: const Text('Parking'),
//               selected: filterState.hasParking ?? false,
//               onSelected: (bool value) {
//                 context.read<FilterBloc>().add(
//                       ApplyHotelFiltersEvent(hasParking: value),
//                     );
//               },
//             ),
//             FilterChip(
//               label: const Text('Restaurant'),
//               selected: filterState.hasRestaurant ?? false,
//               onSelected: (bool value) {
//                 context.read<FilterBloc>().add(
//                       ApplyHotelFiltersEvent(hasRestaurant: value),
//                     );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// Update HotelsGridView to include the filter
    // child: TextField(
            //   decoration: InputDecoration(
            //     hintText: 'Search hotels by name or city',
            //     prefixIcon: const Icon(Icons.search),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   onChanged: (query) {
            //     context.read<HotelSearchBloc>().add(
            //           SearchHotelsEvent(
            //             query: query,
            //             allHotels: hotelState.hotels,
            //           ),
            //         );
            //   },
            // ),