import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  final String? id;
  final String? bookId;
  final String? hotelId;
  final String? name;
  final int? age;
  final String? place;
  final DateTime? startdate;
  final DateTime? enddate;
  final int? noc;
  final int? noa;
  final String? roomId;
  final double? paidAmount;
  final DateTime? bookingDate; // Add current date field

  UserDataModel({
    this.id,
    this.bookId,
    this.hotelId,
    this.paidAmount,
    this.roomId,
    this.name,
    this.age,
    this.place,
    this.startdate,
    this.enddate,
    this.noc,
    this.noa,
    this.bookingDate, // Initialize currentDate
  });

  Map<String, dynamic> toMap() {
    return {
      'cuid': roomId,
      'name': name,
      'age': age,
      'place': place,
      'startdate': Timestamp.fromDate(startdate!),
      'enddate': Timestamp.fromDate(enddate!),
      'noc': noc,
      'noa': noa,
      'paidAmount': paidAmount,
      'bookingDate': Timestamp.fromDate(bookingDate!), // Add currentDate to map
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
      paidAmount: rpt['paidAmount'] ?? 0,
      bookingDate:
          (rpt['bookingDate'] != null && rpt['bookingDate'] is Timestamp)
              ? (rpt['bookingDate'] as Timestamp).toDate()
              : DateTime.now(), // Set current date when reading data
    );
  }
}
