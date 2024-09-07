import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/auth/domain/repos/google_section.dart';

//-----------SignIn Google-----------------

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle({required this.repository});

  Future<User?> call() async {
    return await repository.signInWithGoogle();
  }
}

//-----------SignIn Email & Password-----------------//

class SignInWithEmailAndPassword {
  final AuthRepository repository;

  SignInWithEmailAndPassword({required this.repository});

  Future<void> call(String email, String password) async {
    return await repository.signInWithEmailAndPassword(email, password);
  }
}

//-----------SignUp Email & Password----------------//

class SignUpWithEmailAndPassword {
  final AuthRepository repository;

  SignUpWithEmailAndPassword({required this.repository});

  Future<void> call(String email, String password) async {
    return await repository.signUpWithEmailAndPassword(email, password);
  }
}

//-----------Sign-Out----------------//

class SignOut {
  final AuthRepository repository;

  SignOut({required this.repository});

  Future<void> call() async {
    return await repository.signOut();
  }
}

//-----------Get Current User----------------//

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser({required this.repository});

  User? call() {
    return repository.getCurrentUser();
  }
}

//-----------SignIn Phone Number-----------------//

class SignInWithPhoneNumber {
  final AuthRepository repository;

  SignInWithPhoneNumber({required this.repository});

  Future<void> call(String phoneNumber, Function(String) codeSent,
      {Function(FirebaseAuthException)? verificationFailed}) async {
    return await repository.signInWithPhoneNumber(phoneNumber, codeSent,
        verificationFailed: verificationFailed);
  }
}

//-----------Verify OTP----------------//

class VerifyOTP {
  final AuthRepository repository;

  VerifyOTP({required this.repository});

  Future<User?> call(String verificationId, String smsCode) async {
    return await repository.verifyOTP(verificationId, smsCode);
  }
}
