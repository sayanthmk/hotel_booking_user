import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/report/data/model/report_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseIssueDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth auth;

  FirebaseIssueDataSource(
    this._firestore,
    this.auth,
  );

  Future<void> reportIssue(
    IssueModel issue,
    String hotelId,
  ) async {
    const uuid = Uuid();
    try {
      final User? currentUser = auth.currentUser;

      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final String issueId = uuid.v4();
      final String userEmail = currentUser.email!;
      final issueRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reported_issues')
          .doc(issueId);

      await issueRef.set({
        'userId': currentUser.uid,
        'hotelId': hotelId,
        'issueId': issueId,
        'userEmail': userEmail,
        'issueDetails': {
          ...issue.toMap(),
        },
      });

      await _firestore
          .collection('admin')
          .doc('WH18TZOM6URMXEHB3C2lae1mXir1')
          .collection('reported_issues')
          .doc(issueId)
          .set({
        'hotelId': hotelId,
        'issueId': issueId,
        'userEmail': userEmail,
        'issueDetails': {
          ...issue.toMap(),
        },
      });
    } catch (e) {
      throw Exception('Failed to report issue: $e');
    }
  }

  Future<List<IssueModel>> fetchReportedIssues(String hotelId) async {
    final User? currentUser = auth.currentUser;
    final querySnapshot = await _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('reported_issues')
        .orderBy('issueDetails', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => IssueModel.fromMap(doc.data(), id: doc.id))
        .toList();
  }

  Future<void> deleteReportedIssue(String issueId, String hotelId) async {
    try {
      final User? currentUser = auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('reported_issues')
          .doc(issueId)
          .delete();

      await _firestore
          .collection('WH18TZOM6URMXEHB3C2lae1mXir1')
          .doc(currentUser.uid)
          .collection('reported_issues')
          .doc(issueId)
          .delete();

      log('Issue reported deleted successfully');
    } catch (e) {
      throw Exception('Failed to delete reported issue: $e');
    }
  }
}
