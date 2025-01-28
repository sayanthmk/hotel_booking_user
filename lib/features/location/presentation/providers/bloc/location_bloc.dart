import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/features/location/domain/repos/location_repos.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_event.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository repository;

  LocationBloc(this.repository) : super(const LocationInitial()) {
    on<FetchUserLocationEvent>(_onFetchUserLocation);
    on<UpdateUserLocationEvent>(_onUpdateUserLocation);
    on<FetchCurrentLocationEvent>(_onGetCurrentLocation);
    on<FetchAddressFromLatLngEvent>(_onGetAddressFromLatLng);
  }

  Future<void> _onFetchUserLocation(
    FetchUserLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationLoading());

    try {
      await for (final location in repository.getUserLocation()) {
        emit(LocationLoaded(LatLng(location.latitude, location.longitude)));
      }
    } catch (e) {
      emit(LocationError("Failed to fetch location: $e"));
    }
  }

  Future<void> _onUpdateUserLocation(
    UpdateUserLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    try {
      repository.updateUserLocation(event.newLocation);
      emit(LocationLoaded(LatLng(
        event.newLocation.latitude,
        event.newLocation.longitude,
      )));
    } catch (e) {
      emit(LocationError("Failed to update location: $e"));
    }
  }

  Future<void> _onGetCurrentLocation(
    FetchCurrentLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationLoading());

    try {
      await for (final location in repository.getCurrentLocation()) {
        emit(LocationLoaded(LatLng(location.latitude, location.longitude)));
        break;
      }
    } catch (e) {
      emit(LocationError("Failed to fetch current location: $e"));
    }
  }

  Future<void> _onGetAddressFromLatLng(
    FetchAddressFromLatLngEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationLoading());

    try {
      final address = await repository.getAddressFromLatLng(event.position);
      emit(LocationLoaded(event.position));
      log("Address: $address");
    } catch (e) {
      emit(LocationError("Failed to fetch address from coordinates: $e"));
    }
  }
}
