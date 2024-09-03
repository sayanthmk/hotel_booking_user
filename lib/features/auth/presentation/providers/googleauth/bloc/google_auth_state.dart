part of 'google_auth_bloc.dart';

abstract class Authstate extends Equatable {
  const Authstate();

  @override
  List<Object> get props => [];
}

class AuthInitial extends Authstate {}

class AuthLoading extends Authstate {}

class AuthAuthenticated extends Authstate {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthUnAuthenticated extends Authstate {}

class AuthError extends Authstate {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
