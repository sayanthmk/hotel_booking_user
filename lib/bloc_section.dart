import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/search_bloc/hotelsearch_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/location/presentation/providers/bloc/location_bloc.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_bloc.dart';
import 'package:hotel_booking/features/report/presentation/providers/bloc/report_bloc.dart';
import 'package:hotel_booking/features/review/presentation/providers/bloc/review_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/roomcard_bloc/room_card_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';
import 'package:hotel_booking/features/splash_screen/splash_screen.dart';
import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_bloc.dart';
import 'package:hotel_booking/features/wishlist/presentation/provider/bloc/favorites_bloc.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart'
    as di;

class BlocSection extends StatelessWidget {
  const BlocSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider<StripeBloc>(
          create: (context) => di.sl<StripeBloc>(),
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
        BlocProvider(
          create: (context) => di.sl<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<FavoritesBloc>(),
        ),
        BlocProvider(
          create: (context) => HotelSearchBloc(),
        ),
        BlocProvider(
          create: (context) => di.sl<ReportIssueBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ReviewBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<LocationBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserProfileBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel Booking',
        theme: ThemeData(
          textTheme: GoogleFonts.notoSansOriyaTextTheme(),
          primarySwatch: Colors.blue,
        ),
        home: const LoginStatusPage(),
      ),
    );
  }
}
