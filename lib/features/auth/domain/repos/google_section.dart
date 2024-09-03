//------------------------------------------------------------fixed------------------------------------------//
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signInWithGoogle();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  User? getCurrentUser();
}
