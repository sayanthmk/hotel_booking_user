part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleFilterEvent extends FilterEvent {
  final String filter;
  final bool isSelected;

  ToggleFilterEvent({required this.filter, required this.isSelected});

  @override
  List<Object> get props => [filter, isSelected];
}

class ResetFiltersEvent extends FilterEvent {}
