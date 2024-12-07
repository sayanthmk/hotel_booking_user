part of 'filter_bloc.dart';

class FilterState extends Equatable {
  final List<String> activeFilters;

  const FilterState({this.activeFilters = const []});

  @override
  List<Object> get props => [activeFilters];
}
