import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {
  const LocationInitial();
}

class LocationLoading extends LocationState {
  const LocationLoading();
}

class LocationLoaded extends LocationState {
  final LatLng position;
  final DateTime? timestamp;
  final double? accuracy;
  final String? address;

  const LocationLoaded(
    this.position, {
    this.timestamp,
    this.accuracy,
    this.address,
  });

  @override
  List<Object?> get props => [position, address, timestamp, accuracy];

  LocationLoaded copyWith(
      {LatLng? position,
      DateTime? timestamp,
      double? accuracy,
      String? address}) {
    return LocationLoaded(
      position ?? this.position,
      timestamp: timestamp ?? this.timestamp,
      accuracy: accuracy ?? this.accuracy,
      address: address ?? this.address,
    );
  }
}

class LocationError extends LocationState {
  final String message;
  final Object? error;

  const LocationError(this.message, {this.error});

  @override
  List<Object?> get props => [message, error];
}

class LocationPermissionDenied extends LocationError {
  const LocationPermissionDenied(super.message);
}

class LocationServicesDisabled extends LocationError {
  const LocationServicesDisabled(super.message);
}

class LocationUpdateError extends LocationError {
  const LocationUpdateError(super.message, {super.error});
}
