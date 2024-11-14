import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
import 'package:hotel_booking/features/auth/presentation/pages/routepage.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart'
    as di;
import 'package:hotel_booking/features/home/domain/usecase/hotel_usecase.dart';
import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
import 'package:hotel_booking/features/home/presentation/pages/home.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/booking_home.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/hotels_list_view.dart';
import 'package:hotel_booking/features/home/presentation/pages/selected_hotel/sample_det.dart';
import 'package:hotel_booking/features/home/presentation/pages/sample_page.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/stripe/data/datasourse/consts.dart';
import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_bloc.dart';
import 'package:hotel_booking/features/stripe/presentation/pages/stripe_bloc_payment_page.dart';
import 'package:hotel_booking/firebase_options.dart';
import 'package:provider/provider.dart';

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
        //=================
        // BlocProvider(
        //   create: (context) => HotelBloc(
        //     HotelRepositoryImpl(
        //       FirebaseHotelDataSource(),
        //     ),
        //   ),
        // )
        // BlocProvider(
        //   create: (_) =>
        //       HotelBloc(di.sl<FetchHotelsUseCase>())..add(LoadHotelsEvent()),
        // ),
        // ChangeNotifierProvider(create: (_) => PaymentProvider()),
        BlocProvider(
          create: (_) => di.sl<StripePaymentBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<HotelBloc>(),
        ),
        //=================
        // BlocProvider(
        //   create: (context) => ProductBloc(),
        //   child: const ProductListScreen(),
        // ),
        BlocProvider<SelectedHotelBloc>(
          create: (context) => sl<SelectedHotelBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel Booking',
        theme: ThemeData(
          fontFamily: 'PTSans',
          primarySwatch: Colors.blue,
        ),
        home: const AuthSelectionPage(),
        // home: RoomBookingHome(),
      ),
    );
  }
}
