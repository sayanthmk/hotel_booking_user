//------------------------------------------------------------fixed------------------------------------------//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/features/auth/data/datasourses/googledatasourse.dart';
import 'package:hotel_booking/features/auth/domain/repos/google_section.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseDataSource firebaseDataSource;

  AuthRepositoryImpl({required this.firebaseDataSource});

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    debugPrint('signInWithEmailAndPassword called with email: $email');
    final user =
        await firebaseDataSource.signInWithEmailAndPassword(email, password);
    if (user != null) {
      debugPrint('Email sign-in successful');
    } else {
      debugPrint('Email sign-in failed');
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    debugPrint('signInWithGoogle called');
    final user = await firebaseDataSource.signInWithGoogle();
    if (user != null) {
      debugPrint('Google sign-in successful, ${user.getIdToken()}');
    } else {
      debugPrint('Google sign-in failed');
    }
    return user;
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    debugPrint('signUpWithEmailAndPassword called with email: $email');
    final user =
        await firebaseDataSource.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      debugPrint('Email sign-up successful');
    } else {
      debugPrint('Email sign-up failed');
    }
  }

  @override
  Future<void> signOut() async {
    debugPrint('signOut called');
    await firebaseDataSource.signOut();
    debugPrint('User signed out');
  }

  @override
  User? getCurrentUser() {
    debugPrint('getCurrentUser called');
    return firebaseDataSource.getCurrentUser();
  }

  //---------------------------------- Phone Number Authentication

  @override
  Future<void> signInWithPhoneNumber(
      String phoneNumber, Function(String) codeSent,
      {Function(FirebaseAuthException)? verificationFailed}) async {
    debugPrint('signInWithPhoneNumber called with phoneNumber: $phoneNumber');
    await firebaseDataSource.signInWithPhoneNumber(phoneNumber, codeSent,
        verificationFailed: verificationFailed);
    debugPrint('Phone number sign-in process initiated');
  }

  @override
  Future<User?> verifyOTP(String verificationId, String smsCode) async {
    debugPrint('verifyOTP called with verificationId: $verificationId');
    final user = await firebaseDataSource.verifyOTP(verificationId, smsCode);
    if (user != null) {
      debugPrint('OTP verification successful');
    } else {
      debugPrint('OTP verification failed');
    }
    return user;
  }
}
