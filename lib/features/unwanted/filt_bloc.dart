// // lib/features/hotels/domain/entities/hotel_entity.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HotelFilterEntity {
//   final String city;
//   final String hotelName;
//   final String pincode;
//   final bool isCoupleFriendly;
//   final bool hasParkingFacility;
//   final String bookingSince;

//   const HotelFilterEntity({
//     required this.city,
//     required this.hotelName,
//     required this.pincode,
//     required this.isCoupleFriendly,
//     required this.hasParkingFacility,
//     required this.bookingSince,
//   });
// }

// // lib/features/hotels/domain/repositories/hotel_repository.dart
// // import '../entities/hotel_entity.dart';

// abstract class HotelFilterRepository {
//   Future<List<HotelFilterEntity>> getFilteredHotels({
//     List<String>? categories,
//     List<String>? hotelTypes,
//     bool? isCoupleFriendly,
//     bool? hasParkingFacility,
//   });
// }


// // lib/features/hotels/data/datasources/hotel_remote_datasource.dart
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import '../../domain/entities/hotel_entity.dart';

// class HotelRemoteDataSource {
//   final FirebaseFirestore _firestore;

//   HotelRemoteDataSource(this._firestore);

//   Future<List<HotelFilterEntity>> getFilteredHotels({
//     List<String>? categories,
//     List<String>? hotelTypes,
//     bool? isCoupleFriendly,
//     bool? hasParkingFacility,
//   }) async {
//     try {
//       Query query = _firestore.collection('approved_hotels');

//       if (categories != null && categories.isNotEmpty) {
//         query = query.where('city', whereIn: categories);
//       }

//       if (hotelTypes != null && hotelTypes.isNotEmpty) {
//         query = query.where('Booking_since', whereIn: hotelTypes);
//       }

//       if (isCoupleFriendly != null) {
//         query = query.where('couple_friendly', isEqualTo: isCoupleFriendly);
//       }

//       if (hasParkingFacility != null) {
//         query = query.where('parking_facility', isEqualTo: hasParkingFacility);
//       }

//       QuerySnapshot querySnapshot = await query.get();

//       return querySnapshot.docs.map((doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         return HotelFilterEntity(
//           city: data['city'] ?? '',
//           hotelName: data['hotel_name'] ?? '',
//           pincode: data['pincode'] ?? '',
//           isCoupleFriendly: data['couple_friendly'] ?? false,
//           hasParkingFacility: data['parking_facility'] ?? false,
//           bookingSince: data['Booking_since'] ?? '',
//         );
//       }).toList();
//     } catch (e) {
//       throw Exception('Failed to fetch hotels: $e');
//     }
//   }
// }


// // lib/features/hotels/data/repositories/hotel_repository_impl.dart
// // import '../../domain/repositories/hotel_repository.dart';
// // import '../../domain/entities/hotel_entity.dart';
// // import '../datasources/hotel_remote_datasource.dart';

// class HotelFilterRepositoryImpl implements HotelFilterRepository {
//   final HotelRemoteDataSource remoteDataSource;

//   HotelFilterRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<List<HotelFilterEntity>> getFilteredHotels({
//     List<String>? categories,
//     List<String>? hotelTypes,
//     bool? isCoupleFriendly,
//     bool? hasParkingFacility,
//   }) async {
//     return await remoteDataSource.getFilteredHotels(
//       categories: categories,
//       hotelTypes: hotelTypes,
//       isCoupleFriendly: isCoupleFriendly,
//       hasParkingFacility: hasParkingFacility,
//     );
//   }
// }




// // Base Abstract State
// abstract class HotelFilterState extends Equatable {
//   const HotelFilterState();
  
//   @override
//   List<Object?> get props => [];
// }

// // Initial State
// class HotelFilterInitial extends HotelFilterState {}

// // Loading State
// class HotelFilterLoading extends HotelFilterState {
//   final List<String>? currentCategories;
//   final List<String>? currentHotelTypes;
//   final bool? currentCoupleFriendly;
//   final bool? currentParkingFacility;

//   const HotelFilterLoading({
//     this.currentCategories,
//     this.currentHotelTypes,
//     this.currentCoupleFriendly,
//     this.currentParkingFacility,
//   });

//   @override
//   List<Object?> get props => [
//     currentCategories, 
//     currentHotelTypes, 
//     currentCoupleFriendly, 
//     currentParkingFacility
//   ];

//   HotelFilterLoading copyWith({
//     List<String>? currentCategories,
//     List<String>? currentHotelTypes,
//     bool? currentCoupleFriendly,
//     bool? currentParkingFacility,
//   }) {
//     return HotelFilterLoading(
//       currentCategories: currentCategories ?? this.currentCategories,
//       currentHotelTypes: currentHotelTypes ?? this.currentHotelTypes,
//       currentCoupleFriendly: currentCoupleFriendly ?? this.currentCoupleFriendly,
//       currentParkingFacility: currentParkingFacility ?? this.currentParkingFacility,
//     );
//   }
// }

// // Loaded State
// class HotelFilterLoaded extends HotelFilterState {
//   final List<HotelFilterEntity> hotels;
//   final List<String> selectedCategories;
//   final List<String> selectedHotelTypes;
//   final bool isCoupleFriendly;
//   final bool hasParkingFacility;

//   const HotelFilterLoaded({
//     required this.hotels,
//     this.selectedCategories = const [],
//     this.selectedHotelTypes = const [],
//     this.isCoupleFriendly = true,
//     this.hasParkingFacility = true,
//   });

//   @override
//   List<Object?> get props => [
//     hotels, 
//     selectedCategories, 
//     selectedHotelTypes, 
//     isCoupleFriendly, 
//     hasParkingFacility
//   ];

//   HotelFilterLoaded copyWith({
//     List<HotelFilterEntity>? hotels,
//     List<String>? selectedCategories,
//     List<String>? selectedHotelTypes,
//     bool? isCoupleFriendly,
//     bool? hasParkingFacility,
//   }) {
//     return HotelFilterLoaded(
//       hotels: hotels ?? this.hotels,
//       selectedCategories: selectedCategories ?? this.selectedCategories,
//       selectedHotelTypes: selectedHotelTypes ?? this.selectedHotelTypes,
//       isCoupleFriendly: isCoupleFriendly ?? this.isCoupleFriendly,
//       hasParkingFacility: hasParkingFacility ?? this.hasParkingFacility,
//     );
//   }

//   // Convenience methods for filtering
//   HotelFilterLoaded addCategory(String category) {
//     final updatedCategories = List<String>.from(selectedCategories)..add(category);
//     return copyWith(selectedCategories: updatedCategories);
//   }

//   HotelFilterLoaded removeCategory(String category) {
//     final updatedCategories = List<String>.from(selectedCategories)..remove(category);
//     return copyWith(selectedCategories: updatedCategories);
//   }

//   HotelFilterLoaded addHotelType(String hotelType) {
//     final updatedHotelTypes = List<String>.from(selectedHotelTypes)..add(hotelType);
//     return copyWith(selectedHotelTypes: updatedHotelTypes);
//   }

//   HotelFilterLoaded removeHotelType(String hotelType) {
//     final updatedHotelTypes = List<String>.from(selectedHotelTypes)..remove(hotelType);
//     return copyWith(selectedHotelTypes: updatedHotelTypes);
//   }
// }

// // Error State
// class HotelFilterError extends HotelFilterState {
//   final String errorMessage;
//   final List<String>? lastValidCategories;
//   final List<String>? lastValidHotelTypes;
//   final bool? lastValidCoupleFriendly;
//   final bool? lastValidParkingFacility;
//   final List<HotelFilterEntity>? lastValidHotels;

//   const HotelFilterError({
//     required this.errorMessage,
//     this.lastValidCategories,
//     this.lastValidHotelTypes,
//     this.lastValidCoupleFriendly,
//     this.lastValidParkingFacility,
//     this.lastValidHotels,
//   });

//   @override
//   List<Object?> get props => [
//     errorMessage,
//     lastValidCategories,
//     lastValidHotelTypes,
//     lastValidCoupleFriendly,
//     lastValidParkingFacility,
//     lastValidHotels,
//   ];

//   HotelFilterError copyWith({
//     String? errorMessage,
//     List<String>? lastValidCategories,
//     List<String>? lastValidHotelTypes,
//     bool? lastValidCoupleFriendly,
//     bool? lastValidParkingFacility,
//     List<HotelFilterEntity>? lastValidHotels,
//   }) {
//     return HotelFilterError(
//       errorMessage: errorMessage ?? this.errorMessage,
//       lastValidCategories: lastValidCategories ?? this.lastValidCategories,
//       lastValidHotelTypes: lastValidHotelTypes ?? this.lastValidHotelTypes,
//       lastValidCoupleFriendly: lastValidCoupleFriendly ?? this.lastValidCoupleFriendly,
//       lastValidParkingFacility: lastValidParkingFacility ?? this.lastValidParkingFacility,
//       lastValidHotels: lastValidHotels ?? this.lastValidHotels,
//     );
//   }
// }




// // lib/features/hotels/presentation/bloc/hotel_filter_bloc.dart
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:equatable/equatable.dart';

// // import '../../domain/entities/hotel_entity.dart';
// // import '../../domain/repositories/hotel_repository.dart';
// // import '../states/hotel_filter_states.dart';

// // Events
// abstract class HotelFilterEvent extends Equatable {
//   const HotelFilterEvent();

//   @override
//   List<Object?> get props => [];
// }

// // Initial Fetch Event
// class FetchInitialHotelsEvent extends HotelFilterEvent {
//   final List<String>? initialCategories;
//   final List<String>? initialHotelTypes;
//   final bool? initialCoupleFriendly;
//   final bool? initialParkingFacility;

//   const FetchInitialHotelsEvent({
//     this.initialCategories,
//     this.initialHotelTypes,
//     this.initialCoupleFriendly,
//     this.initialParkingFacility,
//   });

//   @override
//   List<Object?> get props => [
//     initialCategories,
//     initialHotelTypes,
//     initialCoupleFriendly,
//     initialParkingFacility,
//   ];
// }

// // Category Filter Events
// class AddCategoryEvent extends HotelFilterEvent {
//   final String category;

//   const AddCategoryEvent(this.category);

//   @override
//   List<Object?> get props => [category];
// }

// class RemoveCategoryEvent extends HotelFilterEvent {
//   final String category;

//   const RemoveCategoryEvent(this.category);

//   @override
//   List<Object?> get props => [category];
// }

// // Hotel Type Filter Events
// class AddHotelTypeEvent extends HotelFilterEvent {
//   final String hotelType;

//   const AddHotelTypeEvent(this.hotelType);

//   @override
//   List<Object?> get props => [hotelType];
// }

// class RemoveHotelTypeEvent extends HotelFilterEvent {
//   final String hotelType;

//   const RemoveHotelTypeEvent(this.hotelType);

//   @override
//   List<Object?> get props => [hotelType];
// }

// // Boolean Filter Events
// class UpdateCoupleFriendlyEvent extends HotelFilterEvent {
//   final bool isCoupleFriendly;

//   const UpdateCoupleFriendlyEvent(this.isCoupleFriendly);

//   @override
//   List<Object?> get props => [isCoupleFriendly];
// }

// class UpdateParkingFacilityEvent extends HotelFilterEvent {
//   final bool hasParkingFacility;

//   const UpdateParkingFacilityEvent(this.hasParkingFacility);

//   @override
//   List<Object?> get props => [hasParkingFacility];
// }

// // Bloc
// class HotelFilterBloc extends Bloc<HotelFilterEvent, HotelFilterState> {
//   final HotelFilterRepository repository;

//   HotelFilterBloc(this.repository) : super(HotelFilterInitial()) {
//     // Register event handlers
//     on<FetchInitialHotelsEvent>(_onFetchInitialHotels);
//     on<AddCategoryEvent>(_onAddCategory);
//     on<RemoveCategoryEvent>(_onRemoveCategory);
//     on<AddHotelTypeEvent>(_onAddHotelType);
//     on<RemoveHotelTypeEvent>(_onRemoveHotelType);
//     on<UpdateCoupleFriendlyEvent>(_onUpdateCoupleFriendly);
//     on<UpdateParkingFacilityEvent>(_onUpdateParkingFacility);
//   }

//   // Fetch Initial Hotels
//   Future<void> _onFetchInitialHotels(
//     FetchInitialHotelsEvent event,
//     Emitter<HotelFilterState> emit,
//   ) async {
//     emit(HotelFilterLoading(
//       currentCategories: event.initialCategories,
//       currentHotelTypes: event.initialHotelTypes,
//       currentCoupleFriendly: event.initialCoupleFriendly,
//       currentParkingFacility: event.initialParkingFacility,
//     ));

//     try {
//       final hotels = await repository.getFilteredHotels(
//         categories: event.initialCategories,
//         hotelTypes: event.initialHotelTypes,
//         isCoupleFriendly: event.initialCoupleFriendly,
//         hasParkingFacility: event.initialParkingFacility,
//       );

//       emit(HotelFilterLoaded(
//         hotels: hotels,
//         selectedCategories: event.initialCategories ?? [],
//         selectedHotelTypes: event.initialHotelTypes ?? [],
//         isCoupleFriendly: event.initialCoupleFriendly ?? true,
//         hasParkingFacility: event.initialParkingFacility ?? true,
//       ));
//     } catch (e) {
//       emit(HotelFilterError(
//         errorMessage: e.toString(),
//       ));
//     }
//   }

//   // Category Filtering
//   Future<void> _onAddCategory(
//     AddCategoryEvent event,
//     Emitter<HotelFilterState> emit,
//   ) async {
//     if (state is! HotelFilterLoaded) return;

//     final currentState = state as HotelFilterLoaded;
//     final updatedCategories = List<String>.from(currentState.selectedCategories)
//       ..add(event.category);

//     emit(HotelFilterLoading(
//       currentCategories: updatedCategories,
//       currentHotelTypes: currentState.selectedHotelTypes,
//       currentCoupleFriendly: currentState.isCoupleFriendly,
//       currentParkingFacility: currentState.hasParkingFacility,
//     ));

//     try {
//       final hotels = await repository.getFilteredHotels(
//         categories: updatedCategories,
//         hotelTypes: currentState.selectedHotelTypes.isNotEmpty 
//           ? currentState.selectedHotelTypes 
//           : null,
//         isCoupleFriendly: currentState.isCoupleFriendly,
//         hasParkingFacility: currentState.hasParkingFacility,
//       );

//       emit(currentState.copyWith(
//         hotels: hotels,
//         selectedCategories: updatedCategories,
//       ));
//     } catch (e) {
//       emit(HotelFilterError(
//         errorMessage: e.toString(),
//         lastValidHotels: currentState.hotels,
//         lastValidCategories: currentState.selectedCategories,
//       ));
//     }
//   }

//   Future<void> _onRemoveCategory(
//     RemoveCategoryEvent event,
//     Emitter<HotelFilterState> emit,
//   ) async {
//     if (state is! HotelFilterLoaded) return;

//     final currentState = state as HotelFilterLoaded;
//     final updatedCategories = List<String>.from(currentState.selectedCategories)
//       ..remove(event.category);

//     emit(HotelFilterLoading(
//       currentCategories: updatedCategories,
//       currentHotelTypes: currentState.selectedHotelTypes,
//       currentCoupleFriendly: currentState.isCoupleFriendly,
//       currentParkingFacility: currentState.hasParkingFacility,
//     ));

//     try {
//       final hotels = await repository.getFilteredHotels(
//         categories: updatedCategories.isNotEmpty ? updatedCategories : null,
//         hotelTypes: currentState.selectedHotelTypes.isNotEmpty 
//           ? currentState.selectedHotelTypes 
//           : null,
//         isCoupleFriendly: currentState.isCoupleFriendly,
//         hasParkingFacility: currentState.hasParkingFacility,
//       );

//       emit(currentState.copyWith(
//         hotels: hotels,
//         selectedCategories: updatedCategories,
//       ));
//     } catch (e) {
//       emit(HotelFilterError(
//         errorMessage: e.toString(),
//         lastValidHotels: currentState.hotels,
//         lastValidCategories: currentState.selectedCategories,
//       ));
//     }
//   }

//   // Hotel Type Filtering (similar to category filtering)
//   Future<void> _onAddHotelType(
//     AddHotelTypeEvent event,
//     Emitter<HotelFilterState> emit,
//   ) async {
//     if (state is! HotelFilterLoaded) return;

//     final currentState = state as HotelFilterLoaded;
//     final updatedHotelTypes = List<String>.from(currentState.selectedHotelTypes)
//       ..add(event.hotelType);

//     emit(HotelFilterLoading(
//       currentCategories: currentState.selectedCategories,
//       currentHotelTypes: updatedHotelTypes,
//       currentCoupleFriendly: currentState.isCoupleFriendly,
//       currentParkingFacility: currentState.hasParkingFacility,
//     ));

//     try {
//       final hotels = await repository.getFilteredHotels(
//         categories: currentState.selectedCategories.isNotEmpty 
//           ? currentState.selectedCategories 
//           : null,
//         hotelTypes: updatedHotelTypes,
//         isCoupleFriendly: currentState.isCoupleFriendly,
//         hasParkingFacility: currentState.hasParkingFacility,
//       );

//       emit(currentState.copyWith(
//         hotels: hotels,
//         selectedHotelTypes: updatedHotelTypes,
//       ));
//     } catch (e) {
//       emit(HotelFilterError(
//         errorMessage: e.toString(),
//         lastValidHotels: currentState.hotels,
//         lastValidHotelTypes: currentState.selectedHotelTypes,
//       ));
//     }
//   }

//   Future<void> _onRemoveHotelType(
//     RemoveHotelTypeEvent event,
//     Emitter<HotelFilterState> emit,
//   ) async {
//     if (state is! HotelFilterLoaded) return;

//     final currentState = state as HotelFilterLoaded;
//     final updatedHotelTypes = List<String>.from(currentState.selectedHotelTypes)
//       ..remove(event.hotelType);

//     emit(HotelFilterLoading(
//       currentCategories: currentState.selectedCategories,
//       currentHotelTypes: updatedHotelTypes,
//       currentCoupleFriendly: currentState.isCoupleFriendly,
//       currentParkingFacility: currentState.hasParkingFacility,
//     ));

//     try {
//       final hotels = await repository.getFilteredHotels(
//         categories: currentState.selectedCategories.isNotEmpty 
//           ? currentState.selectedCategories 
//           : null,
//         hotelTypes: updatedHotelTypes.isNotEmpty ? updatedHotelTypes : null,
//         isCoupleFriendly: currentState.isCoupleFriendly,
//         hasParkingFacility: currentState.hasParkingFacility,
//       );

//       emit(currentState.copyWith(
//         hotels: hotels,
//         selectedHotelTypes: updatedHotelTypes,
//       ));
//     } catch (e) {
//       emit(HotelFilterError(
//         errorMessage: e.toString(),
//         lastValidHotels: currentState.hotels,
//         lastValidHotelTypes: currentState.selectedHotelTypes,
//       ));
//     }
//   }

//   // Boolean Filter Updates
//   Future<void> _onUpdateCoupleFriendly(
//     UpdateCoupleFriendlyEvent event,
//     Emitter<HotelFilterState> emit,
//   ) async {
//     if (state is! HotelFilterLoaded) return;

//     final currentState = state as HotelFilterLoaded;

//     emit(HotelFilterLoading(
//       currentCategories: currentState.selectedCategories,
//       currentHotelTypes: currentState.selectedHotelTypes,
//       currentCoupleFriendly: event.isCoupleFriendly,
//       currentParkingFacility: currentState.hasParkingFacility,
//     ));

//     try {
//       final hotels = await repository.getFilteredHotels(
//         categories: currentState.selectedCategories.isNotEmpty 
//           ? currentState.selectedCategories 
//           : null,
//         hotelTypes: currentState.selectedHotelTypes.isNotEmpty 
//           ? currentState.selectedHotelTypes 
//           : null,
//         isCoupleFriendly: event.isCoupleFriendly,
//         hasParkingFacility: currentState.hasParkingFacility,
//       );

//       emit(currentState.copyWith(
//         hotels: hotels,
//         isCoupleFriendly: event.isCoupleFriendly,
//       ));
//     } catch (e) {
//       emit(HotelFilterError(
//         errorMessage: e.toString(),
//         lastValidHotels: currentState.hotels,
//         lastValidCoupleFriendly: currentState.isCoupleFriendly,
//       ));
//     }
//   }

//   Future<void> _onUpdateParkingFacility(
//     UpdateParkingFacilityEvent event,
//     Emitter<HotelFilterState> emit,
//   ) async {
//     if (state is! HotelFilterLoaded) return;

//     final currentState = state as HotelFilterLoaded;

//     emit(HotelFilterLoading(
//       currentCategories: currentState.selectedCategories,
//       currentHotelTypes: currentState.selectedHotelTypes,
//       currentCoupleFriendly: currentState.isCoupleFriendly,
//       currentParkingFacility: event.hasParkingFacility,
//     ));

//     try {
//       final hotels = await repository.getFilteredHotels(
//         categories: currentState.selectedCategories.isNotEmpty 
//           ? currentState.selectedCategories 
//           : null,
//         hotelTypes: currentState.selectedHotelTypes.isNotEmpty 
//           ? currentState.selectedHotelTypes 
//           : null,
//         isCoupleFriendly: currentState.isCoupleFriendly,
//         hasParkingFacility: event.hasParkingFacility,
//       );

//       emit(currentState.copyWith(
//         hotels: hotels,
//         hasParkingFacility: event.hasParkingFacility,
//       ));
//     } catch (e) {
//       emit(HotelFilterError(
//         errorMessage: e.toString(),
//         lastValidHotels: currentState.hotels,
//         lastValidParkingFacility: currentState.hasParkingFacility,
//       ));
//     }
//   }
// }


// class HotelFilterPage extends StatelessWidget {
//   final List<String> categories = ["chennai", "Fashion", "Books", "Home"];
//   final List<String> hotelTypes = ["2014", "2016", "Hotel", "Villa"];

//    HotelFilterPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Multi-Filter Hotels"),
//       ),
//       body: Column(
//         children: [
//           _buildFilterSection(context),
//           const Divider(),
//           _buildHotelList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterSection(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 10),
//         _buildCategoryFilters(context),
//         _buildHotelTypeFilters(context),
//         _buildBooleanFilters(context),
//       ],
//     );
//   }

//   Widget _buildCategoryFilters(BuildContext context) {
//     return Column(
//       children: [
//         const Text(
//           "Select Categories:", 
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
//         ),
//         _buildFilterChips(
//           context, 
//           items: categories, 
//           filterType: FilterType.category
//         ),
//       ],
//     );
//   }

//   Widget _buildHotelTypeFilters(BuildContext context) {
//     return Column(
//       children: [
//         const Text(
//           "Select Hotel Types:", 
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
//         ),
//         _buildFilterChips(
//           context, 
//           items: hotelTypes, 
//           filterType: FilterType.hotelType
//         ),
//       ],
//     );
//   }

//   Widget _buildFilterChips(
//     BuildContext context, {
//     required List<String> items, 
//     required FilterType filterType
//   }) {
//     return BlocBuilder<HotelFilterBloc, HotelFilterState>(
//       builder: (context, state) {
//         final selectedItems = _getSelectedItems(state, filterType);
        
//         return Wrap(
//           spacing: 10,
//           children: items.map((item) {
//             return FilterChip(
//               label: Text(item),
//               selected: selectedItems.contains(item),
//               onSelected: (isSelected) {
//                 _updateFilter(context, item, isSelected, filterType);
//               },
//             );
//           }).toList(),
//         );
//       },
//     );
//   }

//   List<String> _getSelectedItems(HotelFilterState state, FilterType filterType) {
//     if (state is HotelFilterLoaded) {
//       switch (filterType) {
//         case FilterType.category:
//           return state.selectedCategories;
//         case FilterType.hotelType:
//           return state.selectedHotelTypes;
//       }
//     }
//     return [];
//   }

//   void _updateFilter(
//     BuildContext context, 
//     String item, 
//     bool isSelected, 
//     FilterType filterType
//   ) {
//     context.read<HotelFilterBloc>().add(
//       UpdateFilterEvent(
//         item: item, 
//         isSelected: isSelected, 
//         filterType: filterType
//       )
//     );
//   }

//   Widget _buildBooleanFilters(BuildContext context) {
//     return BlocBuilder<HotelFilterBloc, HotelFilterState>(
//       builder: (context, state) {
//         final loadedState = state is HotelFilterLoaded ? state : null;
        
//         return Column(
//           children: [
//             _buildBooleanSwitch(
//               context,
//               text: 'Couple Friendly',
//               value: loadedState?.isCoupleFriendly ?? true,
//               onChanged: (value) {
//                 context.read<HotelFilterBloc>().add(
//                   UpdateBooleanFilterEvent(
//                     filterType: BooleanFilterType.coupleFriendly,
//                     value: value
//                   )
//                 );
//               },
//             ),
//             _buildBooleanSwitch(
//               context,
//               text: 'Parking Facility',
//               value: loadedState?.hasParkingFacility ?? true,
//               onChanged: (value) {
//                 context.read<HotelFilterBloc>().add(
//                   UpdateBooleanFilterEvent(
//                     filterType: BooleanFilterType.parkingFacility,
//                     value: value
//                   )
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildBooleanSwitch(
//     BuildContext context, {
//     required String text,
//     required bool value,
//     required ValueChanged<bool> onChanged,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           text,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         Switch(
//           value: value,
//           onChanged: onChanged,
//         ),
//         Text(value ? "Yes" : "No"),
//       ],
//     );
//   }

//   Widget _buildHotelList() {
//     return Expanded(
//       child: BlocBuilder<HotelFilterBloc, HotelFilterState>(
//         builder: (context, state) {
//           if (state is HotelFilterLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is HotelFilterError) {
//             return Center(child: Text('Error: ${state.errorMessage}'));
//           } else if (state is HotelFilterLoaded) {
//             final hotels = state.hotels;
//             return hotels.isEmpty
//                 ? const Center(child: Text("No Hotels Found"))
//                 : ListView.builder(
//                     itemCount: hotels.length,
//                     itemBuilder: (context, index) {
//                       final hotel = hotels[index];
//                       return _buildHotelListItem(hotel);
//                     },
//                   );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }

//   Widget _buildHotelListItem(HotelFilterEntity hotel) {
//     return ListTile(
//       title: Text(hotel.city),
//       subtitle: Text('Hotel: ${hotel.hotelName}'),
//       trailing: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Pincode: ${hotel.pincode}'),
//           Text('Couple Friendly: ${hotel.isCoupleFriendly ? "Yes" : "No"}'),
//           Text('Parking Facility: ${hotel.hasParkingFacility ? "Yes" : "No"}'),
//         ],
//       ),
//     );
//   }
// }

// // Enums to help with filtering
// enum FilterType {
//   category,
//   hotelType,
// }

// enum BooleanFilterType {
//   coupleFriendly,
//   parkingFacility,
// }


// // class HotelFilterState extends Equatable {
// //   final List<HotelFilterEntity> hotels;
// //   final List<String> selectedCategories;
// //   final List<String> selectedHotelTypes;
// //   final bool isCoupleFriendly;
// //   final bool hasParkingFacility;
// //   final String? errorMessage;

// //   const HotelFilterState({
// //     this.hotels = const [],
// //     this.selectedCategories = const [],
// //     this.selectedHotelTypes = const [],
// //     this.isCoupleFriendly = true,
// //     this.hasParkingFacility = true,
// //     this.errorMessage,
// //   });

// //   HotelFilterState copyWith({
// //     List<HotelFilterEntity>? hotels,
// //     List<String>? selectedCategories,
// //     List<String>? selectedHotelTypes,
// //     bool? isCoupleFriendly,
// //     bool? hasParkingFacility,
// //     String? errorMessage,
// //   }) {
// //     return HotelFilterState(
// //       hotels: hotels ?? this.hotels,
// //       selectedCategories: selectedCategories ?? this.selectedCategories,
// //       selectedHotelTypes: selectedHotelTypes ?? this.selectedHotelTypes,
// //       isCoupleFriendly: isCoupleFriendly ?? this.isCoupleFriendly,
// //       hasParkingFacility: hasParkingFacility ?? this.hasParkingFacility,
// //       errorMessage: errorMessage,
// //     );
// //   }

// //   @override
// //   List<Object?> get props => [
// //     hotels, 
// //     selectedCategories, 
// //     selectedHotelTypes, 
// //     isCoupleFriendly, 
// //     hasParkingFacility, 
// //     errorMessage
// //   ];
// // }

// // BLoC
// // class HotelFilterBloc extends Bloc<HotelFilterEvent, HotelFilterState> {
// //   final HotelFilterRepository repository;

// //   HotelFilterBloc(this.repository) : super(const HotelFilterState()) {
// //     on<InitialFetchEvent>(_onInitialFetch);
// //     on<UpdateFilterEvent>(_onUpdateFilter);
// //     on<UpdateBooleanFilterEvent>(_onUpdateBooleanFilter);
// //   }

// //   Future<void> _onInitialFetch(
// //     InitialFetchEvent event, 
// //     Emitter<HotelFilterState> emit
// //   ) async {
// //     try {
// //       final hotels = await repository.getFilteredHotels(
// //         isCoupleFriendly: state.isCoupleFriendly,
// //         hasParkingFacility: state.hasParkingFacility,
// //       );
// //       emit(state.copyWith(hotels: hotels));
// //     } catch (e) {
// //       emit(state.copyWith(errorMessage: e.toString()));
// //     }
// //   }

// //   Future<void> _onUpdateFilter(
// //     UpdateFilterEvent event, 
// //     Emitter<HotelFilterState> emit
// //   ) async {
// //     List<String> updatedCategories = List.from(state.selectedCategories);
// //     List<String> updatedHotelTypes = List.from(state.selectedHotelTypes);

// //     if (event.filterType == FilterType.category) {
// //       event.isSelected 
// //         ? updatedCategories.add(event.item)
// //         : updatedCategories.remove(event.item);
// //     } else {
// //       event.isSelected 
// //         ? updatedHotelTypes.add(event.item)
// //         : updatedHotelTypes.remove(event.item);
// //     }

// //     try {
// //       final hotels = await repository.getFilteredHotels(
// //         categories: updatedCategories.isNotEmpty ? updatedCategories : null,
// //         hotelTypes: updatedHotelTypes.isNotEmpty ? updatedHotelTypes : null,
// //         isCoupleFriendly: state.isCoupleFriendly,
// //         hasParkingFacility: state.hasParkingFacility,
// //       );

// //       emit(state.copyWith(
// //         hotels: hotels,
// //         selectedCategories: updatedCategories,
// //         selectedHotelTypes: updatedHotelTypes,
// //       ));
// //     } catch (e) {
// //       emit(state.copyWith(errorMessage: e.toString()));
// //     }
// //   }

// //   Future<void> _onUpdateBooleanFilter(
// //     UpdateBooleanFilterEvent event, 
// //     Emitter<HotelFilterState> emit
// //   ) async {
// //     try {
// //       final hotels = await repository.getFilteredHotels(
// //         categories: state.selectedCategories.isNotEmpty 
// //           ? state.selectedCategories 
// //           : null,
// //         hotelTypes: state.selectedHotelTypes.isNotEmpty 
// //           ? state.selectedHotelTypes 
// //           : null,
// //         isCoupleFriendly: event.filterType == BooleanFilterType.coupleFriendly 
// //           ? event.value 
// //           : state.isCoupleFriendly,
// //         hasParkingFacility: event.filterType == BooleanFilterType.parkingFacility 
// //           ? event.value 
// //           : state.hasParkingFacility,
// //       );

// //       emit(state.copyWith(
// //         hotels: hotels,
// //         isCoupleFriendly: event.filterType == BooleanFilterType.coupleFriendly 
// //           ? event.value 
// //           : state.isCoupleFriendly,
// //         hasParkingFacility: event.filterType == BooleanFilterType.parkingFacility 
// //           ? event.value 
// //           : state.hasParkingFacility,
// //       ));
// //     } catch (e) {
// //       emit(state.copyWith(errorMessage: e.toString()));
// //     }
// //   }
// // }

// // lib/features/hotels/presentation/pages/hotel_filter_page.dart
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../bloc/hotel_filter_bloc.dart';
// // import '../../domain/entities/hotel_entity.dart';


// // lib/features/hotels/presentation/bloc/hotel_filter_bloc.dart
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:equatable/equatable.dart';
// // import '../../domain/entities/hotel_entity.dart';
// // import '../../domain/repositories/hotel_repository.dart';

// // Events
// // abstract class HotelFilterEvent extends Equatable {
// //   const HotelFilterEvent();

// //   @override
// //   List<Object> get props => [];
// // }

// // class FetchFilteredHotelsEvent extends HotelFilterEvent {
// //   final List<String>? categories;
// //   final List<String>? hotelTypes;
// //   final bool? isCoupleFriendly;
// //   final bool? hasParkingFacility;

// //   const FetchFilteredHotelsEvent({
// //     this.categories,
// //     this.hotelTypes,
// //     this.isCoupleFriendly,
// //     this.hasParkingFacility,
// //   });

// //   @override
// //   List<Object> get props => [
// //     categories ?? [],
// //     hotelTypes ?? [],
// //     isCoupleFriendly ?? false,
// //     hasParkingFacility ?? false
// //   ];
// // }

// // // States
// // abstract class HotelFilterState extends Equatable {
// //   const HotelFilterState();
  
// //   @override
// //   List<Object> get props => [];
// // }

// // class HotelFilterInitial extends HotelFilterState {}

// // class HotelFilterLoading extends HotelFilterState {}

// // class HotelFilterLoaded extends HotelFilterState {
// //   final List<HotelFilterEntity> hotels;

// //   const HotelFilterLoaded(this.hotels);

// //   @override
// //   List<Object> get props => [hotels];
// // }

// // class HotelFilterError extends HotelFilterState {
// //   final String message;

// //   const HotelFilterError(this.message);

// //   @override
// //   List<Object> get props => [message];
// // }

// // // BLoC
// // class HotelFilterBloc extends Bloc<HotelFilterEvent, HotelFilterState> {
// //   final HotelFilterRepository repository;

// //   HotelFilterBloc(this.repository) : super(HotelFilterInitial()) {
// //     on<FetchFilteredHotelsEvent>(_onFetchFilteredHotels);
// //   }

// //   void _onFetchFilteredHotels(
// //     FetchFilteredHotelsEvent event,
// //     Emitter<HotelFilterState> emit,
// //   ) async {
// //     emit(HotelFilterLoading());
// //     try {
// //       final hotels = await repository.getFilteredHotels(
// //         categories: event.categories,
// //         hotelTypes: event.hotelTypes,
// //         isCoupleFriendly: event.isCoupleFriendly,
// //         hasParkingFacility: event.hasParkingFacility,
// //       );
// //       emit(HotelFilterLoaded(hotels));
// //     } catch (e) {
// //       emit(HotelFilterError(e.toString()));
// //     }
// //   }
// // }




// // lib/features/hotels/presentation/bloc/hotel_filter_bloc.dart
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:equatable/equatable.dart';
// // import '../../domain/entities/hotel_entity.dart';
// // import '../../domain/repositories/hotel_repository.dart';
// // import '../pages/hotel_filter_page.dart';

// // // Events
// // abstract class HotelFilterEvent extends Equatable {
// //   const HotelFilterEvent();

// //   @override
// //   List<Object> get props => [];
// // }

// // class InitialFetchEvent extends HotelFilterEvent {}

// // class UpdateFilterEvent extends HotelFilterEvent {
// //   final String item;
// //   final bool isSelected;
// //   final FilterType filterType;

// //   const UpdateFilterEvent({
// //     required this.item,
// //     required this.isSelected,
// //     required this.filterType,
// //   });

// //   @override
// //   List<Object> get props => [item, isSelected, filterType];
// // }

// // class UpdateBooleanFilterEvent extends HotelFilterEvent {
// //   final BooleanFilterType filterType;
// //   final bool value;

// //   const UpdateBooleanFilterEvent({
// //     required this.filterType,
// //     required this.value,
// //   });

// //   @override
// //   List<Object> get props => [filterType, value];
// // }

// // States
// // lib/features/hotels/presentation/states/hotel_filter_states.dart
// // import 'package:equatable/equatable.dart';
// // import '../../domain/entities/hotel_entity.dart';