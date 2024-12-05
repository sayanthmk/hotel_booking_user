import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  final String? id;
  final String? cuid;
  final String name;
  final int age;
  final String place;
  final DateTime date;
  final int noc;
  final int noa;

  UserDataModel(
      {this.id,
      this.cuid,
      required this.name,
      required this.age,
      required this.place,
      required this.date,
      required this.noc,
      required this.noa});

  Map<String, dynamic> toMap() {
    return {
      'cuid': cuid,
      'name': name,
      'age': age,
      'place': place,
      'date': Timestamp.fromDate(date),
      'noc': noc,
      'noa': noa
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return UserDataModel(
      id: id,
      cuid: map['bookingDetails']['cuid'],
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
