import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  final String? id; // Optional ID for document reference
  final String name;
  final int age;
  final String place;
  final DateTime date;
  final int noc;
  final int noa;

  UserDataModel(
      {this.id,
      required this.name,
      required this.age,
      required this.place,
      required this.date,
      required this.noc,
      required this.noa});

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'place': place,
      'date': Timestamp.fromDate(date),
      'noc': noc,
      'noa': noa
    };
  }

  // Create from Firestore document
  factory UserDataModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return UserDataModel(
      id: id,
      name: map['bookingDetails']['name'] ?? '',
      age: map['bookingDetails']['age'] ?? 0,
      place: map['bookingDetails']['place'] ?? '',
      date: (map['bookingDetails']['date'] != null &&
              map['bookingDetails']['date'] is Timestamp)
          ? (map['bookingDetails']['date'] as Timestamp).toDate()
          : DateTime.now(),
      noc: map['bookingDetails']['noc'] ?? 0,
      noa: map['bookingDetails']['noa'] ?? 0,
    );
  }
}
