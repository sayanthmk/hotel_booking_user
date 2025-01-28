import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hotel_booking/features/report/data/model/report_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseIssueDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  FirebaseIssueDataSource(this._firestore, this.auth, this.storage);

  Future<void> reportIssue(
      IssueModel issue, String hotelId, File? imageFile) async {
    const uuid = Uuid();
    try {
      final User? currentUser = auth.currentUser;

      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      String? downloadUrl;
      if (imageFile != null && imageFile.path.isNotEmpty) {
        final storageRef = storage.ref().child(
            'reported_issues_images/${currentUser.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');

        final uploadTask = storageRef.putFile(imageFile);
        final snapshot = await uploadTask;
        downloadUrl = await snapshot.ref.getDownloadURL();
        log(downloadUrl);
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
        'reportImage': downloadUrl,
        'issueDetails': {...issue.toMap(), 'reportImage': downloadUrl},
      });

      await _firestore
          .collection('admin')
          .doc(currentUser.uid)
          .collection('reported_issues')
          .doc(issueId)
          .set({
        'hotelId': hotelId,
        'issueId': issueId,
        'userEmail': userEmail,
        'reportImage': downloadUrl,
        'issueDetails': {...issue.toMap(), 'reportImage': downloadUrl},
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
          .collection('admin')
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
