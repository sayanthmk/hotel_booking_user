import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/auth/presentation/pages/routepage.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart'
    as di;
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
import 'package:hotel_booking/features/home/presentation/pages/home.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/booking_home.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/hotels_list_view.dart';
import 'package:hotel_booking/features/home/presentation/pages/sample_page.dart';
import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/bloc/hotel_event.dart';

import 'package:hotel_booking/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        //=================
        // BlocProvider(
        //   create: (context) => HotelBloc(
        //     HotelRepositoryImpl(
        //       FirebaseHotelDataSource(),
        //     ),
        //   ),
        // )

        BlocProvider(
          create: (_) => di.sl<HotelBloc>(),
        ),
        //=================
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel Booking',
        theme: ThemeData(
          fontFamily: 'PTSans',
          primarySwatch: Colors.blue,
        ),
        // home: const AuthSelectionPage(),
        home: RoomBookingHome(),
      ),
    );
  }
}
