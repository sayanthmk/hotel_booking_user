part of 'google_auth_bloc.dart';

//----------------------------------------------------------------
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Google Sign-In event================================
class SignInGoogleEvent extends AuthEvent {}

// Sign-In with Email and Password event===============

class SignInEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEmailPasswordEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

// Sign-Up with Email and Password event===============
class SignUpEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const SignUpEmailPasswordEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

// Sign-Out event================================
class SignOutEvent extends AuthEvent {}

// Check Status event===========================
class CheckStatusEvent extends AuthEvent {}

// Fetch Current User event=========================
class FetchCurrentUser extends AuthEvent {}

// Sign-In with Phone Number event===============
class SignInPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;

  const SignInPhoneNumberEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

// Verify OTP event================================
class VerifyOTPEvent extends AuthEvent {
  final String verificationId;
  final String smsCode;

  const VerifyOTPEvent({
    required this.verificationId,
    required this.smsCode,
  });

  @override
  List<Object> get props => [verificationId, smsCode];
}
