import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking/features/location/domain/entity/location_entity.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserLocationEvent extends LocationEvent {
  const FetchUserLocationEvent();
}

class FetchCurrentLocationEvent extends LocationEvent {
  const FetchCurrentLocationEvent();
}

class UpdateUserLocationEvent extends LocationEvent {
  final LocationEntity newLocation;

  const UpdateUserLocationEvent(this.newLocation);

  @override
  List<Object?> get props => [newLocation];
}

class StopLocationUpdatesEvent extends LocationEvent {
  const StopLocationUpdatesEvent();
}

class FetchAddressFromLatLngEvent extends LocationEvent {
  final LatLng position;

  const FetchAddressFromLatLngEvent(this.position);

  @override
  List<Object?> get props => [position];
}
