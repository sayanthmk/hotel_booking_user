import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_booking/features/auth/data/datasourses/googledatasourse.dart';
import 'package:hotel_booking/features/auth/data/repos/google_repo.dart';
import 'package:hotel_booking/features/auth/domain/repos/google_section.dart';
import 'package:hotel_booking/features/auth/domain/usecases/google_usecase.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/home/data/datasourse/hotel_remote_datasourse.dart';
import 'package:hotel_booking/features/home/data/repositary/hotel_data_repositary.dart';
import 'package:hotel_booking/features/home/domain/repos/hotel_domain_repositary.dart';
import 'package:hotel_booking/features/home/domain/usecase/get_hotels_usecase.dart';
import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_bloc.dart';

//------------------------------------------------------------------------//

final sl = GetIt.instance;
final FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;

Future<void> init() async {
  // FirebaseAuth===========================================
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);

  // GoogleSignIn===========================================
  final googleSignIn = GoogleSignIn();
  sl.registerLazySingleton(() => googleSignIn);

  // Firebase DataSource================================================================================
  sl.registerLazySingleton<FirebaseDataSource>(
    () => FirebaseDataSource(
        firebaseAuth: sl<FirebaseAuth>(), googleSignIn: sl<GoogleSignIn>()),
  );

  // Repositories===========================================================================================
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        firebaseDataSource: sl<FirebaseDataSource>(),
      ));

  // Usecases========================================================================
  sl.registerLazySingleton(() => SignInWithGoogle(repository: sl()));
  sl.registerLazySingleton(() => SignInWithEmailAndPassword(repository: sl()));
  sl.registerLazySingleton(() => SignUpWithEmailAndPassword(repository: sl()));
  sl.registerLazySingleton(() => SignOut(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUser(repository: sl()));

  // Phone Number Authentication Use Cases===========================================
  sl.registerLazySingleton(() => SignInWithPhoneNumber(repository: sl()));
  sl.registerLazySingleton(() => VerifyOTP(repository: sl()));

  // BLoC==================================
  sl.registerFactory(() => AuthBloc(
        signInWithGoogle: sl(),
        signInWithEmailAndPassword: sl(),
        signUpWithEmailAndPassword: sl(),
        signOut: sl(),
        getCurrentUser: sl(),
        signInWithPhoneNumber: sl(),
        verifyOTP: sl(),
      ));
//hotel
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // Register Remote Data Source
  sl.registerFactory<HotelRemoteDataSource>(
    () => HotelRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );

  // Register Repository
  sl.registerFactory<HotelRepository>(
    () => HotelRepositoryImpl(remoteDataSource: sl<HotelRemoteDataSource>()),
  );

  // Register Use Case
  sl.registerFactory<FetchHotelsUseCase>(
    () => FetchHotelsUseCase(sl<HotelRepository>()),
  );

  // Register Bloc
  sl.registerFactory<HotelBloc>(
    () => HotelBloc(sl<FetchHotelsUseCase>()),
  );
}
//--------------------------------------------------------------------------------------//
