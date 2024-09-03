import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/auth/domain/usecases/google_usecase.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, Authstate> {
  final SignInWithGoogle signInWithGoogle;
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
 
  AuthBloc(
    {
    required this.signInWithGoogle,
    required this.signInWithEmailAndPassword,
    required this.signUpWithEmailAndPassword,
    required this.signOut,
    required this.getCurrentUser,
  }) : super(AuthInitial()) {
    on<FetchCurrentUser>((event, emit) {
      final user = getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnAuthenticated());
      }
    });

    //=====================SignIn-Google-Event========================
    on<SignInGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signInWithGoogle();
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================SignIn-EmailPassword-Event========================
    on<SignInEmailPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signInWithEmailAndPassword(event.email, event.password);

        final user = getCurrentUser();

        emit(AuthAuthenticated(user!));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================SignUp-EmailPassword-Event========================
    on<SignUpEmailPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signUpWithEmailAndPassword(event.email, event.password);

        final user = getCurrentUser();

        emit(AuthAuthenticated(user!));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================SignOut-Event========================
    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signOut();
        // await clearAuthToken();
        emit(AuthUnAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
