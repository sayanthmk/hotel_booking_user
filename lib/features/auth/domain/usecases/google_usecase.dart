import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/auth/domain/repos/google_section.dart';

//-----------Signin Google-----------------

class SignInWithGoogle {
  final AuthRepository repositrory;
  SignInWithGoogle({required this.repositrory});

  Future<User?> call() async {
    return await repositrory.signInWithGoogle();
  }
}

//-----------SignIN Email & Password-----------------//

class SignInWithEmailAndPassword {
  final AuthRepository repository;
  SignInWithEmailAndPassword({required this.repository});

  Future<void> call(String email, String password) async {
    return await repository.signInWithEmailAndPassword(email, password);
  }
}

//-----------SignUp Email & Password----------------

class SignUpWithEmailAndPassword {
  final AuthRepository repository;
  SignUpWithEmailAndPassword({required this.repository});

  Future<void> call(String email, String password) async {
    return await repository.signUpWithEmailAndPassword(email, password);
  }
}

//-----------Sign-Out----------------

class SignOut {
  final AuthRepository repository;
  SignOut({required this.repository});

  Future<void> call() async {
    return await repository.signOut();
  }
}

//-----------Get User----------------

class GetCurrentUser {
  final AuthRepository repository;
  GetCurrentUser({required this.repository});

  User? call() {
    return repository.getCurrentUser();
  }
}
