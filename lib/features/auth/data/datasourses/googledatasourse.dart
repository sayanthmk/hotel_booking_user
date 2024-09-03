//------------------------------------------------------------fixed------------------------------------------//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  FirebaseDataSource({required this.firebaseAuth, required this.googleSignIn});

//------------------SignIn --Google ------------------------------------//

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return (await firebaseAuth.signInWithCredential(credential)).user;
  }

//------------------SignIn --Email & Password ------------------------------------//

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

//------------------SignUp --Email & Password ------------------------------------//

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('Error during sign-up: $e');
      }
      return null;
    }
  }

//------------------SignOut ------------------------------------//

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

//------------------SignUp --Get the User ------------------------------------//

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }
}
