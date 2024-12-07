import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState()) {
    on<ToggleFilterEvent>((event, emit) {
      final updatedFilters = List<String>.from(state.activeFilters);

      if (event.isSelected) {
        updatedFilters.add(event.filter);
      } else {
        updatedFilters.remove(event.filter);
      }

      emit(FilterState(activeFilters: updatedFilters));
    });

    on<ResetFiltersEvent>((_, emit) {
      emit(const FilterState(activeFilters: []));
    });
  }
}
