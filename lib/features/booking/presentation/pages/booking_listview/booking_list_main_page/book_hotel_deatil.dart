// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';

// class UserBookingsPage extends StatelessWidget {
//   const UserBookingsPage({super.key, required this.hotelId});
//   final String hotelId;
//   @override
//   Widget build(BuildContext context) {
//     context.read<HotelBloc>().add(LoadHotelByIdEvent(hotelId));
//     return Scaffold(
//       body: BlocBuilder<HotelBloc, HotelState>(
//         builder: (context, state) {
//           if (state is HotelLoadingState) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(
//                     HotelBookingColors.basictextcolor),
//               ),
//             );
//           }
//           if (state is HotelErrorState) {
//             return Text(state.message);
//           }
//           if (state is HotelLoadedState) {
//             if (state.hotels.isNotEmpty) {
//               final hotel = state.hotels.first;
//               return Column(
//                 children: [Text(hotel.bookingSince)],
//               );
//             }
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
