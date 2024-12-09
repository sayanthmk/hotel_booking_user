// // // filter_bloc_event.dart
// // import 'package:equatable/equatable.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // abstract class FilterEvent extends Equatable {
// //   @override
// //   List<Object> get props => [];
// // }

// // class ToggleFilterEvent extends FilterEvent {
// //   final String filter;
// //   final bool isSelected;

// //   ToggleFilterEvent({required this.filter, required this.isSelected});

// //   @override
// //   List<Object> get props => [filter, isSelected];
// // }

// // class ResetFiltersEvent extends FilterEvent {}
// // // filter_bloc_state.dart

// // class FilterState extends Equatable {
// //   final List<String> activeFilters;

// //   const FilterState({this.activeFilters = const []});

// //   @override
// //   List<Object> get props => [activeFilters];
// // }
// // // filter_bloc.dart
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'filter_bloc_event.dart';
// // // import 'filter_bloc_state.dart';

// // class FilterBloc extends Bloc<FilterEvent, FilterState> {
// //   FilterBloc() : super(const FilterState()) {
// //     on<ToggleFilterEvent>((event, emit) {
// //       final updatedFilters = List<String>.from(state.activeFilters);

// //       if (event.isSelected) {
// //         updatedFilters.add(event.filter);
// //       } else {
// //         updatedFilters.remove(event.filter);
// //       }

// //       emit(FilterState(activeFilters: updatedFilters));
// //     });

// //     on<ResetFiltersEvent>((_, emit) {
// //       emit(const FilterState(activeFilters: []));
// //     });
// //   }
// // }

// // class FacilityFilters extends StatelessWidget {
// //   const FacilityFilters({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<FilterBloc, FilterState>(
// //       builder: (context, filterState) {
// //         return Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //           children: [
// //             FilterChip(
// //               label: const Text('Parking'),
// //               selected: filterState.activeFilters.contains('Parking'),
// //               onSelected: (isSelected) {
// //                 context.read<FilterBloc>().add(
// //                       ToggleFilterEvent(
// //                           filter: 'Parking', isSelected: isSelected),
// //                     );
// //               },
// //             ),
// //             FilterChip(
// //               label: const Text('Couple Friendly'),
// //               selected: filterState.activeFilters.contains('Couple Friendly'),
// //               onSelected: (isSelected) {
// //                 context.read<FilterBloc>().add(
// //                       ToggleFilterEvent(
// //                           filter: 'Couple Friendly', isSelected: isSelected),
// //                     );
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../providers/filter_bloc/filter_bloc.dart';

// class FacilityFilters extends StatelessWidget {
//   const FacilityFilters({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FilterBloc, FilterState>(
//       builder: (context, filterState) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             FilterChip(
//               label: const Text('parking_facility'),
//               selected: filterState.activeFilters.contains('parking_facility'),
//               onSelected: (isSelected) {
//                 context.read<FilterBloc>().add(
//                       ToggleFilterEvent(
//                           filter: 'parking_facility', isSelected: isSelected),
//                     );
//               },
//             ),
//             FilterChip(
//               label: const Text('couple_friendly'),
//               selected: filterState.activeFilters.contains('couple_friendly'),
//               onSelected: (isSelected) {
//                 context.read<FilterBloc>().add(
//                       ToggleFilterEvent(
//                           filter: 'couple_friendly', isSelected: isSelected),
//                     );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

