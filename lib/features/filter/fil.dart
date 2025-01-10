// hotel_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HotelState extends Equatable {
  final List<String> selectedCategories;
  final List<String> selectedHotelTypes;
  final bool coupleFriendly;
  final bool parkingFacility;
  final bool freeCancel;
  final List<Map<String, dynamic>> filteredProducts;
  final bool isLoading;
  final String? error;

  const HotelState({
    this.selectedCategories = const [],
    this.selectedHotelTypes = const [],
    this.coupleFriendly = false,
    this.parkingFacility = false,
    this.freeCancel = false,
    this.filteredProducts = const [],
    this.isLoading = false,
    this.error,
  });

  HotelState copyWith({
    List<String>? selectedCategories,
    List<String>? selectedHotelTypes,
    bool? coupleFriendly,
    bool? parkingFacility,
    bool? freeCancel,
    List<Map<String, dynamic>>? filteredProducts,
    bool? isLoading,
    String? error,
  }) {
    return HotelState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedHotelTypes: selectedHotelTypes ?? this.selectedHotelTypes,
      coupleFriendly: coupleFriendly ?? this.coupleFriendly,
      parkingFacility: parkingFacility ?? this.parkingFacility,
      freeCancel: freeCancel ?? this.freeCancel,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        selectedCategories,
        selectedHotelTypes,
        coupleFriendly,
        parkingFacility,
        freeCancel,
        filteredProducts,
        isLoading,
        error,
      ];
}

// hotel_event.dart

abstract class HotelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeHotelFilters extends HotelEvent {}

class UpdateCategoryFilter extends HotelEvent {
  final String category;
  final bool isSelected;

  UpdateCategoryFilter(this.category, this.isSelected);

  @override
  List<Object?> get props => [category, isSelected];
}

class UpdateHotelTypeFilter extends HotelEvent {
  final String hotelType;
  final bool isSelected;

  UpdateHotelTypeFilter(this.hotelType, this.isSelected);

  @override
  List<Object?> get props => [hotelType, isSelected];
}

class UpdateCoupleFriendlyFilter extends HotelEvent {
  final bool value;

  UpdateCoupleFriendlyFilter(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateParkingFacilityFilter extends HotelEvent {
  final bool value;

  UpdateParkingFacilityFilter(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateFreeCancelFilter extends HotelEvent {
  final bool value;

  UpdateFreeCancelFilter(this.value);

  @override
  List<Object?> get props => [value];
}

// hotel_bloc.dart

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final FirebaseFirestore _firestore;

  HotelBloc({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(const HotelState()) {
    on<InitializeHotelFilters>(_onInitialize);
    on<UpdateCategoryFilter>(_onUpdateCategoryFilter);
    on<UpdateHotelTypeFilter>(_onUpdateHotelTypeFilter);
    on<UpdateCoupleFriendlyFilter>(_onUpdateCoupleFriendlyFilter);
    on<UpdateParkingFacilityFilter>(_onUpdateParkingFacilityFilter);
    on<UpdateFreeCancelFilter>(_onUpdateFreeCancelFilter);
  }

  Future<void> _onInitialize(
    InitializeHotelFilters event,
    Emitter<HotelState> emit,
  ) async {
    await _fetchFilteredProducts(emit);
  }

  Future<void> _onUpdateCategoryFilter(
    UpdateCategoryFilter event,
    Emitter<HotelState> emit,
  ) async {
    final updatedCategories = List<String>.from(state.selectedCategories);
    if (event.isSelected) {
      updatedCategories.add(event.category);
    } else {
      updatedCategories.remove(event.category);
    }
    emit(state.copyWith(selectedCategories: updatedCategories));
    await _fetchFilteredProducts(emit);
  }

  Future<void> _onUpdateHotelTypeFilter(
    UpdateHotelTypeFilter event,
    Emitter<HotelState> emit,
  ) async {
    final updatedTypes = List<String>.from(state.selectedHotelTypes);
    if (event.isSelected) {
      updatedTypes.add(event.hotelType);
    } else {
      updatedTypes.remove(event.hotelType);
    }
    emit(state.copyWith(selectedHotelTypes: updatedTypes));
    await _fetchFilteredProducts(emit);
  }

  Future<void> _onUpdateCoupleFriendlyFilter(
    UpdateCoupleFriendlyFilter event,
    Emitter<HotelState> emit,
  ) async {
    emit(state.copyWith(coupleFriendly: event.value));
    await _fetchFilteredProducts(emit);
  }

  Future<void> _onUpdateParkingFacilityFilter(
    UpdateParkingFacilityFilter event,
    Emitter<HotelState> emit,
  ) async {
    emit(state.copyWith(parkingFacility: event.value));
    await _fetchFilteredProducts(emit);
  }

  Future<void> _onUpdateFreeCancelFilter(
    UpdateFreeCancelFilter event,
    Emitter<HotelState> emit,
  ) async {
    emit(state.copyWith(freeCancel: event.value));
    await _fetchFilteredProducts(emit);
  }

  Future<void> _fetchFilteredProducts(Emitter<HotelState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      Query query = _firestore.collection('approved_hotels');

      if (state.selectedCategories.isNotEmpty) {
        query = query.where('city', whereIn: state.selectedCategories);
      }

      if (state.selectedHotelTypes.isNotEmpty) {
        query = query.where('Booking_since', whereIn: state.selectedHotelTypes);
      }

      if (state.coupleFriendly) {
        query = query.where('couple_friendly', isEqualTo: true);
      }

      if (state.parkingFacility) {
        query = query.where('parking_facility', isEqualTo: true);
      }

      if (state.freeCancel) {
        query = query.where('free_cancel', isEqualTo: true);
      }

      final QuerySnapshot querySnapshot = await query.get();
      final products = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      emit(state.copyWith(
        filteredProducts: products,
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}

// multi_filter_products_page.dart

class MultiFilterProductsPage extends StatelessWidget {
  const MultiFilterProductsPage({super.key});

  static const List<String> categories = [
    "chennai",
    "Fashion",
    "Books",
    "Home"
  ];
  static const List<String> hotelTypes = [
    "Villa",
    "Bunglow",
    "Hotel",
    "Resort"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelBloc()..add(InitializeHotelFilters()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Multi-Filter Products"),
        ),
        body: BlocBuilder<HotelBloc, HotelState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Select Categories:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                _buildFilterChips(
                  context: context,
                  items: categories,
                  selectedItems: state.selectedCategories,
                  onSelected: (category, isSelected) {
                    context
                        .read<HotelBloc>()
                        .add(UpdateCategoryFilter(category, isSelected));
                  },
                ),
                const Text(
                  "Select Hotel Items:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                _buildFilterChips(
                  context: context,
                  items: hotelTypes,
                  selectedItems: state.selectedHotelTypes,
                  onSelected: (type, isSelected) {
                    context
                        .read<HotelBloc>()
                        .add(UpdateHotelTypeFilter(type, isSelected));
                  },
                ),
                const SizedBox(height: 10),
                BooleanFilterWidget(
                  text: 'couplefriendly',
                  isAvailable: state.coupleFriendly,
                  onChanged: (value) {
                    context
                        .read<HotelBloc>()
                        .add(UpdateCoupleFriendlyFilter(value));
                  },
                ),
                BooleanFilterWidget(
                  text: 'parkingFacility',
                  isAvailable: state.parkingFacility,
                  onChanged: (value) {
                    context
                        .read<HotelBloc>()
                        .add(UpdateParkingFacilityFilter(value));
                  },
                ),
                BooleanFilterWidget(
                  text: 'free_cancel',
                  isAvailable: state.freeCancel,
                  onChanged: (value) {
                    context
                        .read<HotelBloc>()
                        .add(UpdateFreeCancelFilter(value));
                  },
                ),
                const Divider(),
                const Text(
                  "Filtered Products:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: state.filteredProducts.isEmpty
                      ? const Center(child: Text("No Products Found"))
                      : ListView.builder(
                          itemCount: state.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = state.filteredProducts[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(product['city'] ?? 'No City'),
                                Text(
                                    'Hotel: ${product['hotel_name'] ?? 'Unknown'}'),
                                Text('Pincode: ${product['pincode'] ?? 'N/A'}'),
                                Text(
                                    'couple_friendly: ${product['couple_friendly'] == true ? "Yes" : "No"}'),
                                Text(
                                    'parking_facility: ${product['parking_facility'] == true ? "Yes" : "No"}'),
                                Text(
                                    'free_cancel: ${product['free_cancel'] == true ? "Yes" : "No"}'),
                                const SizedBox(height: 30),
                              ],
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterChips({
    required BuildContext context,
    required List<String> items,
    required List<String> selectedItems,
    required Function(String, bool) onSelected,
  }) {
    return Wrap(
      spacing: 10,
      children: items.map((item) {
        return FilterChip(
          label: Text(item),
          selected: selectedItems.contains(item),
          onSelected: (isSelected) => onSelected(item, isSelected),
        );
      }).toList(),
    );
  }
}

class BooleanFilterWidget extends StatelessWidget {
  final bool isAvailable;
  final ValueChanged<bool> onChanged;
  final String text;

  const BooleanFilterWidget({
    super.key,
    required this.isAvailable,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Switch(
          value: isAvailable,
          onChanged: onChanged,
        ),
        Text(isAvailable ? "Yes" : "No"),
      ],
    );
  }
}
