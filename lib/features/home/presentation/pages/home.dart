// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/utils/alertbox.dart';
// import 'package:hotel_booking/features/auth/presentation/pages/routepage.dart';
// import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Center(
//             child: Text('Welcome to the Home Page!'),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return CustomAlertDialog(
//                     titleText: 'Delete',
//                     contentText: 'Are you sure want to Logout?',
//                     buttonText1: 'Cancel',
//                     buttonText2: 'Logout',
//                     onPressButton1: () {
//                       Navigator.of(context).pop();
//                     },
//                     onPressButton2: () {
//                       log('Action 2 executed');
//                       context.read<AuthBloc>().add(SignOutEvent());
//                       log('Logout button pressed');
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                           builder: (context) => const AuthSelectionPage(),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             },
//             child: const Text('Logout'),
//           ),
//         ],
//       ),
//     );
//   }
// }
