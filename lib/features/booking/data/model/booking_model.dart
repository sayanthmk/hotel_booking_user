import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  final String? id;
  final String? bookId;
  final String? hotelId;
  final String name;
  final int age;
  final String place;
  final DateTime startdate;
  final DateTime enddate;
  final int noc;
  final int noa;
  final String roomId;

  UserDataModel(
      {this.id,
      this.bookId,
      this.hotelId,
      required this.roomId,
      required this.name,
      required this.age,
      required this.place,
      required this.startdate,
      required this.enddate,
      required this.noc,
      required this.noa});

  Map<String, dynamic> toMap() {
    return {
      'cuid': roomId,
      'name': name,
      'age': age,
      'place': place,
      'startdate': Timestamp.fromDate(startdate),
      'enddate': Timestamp.fromDate(enddate),
      'noc': noc,
      'noa': noa
    };
  }

  factory UserDataModel.fromMap(
    Map<String, dynamic> map, {
    String? id,
    String? hotelId,
  }) {
    final rpt = map['bookingDetails'];
    return UserDataModel(
      bookId: map['bookingId'] ?? '',
      hotelId: map['hotelId'] ?? '',
      id: id,
      roomId: rpt['cuid'] ?? '',
      name: rpt['name'] ?? '',
      age: rpt['age'] ?? 0,
      place: rpt['place'] ?? '',
      startdate: (rpt['startdate'] != null && rpt['startdate'] is Timestamp)
          ? (rpt['startdate'] as Timestamp).toDate()
          : DateTime.now(),
      enddate: (rpt['enddate'] != null && rpt['enddate'] is Timestamp)
          ? (rpt['enddate'] as Timestamp).toDate()
          : DateTime.now(),
      noc: rpt['noc'] ?? 0,
      noa: rpt['noa'] ?? 0,
    );
  }
}
