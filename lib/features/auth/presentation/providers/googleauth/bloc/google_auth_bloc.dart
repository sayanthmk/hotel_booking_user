import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/features/auth/domain/usecases/google_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

//Shared preference---------------------
Future<void> setLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
}

Future<void> clearLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('isLoggedIn');
}

//-------------------------------------------
class AuthBloc extends Bloc<AuthEvent, Authstate> {
  final SignInWithGoogle signInWithGoogle;
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final SignInWithPhoneNumber signInWithPhoneNumber;
  final VerifyOTP verifyOTP;

  AuthBloc({
    required this.signInWithGoogle,
    required this.signInWithEmailAndPassword,
    required this.signUpWithEmailAndPassword,
    required this.signOut,
    required this.getCurrentUser,
    required this.signInWithPhoneNumber,
    required this.verifyOTP,
  }) : super(AuthInitial()) {
    on<FetchCurrentUser>((event, emit) async {
      final user = getCurrentUser();
      if (user != null) {
        await setLoggedIn();
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
          await setLoggedIn();
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
        await setLoggedIn(); //shared pref
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
        await clearLoggedIn(); //shared pref
        emit(AuthUnAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================SignIn-PhoneNumber-Event========================
    on<SignInPhoneNumberEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signInWithPhoneNumber.call(
          event.phoneNumber,
          (verificationId) {
            emit(AuthCodeSent(verificationId));
          },
          verificationFailed: (error) {
            emit(AuthError(message: error.message ?? "Verification failed"));
          },
        );
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================Verify-OTP-Event========================
    on<VerifyOTPEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await verifyOTP.call(event.verificationId, event.smsCode);
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
