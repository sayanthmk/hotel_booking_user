import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/features/location/domain/repos/location_repos.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository repository;

  LocationBloc(this.repository) : super(LocationInitial()) {
    on<FetchUserLocationEvent>(_onFetchUserLocation);
  }

  void _onFetchUserLocation(
    FetchUserLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());

    try {
      await for (final location in repository.getUserLocation()) {
        emit(LocationLoaded(LatLng(location.latitude, location.longitude)));
      }
    } catch (e) {
      emit(LocationError("Failed to fetch location: $e"));
    }
  }
}
