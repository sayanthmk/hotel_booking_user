part of 'google_auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInGoogleEvent extends AuthEvent {}

class SignInEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEmailPasswordEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const SignUpEmailPasswordEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignOutEvent extends AuthEvent {}

class CheckStatusEvent extends AuthEvent {}

class FetchCurrentUser extends AuthEvent {}
