import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  final String? id;
  final String name;
  final int age;
  final String place;
  final DateTime startdate;
  final DateTime enddate;
  final int noc;
  final int noa;
  final String cuid;

  UserDataModel(
      {this.id,
      required this.cuid,
      required this.name,
      required this.age,
      required this.place,
      required this.startdate,
      required this.enddate,
      required this.noc,
      required this.noa});

  Map<String, dynamic> toMap() {
    return {
      'cuid': cuid,
      'name': name,
      'age': age,
      'place': place,
      // 'date': Timestamp.fromDate(startdate),
      'startdate': Timestamp.fromDate(startdate),
      'enddate': Timestamp.fromDate(enddate),
      'noc': noc,
      'noa': noa
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final value = map['bookingDetails'];

    return UserDataModel(
      id: id,
      cuid: value['cuid'] ?? '',
      name: value['name'] ?? '',
      age: value['age'] ?? 0,
      place: value['place'] ?? '',
      startdate: (value['startdate'] != null && value['startdate'] is Timestamp)
          ? (value['startdate'] as Timestamp).toDate()
          : DateTime.now(),
      enddate: (value['enddate'] != null && value['enddate'] is Timestamp)
          ? (value['enddate'] as Timestamp).toDate()
          : DateTime.now(),
      noc: value['noc'] ?? 0,
      noa: value['noa'] ?? 0,
    );
  }
}
