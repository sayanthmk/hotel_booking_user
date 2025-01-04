import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/report/data/model/report_model.dart';
import 'package:uuid/uuid.dart';

abstract class ReportDataSource {
  Future<void> saveUserReport(
    ReportModel reportData,
    String hotelId,
  );
  Future<List<ReportModel>> getUserReport();

  Future<List<ReportModel>> getAdminReports(String hotelId);
  Future<ReportModel> getSingleUserReports(String hotelId);
  Future<void> deleteUserReports(String bookingId, String hotelId);
}

class ReportDataSourceImpl implements ReportDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Uuid _uuid = const Uuid();

  ReportDataSourceImpl(this._firestore, this._auth);

  @override
  Future<void> saveUserReport(
    ReportModel reportData,
    String hotelId,
  ) async {
    try {
      final User? currentUser = _auth.currentUser;
      final adminId = _firestore.collection('admin').doc().id;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }
      final String reportId = _uuid.v4();
      final bookingRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reports')
          .doc(reportId);

      await bookingRef.set(
        {
          'userId': currentUser.uid,
          'hotelId': hotelId,
          'reportId': reportId,
          'reportDetails': reportData.toMap(),
        },
      );

      ////////////////////////////////////////
      await _firestore
          .collection('admin')
          .doc(adminId)
          .collection('reports')
          .doc(reportId)
          .set(
        {
          'hotelId': hotelId,
          'bookingId': reportId,
          'bookingDetails': reportData.toMap(),
        },
      );
    } catch (e) {
      throw Exception('Failed to save user reports: $e');
    }
  }

  @override
  Future<List<ReportModel>> getUserReport() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final querySnapshot = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reports')
          .get();
      final reports = querySnapshot.docs
          .map((doc) => ReportModel.fromMap(doc.data(), id: doc.id))
          .toList();

      return reports;
    } catch (e) {
      throw Exception('Failed to retrieve user bookings: $e');
    }
  }

  @override
  Future<ReportModel> getSingleUserReports(String reportId) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final docSnapshot = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reports')
          .doc(reportId)
          .get();

      if (!docSnapshot.exists) {
        throw Exception('Booking with ID $reportId not found');
      }

      return ReportModel.fromMap(docSnapshot.data()!, id: docSnapshot.id);
    } catch (e) {
      throw Exception('Failed to retrieve report details: $e');
    }
  }

  @override
  Future<List<ReportModel>> getAdminReports(String hotelId) async {
    try {
      final adminId = _firestore.collection('admin').doc().id;
      final querySnapshot = await _firestore
          .collection('admin')
          .doc(adminId)
          .collection('reports')
          .get();
      return querySnapshot.docs
          .map((doc) => ReportModel.fromMap(doc.data(), id: doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to retrieve hotel Reports: $e');
    }
  }

  @override
  Future<void> deleteUserReports(String reportId, String hotelId) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final bookingRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reports')
          .doc(reportId);

      await bookingRef.delete();

      final bookingRefr = _firestore
          .collection('admin')
          .doc(hotelId)
          .collection('reports')
          .doc(reportId);

      await bookingRefr.delete();
    } catch (e) {
      throw Exception('Failed to delete user booking: $e');
    }
  }
}
