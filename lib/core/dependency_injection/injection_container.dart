import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_booking/features/auth/data/datasourses/googledatasourse.dart';
import 'package:hotel_booking/features/auth/data/repos/google_repo.dart';
import 'package:hotel_booking/features/auth/domain/repos/google_section.dart';
import 'package:hotel_booking/features/auth/domain/usecases/google_usecase.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';

final sl = GetIt.instance;
final FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;

Future<void> init() async {
// FirebaseAuth===========================================
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);
// GoogleSignIn===========================================
  final googleSignIn = GoogleSignIn();
  sl.registerLazySingleton(() => googleSignIn);
  sl.registerLazySingleton<FirebaseDataSource>(
    () => FirebaseDataSource(
        firebaseAuth: sl<FirebaseAuth>(), googleSignIn: sl<GoogleSignIn>()),
  );
// Repositories===========================================================================================
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        firebaseDataSource: sl<FirebaseDataSource>(),
      ));
//Usecases======================================================================
  sl.registerLazySingleton(() => SignInWithGoogle(repositrory: sl()));
  sl.registerLazySingleton(() => SignInWithEmailAndPassword(repository: sl()));
  sl.registerLazySingleton(() => SignUpWithEmailAndPassword(repository: sl()));
  sl.registerLazySingleton(() => SignOut(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUser(repository: sl()));

//BLoC==================================
  sl.registerFactory(() => AuthBloc(
        signInWithGoogle: sl(),
        signInWithEmailAndPassword: sl(),
        signUpWithEmailAndPassword: sl(),
        signOut: sl(),
        getCurrentUser: sl(),
      ));
}
