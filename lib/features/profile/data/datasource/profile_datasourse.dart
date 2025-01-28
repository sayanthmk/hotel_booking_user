import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hotel_booking/features/profile/data/model/profile_model.dart';

class FirebaseUserProfileDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FirebaseUserProfileDataSource(this.firestore, this.storage);

  Future<UserProfileModel?> fetchUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return null;
    }

    final snapshot =
        await firestore.collection('users').doc(currentUser.uid).get();

    if (snapshot.exists) {
      return UserProfileModel.fromJson(snapshot.data()!, snapshot.id);
    } else {
      return null;
    }
  }

  Future<void> updateCurrentUser(Map<String, dynamic> updatedData) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await firestore
          .collection('users')
          .doc(currentUser.uid)
          .update(updatedData);
    } else {
      throw Exception("No authenticated user found.");
    }
  }

  Future<String> uploadProfileImage(File imageFile) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception("No authenticated user found.");
    }

    try {
      final storageRef = storage.ref().child(
          'profile_images/${currentUser.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask;

      // Get the download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore with the image URL
      await firestore.collection('users').doc(currentUser.uid).update({
        'profileImage': downloadUrl,
      });

      return downloadUrl;
    } catch (e) {
      throw Exception("Failed to upload image: $e");
    }
  }
}
