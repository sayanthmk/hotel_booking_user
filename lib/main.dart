import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart'
    as di;
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/roomcard_bloc/room_card_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';
import 'package:hotel_booking/features/splash_screen/splash_screen.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/stripe/data/datasourse/consts.dart';
import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_bloc.dart';
import 'package:hotel_booking/features/wishlist/presentation/provider/bloc/favorites_bloc.dart';
import 'package:hotel_booking/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
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
        BlocProvider(
          create: (_) => di.sl<StripePaymentBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<HotelBloc>(),
        ),
        BlocProvider<SelectedHotelBloc>(
          create: (context) => di.sl<SelectedHotelBloc>(),
        ),
        BlocProvider<SelectedRoomBloc>(
          create: (context) => di.sl<SelectedRoomBloc>(),
        ),
        BlocProvider<RoomCardBloc>(
          create: (context) => di.sl<RoomCardBloc>(),
        ),
        // BlocProvider(
        //   create: (context) => di.sl<BookingBloc>(),
        // )
        BlocProvider(
          create: (context) => di.sl<UserBloc>(),
        ),
        // BlocProvider(
        //   create: (context) => di.sl<FavoritesBloc>(),
        // ),
        BlocProvider(
          create: (context) => di.sl<FavoritesBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel Booking',
        theme: ThemeData(
          fontFamily: 'PTSans',
          primarySwatch: Colors.blue,
        ),
        home: const LoginStatusPage(),
        // onGenerateRoute:,
        // routes: ,
        // home: HotelBookingPage(),
      ),
    );
  }
}
