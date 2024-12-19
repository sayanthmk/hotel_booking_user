// // hotel_filter_event.dart
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
// import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';

// abstract class HotelFilterEvent extends Equatable {
//   const HotelFilterEvent();

//   @override
//   List<Object> get props => [];
// }

// class UpdateFilterEvent extends HotelFilterEvent {
//   final bool entireProperty;
//   final bool privateProperty;
//   final bool freeCancel;
//   final bool coupleFriendly;
//   final bool parkingFacility;
//   final bool restaurantFacility;

//   const UpdateFilterEvent({
//     this.entireProperty = false,
//     this.privateProperty = false,
//     this.freeCancel = false,
//     this.coupleFriendly = false,
//     this.parkingFacility = false,
//     this.restaurantFacility = false,
//   });

//   @override
//   List<Object> get props => [
//         entireProperty,
//         privateProperty,
//         freeCancel,
//         coupleFriendly,
//         parkingFacility,
//         restaurantFacility
//       ];
// }

// class ResetFilterEvent extends HotelFilterEvent {}

// // hotel_filter_state.dart
// class HotelFilterState {
//   final bool entireProperty;
//   final bool privateProperty;
//   final bool freeCancel;
//   final bool coupleFriendly;
//   final bool parkingFacility;
//   final bool restaurantFacility;

//   const HotelFilterState({
//     this.entireProperty = false,
//     this.privateProperty = false,
//     this.freeCancel = false,
//     this.coupleFriendly = false,
//     this.parkingFacility = false,
//     this.restaurantFacility = false,
//   });

//   HotelFilterState copyWith({
//     bool? entireProperty,
//     bool? privateProperty,
//     bool? freeCancel,
//     bool? coupleFriendly,
//     bool? parkingFacility,
//     bool? restaurantFacility,
//   }) {
//     return HotelFilterState(
//       entireProperty: entireProperty ?? this.entireProperty,
//       privateProperty: privateProperty ?? this.privateProperty,
//       freeCancel: freeCancel ?? this.freeCancel,
//       coupleFriendly: coupleFriendly ?? this.coupleFriendly,
//       parkingFacility: parkingFacility ?? this.parkingFacility,
//       restaurantFacility: restaurantFacility ?? this.restaurantFacility,
//     );
//   }
// }

// // hotel_filter_bloc.dart

// class HotelFilterBloc extends Bloc<HotelFilterEvent, HotelFilterState> {
//   HotelFilterBloc() : super(const HotelFilterState()) {
//     on<UpdateFilterEvent>(_onUpdateFilter);
//     on<ResetFilterEvent>(_onResetFilter);
//   }

//   void _onUpdateFilter(
//       UpdateFilterEvent event, Emitter<HotelFilterState> emit) {
//     emit(state.copyWith(
//       entireProperty: event.entireProperty,
//       privateProperty: event.privateProperty,
//       freeCancel: event.freeCancel,
//       coupleFriendly: event.coupleFriendly,
//       parkingFacility: event.parkingFacility,
//       restaurantFacility: event.restaurantFacility,
//     ));
//   }

//   void _onResetFilter(ResetFilterEvent event, Emitter<HotelFilterState> emit) {
//     emit(const HotelFilterState());
//   }
// }

// // hotel_filter_widget.dart

// class HotelFilterWidget extends StatelessWidget {
//   const HotelFilterWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HotelFilterBloc, HotelFilterState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             _buildFilterChip(
//               context,
//               label: 'Entire Property',
//               value: state.entireProperty,
//               onChanged: (value) =>
//                   _updateFilter(context, entireProperty: value),
//             ),
//             _buildFilterChip(
//               context,
//               label: 'Private Property',
//               value: state.privateProperty,
//               onChanged: (value) =>
//                   _updateFilter(context, privateProperty: value),
//             ),
//             _buildFilterChip(
//               context,
//               label: 'Free Cancellation',
//               value: state.freeCancel,
//               onChanged: (value) => _updateFilter(context, freeCancel: value),
//             ),
//             _buildFilterChip(
//               context,
//               label: 'Couple Friendly',
//               value: state.coupleFriendly,
//               onChanged: (value) =>
//                   _updateFilter(context, coupleFriendly: value),
//             ),
//             _buildFilterChip(
//               context,
//               label: 'Parking Facility',
//               value: state.parkingFacility,
//               onChanged: (value) =>
//                   _updateFilter(context, parkingFacility: value),
//             ),
//             _buildFilterChip(
//               context,
//               label: 'Restaurant Facility',
//               value: state.restaurantFacility,
//               onChanged: (value) =>
//                   _updateFilter(context, restaurantFacility: value),
//             ),
//             ElevatedButton(
//               onPressed: () =>
//                   context.read<HotelFilterBloc>().add(ResetFilterEvent()),
//               child: const Text('Reset Filters'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildFilterChip(
//     BuildContext context, {
//     required String label,
//     required bool value,
//     required Function(bool) onChanged,
//   }) {
//     return FilterChip(
//       label: Text(label),
//       selected: value,
//       onSelected: onChanged,
//       selectedColor: Colors.blue.shade100,
//     );
//   }

//   void _updateFilter(
//     BuildContext context, {
//     bool? entireProperty,
//     bool? privateProperty,
//     bool? freeCancel,
//     bool? coupleFriendly,
//     bool? parkingFacility,
//     bool? restaurantFacility,
//   }) {
//     context.read<HotelFilterBloc>().add(UpdateFilterEvent(
//           entireProperty: entireProperty ?? false,
//           privateProperty: privateProperty ?? false,
//           freeCancel: freeCancel ?? false,
//           coupleFriendly: coupleFriendly ?? false,
//           parkingFacility: parkingFacility ?? false,
//           restaurantFacility: restaurantFacility ?? false,
//         ));
//   }
// }

// // Usage in parent widget

// class FilteredHotelsPage extends StatelessWidget {
//   const FilteredHotelsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
//         ),
//         BlocProvider(
//           create: (context) => HotelFilterBloc(),
//         ),
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Hotels'),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.filter_list),
//               onPressed: () {
//                 _showFilterBottomSheet(context);
//               },
//             ),
//           ],
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Recommended Hotels Section
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 'Recommended Hotels',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Hotels List with Filtering
//             BlocBuilder<HotelBloc, HotelState>(
//               builder: (context, hotelState) {
//                 if (hotelState is HotelLoadingState) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (hotelState is HotelLoadedState) {
//                   return BlocBuilder<HotelFilterBloc, HotelFilterState>(
//                     builder: (context, filterState) {
//                       // Apply Filtering
//                       final filteredHotels =
//                           _applyFilters(hotelState.hotels, filterState);

//                       return Expanded(
//                         child: _buildHotelsList(context, filteredHotels),
//                       );
//                     },
//                   );
//                 } else if (hotelState is HotelErrorState) {
//                   return Center(
//                     child: Text(
//                       hotelState.message,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   );
//                 }
//                 return const Center(child: Text('No hotels found'));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Filter Logic Method
//   List<HotelEntity> _applyFilters(
//       List<HotelEntity> hotels, HotelFilterState filterState) {
//     return hotels.where((hotel) {
//       bool matchesFilter = true;

//       if (filterState.entireProperty) {
//         matchesFilter &= hotel.entireProperty;
//       }
//       if (filterState.privateProperty) {
//         matchesFilter &= hotel.privateProperty;
//       }
//       if (filterState.freeCancel) {
//         matchesFilter &= hotel.freeCancel;
//       }
//       if (filterState.coupleFriendly) {
//         matchesFilter &= hotel.coupleFriendly;
//       }
//       if (filterState.parkingFacility) {
//         matchesFilter &= hotel.parkingFacility;
//       }
//       if (filterState.restaurantFacility) {
//         matchesFilter &= hotel.restaurantFacility;
//       }

//       return matchesFilter;
//     }).toList();
//   }

//   // Build Hotels ListView
//   Widget _buildHotelsList(BuildContext context, List<HotelEntity> hotels) {
//     return ListView.builder(
//       scrollDirection: Axis.vertical,
//       itemCount: hotels.length,
//       itemBuilder: (context, index) {
//         HotelEntity hotel = hotels[index];
//         return _buildHotelCard(context, hotel);
//       },
//     );
//   }

//   // Hotel Card Widget
//   Widget _buildHotelCard(BuildContext context, HotelEntity hotel) {
//     return InkWell(
//       onTap: () {
//         context.read<SelectedHotelBloc>().add(SelectHotelEvent(hotel));
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const HotelDetailPage(),
//           ),
//         );
//       },
//       child: Card(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Hotel Image
//             Container(
//               height: 200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(15)),
//                 image: DecorationImage(
//                   image: NetworkImage(hotel.images[0]),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             // Hotel Details
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Hotel Name and Price
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         hotel.hotelName,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         '₹${hotel.propertySetup}/night',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   // Location
//                   Row(
//                     children: [
//                       Icon(Icons.location_on, color: Colors.red[600], size: 20),
//                       const SizedBox(width: 4),
//                       Text(
//                         '${hotel.city}, ${hotel.country}',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   // Hotel Type and Amenities
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         hotel.hotelType,
//                         style: TextStyle(
//                           color: Colors.grey[700],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       _buildAmenitiesRow(hotel),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Amenities Row
//   Widget _buildAmenitiesRow(HotelEntity hotel) {
//     return Row(
//       children: [
//         if (hotel.parkingFacility)
//           _buildAmenityIcon(Icons.local_parking, 'Parking'),
//         if (hotel.restaurantFacility)
//           _buildAmenityIcon(Icons.restaurant, 'Restaurant'),
//         if (hotel.coupleFriendly)
//           _buildAmenityIcon(Icons.favorite, 'Couple Friendly'),
//       ],
//     );
//   }

//   // Amenity Icon
//   Widget _buildAmenityIcon(IconData icon, String label) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//       child: Tooltip(
//         message: label,
//         child: Icon(icon, color: Colors.grey[600], size: 20),
//       ),
//     );
//   }

//   // Filter Bottom Sheet
//   void _showFilterBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => const HotelFilterWidget(),
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//     );
//   }
// }





















// // // Domain Layer: Use Case
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:get_it/get_it.dart';
// // import 'package:hotel_booking/features/home/data/datasourse/hotel_remote_datasourse.dart';
// // import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

// // // Update the UseCase to be async as well
// // class FilterHotelsUseCase {
// //   final HotelRepository repository;

// //   FilterHotelsUseCase(this.repository);

// //   Future<List<HotelEntity>> call({
// //     bool? entireProperty,
// //     bool? privateProperty,
// //     bool? freeCancel,
// //     bool? coupleFriendly,
// //     bool? parkingFacility,
// //     bool? restaurantFacility,
// //     bool? leased,
// //     bool? registration,
// //     bool? documentImage,
// //   }) async {
// //     return await repository.filterHotels(
// //       entireProperty: entireProperty,
// //       privateProperty: privateProperty,
// //       freeCancel: freeCancel,
// //       coupleFriendly: coupleFriendly,
// //       parkingFacility: parkingFacility,
// //       restaurantFacility: restaurantFacility,
// //       leased: leased,
// //       registration: registration,
// //       documentImage: documentImage,
// //     );
// //   }
// // }

// // // Repository Abstract Class
// // abstract class HotelRepository {
// //   Future<List<HotelEntity>> filterHotels({
// //     bool? entireProperty,
// //     bool? privateProperty,
// //     bool? freeCancel,
// //     bool? coupleFriendly,
// //     bool? parkingFacility,
// //     bool? restaurantFacility,
// //     bool? leased,
// //     bool? registration,
// //     bool? documentImage,
// //   });
// // }

// // // Repository Implementation (Data Layer)
// // class HotelRepositoryImpl implements HotelRepository {
// //   final HotelRemoteDataSource remoteDataSource;

// //   HotelRepositoryImpl(this.remoteDataSource);

// //   @override
// //   Future<List<HotelEntity>> filterHotels({
// //     bool? entireProperty,
// //     bool? privateProperty,
// //     bool? freeCancel,
// //     bool? coupleFriendly,
// //     bool? parkingFacility,
// //     bool? restaurantFacility,
// //     bool? leased,
// //     bool? registration,
// //     bool? documentImage,
// //   }) async {
// //     // Fetch hotels asynchronously
// //     final hotels = await remoteDataSource.fetchHotels();

// //     return hotels.where((hotel) {
// //       return (entireProperty == null ||
// //               hotel.entireProperty == entireProperty) &&
// //           (privateProperty == null ||
// //               hotel.privateProperty == privateProperty) &&
// //           (freeCancel == null || hotel.freeCancel == freeCancel) &&
// //           (coupleFriendly == null || hotel.coupleFriendly == coupleFriendly) &&
// //           (parkingFacility == null ||
// //               hotel.parkingFacility == parkingFacility) &&
// //           (restaurantFacility == null ||
// //               hotel.restaurantFacility == restaurantFacility) &&
// //           (leased == null || hotel.leased == leased) &&
// //           (registration == null || hotel.registration == registration) &&
// //           (documentImage == null || hotel.documentImage == documentImage);
// //     }).toList();
// //   }
// // }

// // // BLoC Events
// // abstract class HotelFilterEvent {}

// // class FilterHotelsEvent extends HotelFilterEvent {
// //   final bool? entireProperty;
// //   final bool? privateProperty;
// //   final bool? freeCancel;
// //   final bool? coupleFriendly;
// //   final bool? parkingFacility;
// //   final bool? restaurantFacility;
// //   final bool? leased;
// //   final bool? registration;
// //   final bool? documentImage;

// //   FilterHotelsEvent({
// //     this.entireProperty,
// //     this.privateProperty,
// //     this.freeCancel,
// //     this.coupleFriendly,
// //     this.parkingFacility,
// //     this.restaurantFacility,
// //     this.leased,
// //     this.registration,
// //     this.documentImage,
// //   });
// // }

// // // BLoC States
// // abstract class HotelFilterState {}

// // class HotelFilterInitialState extends HotelFilterState {}

// // class HotelFilterLoadingState extends HotelFilterState {}

// // class HotelFilterLoadedState extends HotelFilterState {
// //   final List<HotelEntity> filteredHotels;
// //   HotelFilterLoadedState(this.filteredHotels);
// // }

// // class HotelFilterErrorState extends HotelFilterState {
// //   final String errorMessage;
// //   HotelFilterErrorState(this.errorMessage);
// // }

// // // BLoC
// // class HotelFilterBloc extends Bloc<HotelFilterEvent, HotelFilterState> {
// //   final FilterHotelsUseCase filterHotelsUseCase;

// //   HotelFilterBloc(this.filterHotelsUseCase) : super(HotelFilterInitialState()) {
// //     on<FilterHotelsEvent>(_onFilterHotels);
// //   }

// //   // In your BLoC
// //   Future<void> _onFilterHotels(
// //       FilterHotelsEvent event, Emitter<HotelFilterState> emit) async {
// //     emit(HotelFilterLoadingState());

// //     try {
// //       final hotels = await filterHotelsUseCase(
// //         entireProperty: event.entireProperty,
// //         privateProperty: event.privateProperty,
// //         freeCancel: event.freeCancel,
// //         coupleFriendly: event.coupleFriendly,
// //         parkingFacility: event.parkingFacility,
// //         restaurantFacility: event.restaurantFacility,
// //         leased: event.leased,
// //         registration: event.registration,
// //         documentImage: event.documentImage,
// //       );

// //       emit(HotelFilterLoadedState(hotels));
// //     } catch (e) {
// //       emit(HotelFilterErrorState('Failed to filter hotels'));
// //     }
// //   }
// // }

// // // Example Usage in a Widget
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';

// // class HotelFilterButtonsWidget extends StatefulWidget {
// //   const HotelFilterButtonsWidget({super.key});

// //   @override
// //   HotelFilterButtonsWidgetState createState() => HotelFilterButtonsWidgetState();
// // }

// // class HotelFilterButtonsWidgetState extends State<HotelFilterButtonsWidget> {
// //   // Filter states
// //   bool? entireProperty;
// //   bool? privateProperty;
// //   bool? freeCancel;
// //   bool? coupleFriendly;
// //   bool? parkingFacility;
// //   bool? restaurantFacility;
// //   bool? leased;
// //   bool? registration;
// //   bool? documentImage;

// //   // Helper method to create a filter toggle button
// //   Widget _buildFilterToggleButton({
// //     required String label,
// //     required bool? currentValue,
// //     required void Function(bool?) onChanged,
// //   }) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
// //       child: Column(
// //         children: [
// //           Text(label, style: TextStyle(fontSize: 12)),
// //           Row(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Radio<bool>(
// //                 value: true,
// //                 groupValue: currentValue,
// //                 onChanged: onChanged,
// //               ),
// //               const Text('Yes'),
// //               Radio<bool>(
// //                 value: false,
// //                 groupValue: currentValue,
// //                 onChanged: onChanged,
// //               ),
// //               const Text('No'),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // Method to apply filters
// //   void _applyFilters() {
// //     context.read<HotelFilterBloc>().add(
// //       FilterHotelsEvent(
// //         entireProperty: entireProperty,
// //         privateProperty: privateProperty,
// //         freeCancel: freeCancel,
// //         coupleFriendly: coupleFriendly,
// //         parkingFacility: parkingFacility,
// //         restaurantFacility: restaurantFacility,
// //         leased: leased,
// //         registration: registration,
// //         documentImage: documentImage,
// //       ),
// //     );
// //   }

// //   // Method to reset filters
// //   void _resetFilters() {
// //     setState(() {
// //       entireProperty = null;
// //       privateProperty = null;
// //       freeCancel = null;
// //       coupleFriendly = null;
// //       parkingFacility = null;
// //       restaurantFacility = null;
// //       leased = null;
// //       registration = null;
// //       documentImage = null;
// //     });

// //     // Trigger a filter event with all null values (effectively clearing the filter)
// //     context.read<HotelFilterBloc>().add(FilterHotelsEvent());
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         SingleChildScrollView(
// //           scrollDirection: Axis.horizontal,
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceAround,
// //             children: [
// //               _buildFilterToggleButton(
// //                 label: 'Entire Property',
// //                 currentValue: entireProperty,
// //                 onChanged: (value) => setState(() {
// //                   entireProperty = value;
// //                 }),
// //               ),
// //               _buildFilterToggleButton(
// //                 label: 'Private Property',
// //                 currentValue: privateProperty,
// //                 onChanged: (value) => setState(() {
// //                   privateProperty = value;
// //                 }),
// //               ),
// //               _buildFilterToggleButton(
// //                 label: 'Free Cancel',
// //                 currentValue: freeCancel,
// //                 onChanged: (value) => setState(() {
// //                   freeCancel = value;
// //                 }),
// //               ),
// //             ],
// //           ),
// //         ),
// //         SingleChildScrollView(
// //           scrollDirection: Axis.horizontal,
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceAround,
// //             children: [
// //               _buildFilterToggleButton(
// //                 label: 'Couple Friendly',
// //                 currentValue: coupleFriendly,
// //                 onChanged: (value) => setState(() {
// //                   coupleFriendly = value;
// //                 }),
// //               ),
// //               _buildFilterToggleButton(
// //                 label: 'Parking',
// //                 currentValue: parkingFacility,
// //                 onChanged: (value) => setState(() {
// //                   parkingFacility = value;
// //                 }),
// //               ),
// //               _buildFilterToggleButton(
// //                 label: 'Restaurant',
// //                 currentValue: restaurantFacility,
// //                 onChanged: (value) => setState(() {
// //                   restaurantFacility = value;
// //                 }),
// //               ),
// //             ],
// //           ),
// //         ),
// //         SingleChildScrollView(
// //           scrollDirection: Axis.horizontal,
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceAround,
// //             children: [
// //               _buildFilterToggleButton(
// //                 label: 'Leased',
// //                 currentValue: leased,
// //                 onChanged: (value) => setState(() {
// //                   leased = value;
// //                 }),
// //               ),
// //               _buildFilterToggleButton(
// //                 label: 'Registered',
// //                 currentValue: registration,
// //                 onChanged: (value) => setState(() {
// //                   registration = value;
// //                 }),
// //               ),
// //               _buildFilterToggleButton(
// //                 label: 'Document',
// //                 currentValue: documentImage,
// //                 onChanged: (value) => setState(() {
// //                   documentImage = value;
// //                 }),
// //               ),
// //             ],
// //           ),
// //         ),
// //         Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 8.0),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               ElevatedButton(
// //                 onPressed: _applyFilters,
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.blue,
// //                   foregroundColor: Colors.white,
// //                 ),
// //                 child: const Text('Apply Filters'),
// //               ),
// //               const SizedBox(width: 16),
// //               ElevatedButton(
// //                 onPressed: _resetFilters,
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.red,
// //                   foregroundColor: Colors.white,
// //                 ),
// //                 child: const Text('Reset Filters'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // // Example Usage in a Scaffold
// // class HotelFilterScreen extends StatelessWidget {
// //   const HotelFilterScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Hotel Filters'),
// //       ),
// //       body: Column(
// //         children: [
// //           // Filter Buttons
// //           HotelFilterButtonsWidget(),
          
// //           // Filtered Hotels List
// //           Expanded(
// //             child: BlocBuilder<HotelFilterBloc, HotelFilterState>(
// //               builder: (context, state) {
// //                 if (state is HotelFilterLoadingState) {
// //                   return Center(child: CircularProgressIndicator());
// //                 } else if (state is HotelFilterLoadedState) {
// //                   return ListView.builder(
// //                     itemCount: state.filteredHotels.length,
// //                     itemBuilder: (context, index) {
// //                       final hotel = state.filteredHotels[index];
// //                       return ListTile(
// //                         title: Text(hotel.hotelName),
// //                         subtitle: Text('${hotel.city}, ${hotel.country}'),
// //                       );
// //                     },
// //                   );
// //                 } else if (state is HotelFilterErrorState) {
// //                   return Center(child: Text(state.errorMessage));
// //                 }
// //                 return Center(child: Text('No filters applied'));
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }