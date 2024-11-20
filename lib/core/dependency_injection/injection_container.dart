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
import 'package:hotel_booking/features/home/domain/usecase/hotel_usecase.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/rooms/data/datasourse/room_remote_datasourse.dart';
import 'package:hotel_booking/features/rooms/data/repositary/rooms_data_repositary.dart';
import 'package:hotel_booking/features/rooms/domain/repos/rooms_domain_repositary.dart';
import 'package:hotel_booking/features/rooms/domain/usecase/rooms_usecase.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/bloc/rooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/roomcard_bloc/room_card_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';

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

  sl.registerFactory(
    () => HotelRoomsBloc(getHotelRoomsUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetHotelRoomsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<RoomRepository>(
    () => RoomRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<RoomRemoteDataSource>(
    () => FirebaseRoomRemoteDataSource(sl()),
  );
  // Bloc
  sl.registerFactory<HotelBloc>(
      () => HotelBloc(hotelRepository: sl<HotelRepository>()));

  //////////////////////////////////////////////////////////////////

  // rooms==================================
  sl.registerFactory(() => SelectedHotelBloc());
  sl.registerFactory(() => SelectedRoomBloc());
  sl.registerFactory(() => RoomCardBloc());
}



//--------------------------------------------------------------------------------------//
  // Register Bloc
  // sl.registerFactory<HotelBloc>(
  //   () => HotelBloc(sl<FetchHotelsUseCase>()),
  // );
  // // sl.registerFactory<HotelBloc>(
  // //   () => HotelBloc(sl< FetchHotelsUseCase>()),
  // // );
  //   // Data source
  // sl.registerLazySingleton<HotelRemoteDataSource>(
  //     () => HotelRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()));

  // // Repository
  // sl.registerLazySingleton<HotelRepository>(
  //     () => HotelRepositoryImpl(remoteDataSource: sl<HotelRemoteDataSource>()));
//rooms
  // sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // Register Remote Data Source
  // sl.registerFactory<RoomRemoteDataSource>(
  //   () => RoomRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  // );

  // // Register Repository
  // sl.registerFactory<RoomRepository>(
  //   () => RoomsRepositoryImpl(remoteDataSource: sl<RoomRemoteDataSource>()),
  // );

  // // Register Use Case
  // sl.registerFactory<FetchRoomsUseCase>(
  //   () => FetchRoomsUseCase(sl<RoomRepository>()),
  // );