part of 'hotelsearch_bloc.dart';

sealed class HotelsearchState extends Equatable {
  const HotelsearchState();
  
  @override
  List<Object> get props => [];
}

final class HotelsearchInitial extends HotelsearchState {}
