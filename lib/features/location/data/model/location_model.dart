import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking/features/location/domain/entity/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.latitude,
    required super.longitude,
    required super.timestamp,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      longitude: json['longitude'] ?? 0.0,
      latitude: json['latitude'] ?? 0.0,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
