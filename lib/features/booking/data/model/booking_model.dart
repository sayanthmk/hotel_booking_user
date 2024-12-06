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
    final value = map['bookingDetails'];

    return UserDataModel(
      id: id,
      cuid: value['cuid'],
      name: value['name'] ?? '',
      age: value['age'] ?? 0,
      place: value['place'] ?? '',
      date: (value['date'] != null && value['date'] is Timestamp)
          ? (value['date'] as Timestamp).toDate()
          : DateTime.now(),
      noc: value['noc'] ?? 0,
      noa: value['noa'] ?? 0,
    );
  }
}
