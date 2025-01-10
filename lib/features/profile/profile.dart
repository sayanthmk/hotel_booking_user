// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/auth/presentation/pages/routepage.dart';
// import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
// import 'package:hotel_booking/utils/alertbox.dart';

// class MyProfile extends StatelessWidget {
//   const MyProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Profile',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: HotelBookingColors.basictextcolor,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(17),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             // Profile Header
//             Center(
//               child: Column(
//                 children: [
//                   Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: HotelBookingColors.basictextcolor,
//                           width: 3,
//                         ),
//                       ),
//                       child: BlocBuilder<AuthBloc, Authstate>(
//                         builder: (context, state) {
//                           if (state is AuthAuthenticated) {
//                             final user = state.user;
//                             return Column(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 55,
//                                   backgroundColor: Colors.grey[200],
//                                   backgroundImage: user.photoURL != null
//                                       ? NetworkImage(user.photoURL!)
//                                       : null,
//                                   child: user.photoURL == null
//                                       ? const Icon(Icons.person,
//                                           size: 65, color: Colors.grey)
//                                       : null,
//                                 ),
//                                 Text(user.displayName ?? 'No Name'),
//                                 Text(user.email ?? 'No Email'),
//                                 // Text(
//                                 //   user.email!,
//                                 //   style: TextStyle(color: Colors.green),
//                                 // ),
//                                 // Text(
//                                 //   user.displayName!,
//                                 //   style: TextStyle(color: Colors.green),
//                                 // ),
//                                 // Text(user.phoneNumber!),
//                                 // Text(user.email!),
//                               ],
//                             );
//                           }
//                           return CircleAvatar(
//                             radius: 55,
//                             backgroundColor: Colors.grey[200],
//                             child: Icon(Icons.person,
//                                 size: 65, color: Colors.grey),
//                           );
//                         },
//                       )

//                       // child: CircleAvatar(
//                       //   radius: 55,
//                       //   backgroundColor: Colors.grey[200],
//                       //   child: const Icon(
//                       //     Icons.person,
//                       //     size: 65,
//                       //     color: Colors.grey,
//                       //   ),
//                       // ),
//                       ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'John Doe',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   // const Text(
//                   //   'john.doe@example.com',
//                   //   style: TextStyle(
//                   //     fontSize: 16,
//                   //     color: Colors.grey,
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 30),
//             // Profile Details Card
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Card(
//                 color: Colors.white,
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Personal Information',
//                         style:
//                             Theme.of(context).textTheme.titleMedium?.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                       ),
//                       const Divider(height: 32),
//                       const BookDetailInfoRow(
//                         icon: Icons.phone_android,
//                         label: 'Phone Number',
//                         value: '+1 234 567 890',
//                         color: Colors.blue,
//                       ),
//                       const SizedBox(height: 20),
//                       const BookDetailInfoRow(
//                         icon: Icons.location_on_outlined,
//                         label: 'Location',
//                         value: 'New York, USA',
//                         color: Colors.green,
//                       ),
//                       const SizedBox(height: 20),
//                       const BookDetailInfoRow(
//                         icon: Icons.calendar_today,
//                         label: 'Member Since',
//                         value: 'January 2024',
//                         color: Colors.purple,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),
//             // Actions Card
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Card(
//                 color: Colors.white,
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Column(
//                   children: [
//                     ListTile(
//                       leading: const Icon(Icons.edit, color: Colors.blue),
//                       title: const Text('Edit Profile'),
//                       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                       onTap: () {
//                         // Handle edit profile
//                       },
//                     ),
//                     const Divider(height: 1),
//                     ListTile(
//                       leading: const Icon(Icons.security, color: Colors.green),
//                       title: const Text('Privacy Settings'),
//                       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                       onTap: () {
//                         // Handle privacy settings
//                       },
//                     ),
//                     const Divider(height: 1),
//                     ListTile(
//                       leading:
//                           const Icon(Icons.help_outline, color: Colors.purple),
//                       title: const Text('Help & Support'),
//                       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                       onTap: () {
//                         // Handle help & support
//                       },
//                     ),
//                     const Divider(height: 1),
//                     ListTile(
//                       leading: const Icon(Icons.logout, color: Colors.red),
//                       title: const Text('Logout'),
//                       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return CustomAlertDialog(
//                               titleText: 'Logout',
//                               contentText: 'Are you sure you want to logout?',
//                               buttonText1: 'Cancel',
//                               buttonText2: 'Logout',
//                               onPressButton1: () {
//                                 Navigator.of(context).pop();
//                               },
//                               onPressButton2: () {
//                                 Navigator.of(context).pop();
//                                 context.read<AuthBloc>().add(SignOutEvent());
//                                 Navigator.of(context).pushReplacement(
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         const AuthSelectionPage(),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BookDetailInfoRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//   final Color color;

//   const BookDetailInfoRow({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.value,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, color: color, size: 24),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:hotel_booking/core/constants/colors.dart';
// // import 'package:hotel_booking/features/auth/presentation/pages/routepage.dart';
// // import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
// // import 'package:hotel_booking/utils/alertbox.dart';

// // class MyProfile extends StatelessWidget {
// //   const MyProfile({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           'Profile',
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontSize: 22,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //         centerTitle: true,
// //         backgroundColor: HotelBookingColors.basictextcolor,
// //         elevation: 0,
// //         iconTheme: const IconThemeData(color: Colors.white),
// //         shape: const RoundedRectangleBorder(
// //           borderRadius: BorderRadius.vertical(
// //             bottom: Radius.circular(17),
// //           ),
// //         ),
// //         actions: [
// //           InkWell(
// //             onTap: () {
// //               showDialog(
// //                 context: context,
// //                 builder: (BuildContext context) {
// //                   return CustomAlertDialog(
// //                     titleText: 'Delete',
// //                     contentText: 'Are you sure you want to logout?',
// //                     buttonText1: 'Cancel',
// //                     buttonText2: 'Logout',
// //                     onPressButton1: () {
// //                       Navigator.of(context).pop();
// //                     },
// //                     onPressButton2: () {
// //                       Navigator.of(context).pop();
// //                       context.read<AuthBloc>().add(SignOutEvent());
// //                       Navigator.of(context).pushReplacement(
// //                         MaterialPageRoute(
// //                           builder: (context) => const AuthSelectionPage(),
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 },
// //               );
// //             },
// //             child: const Icon(
// //               Icons.logout,
// //               color: Colors.white,
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Card(
// //           color: Colors.white,
// //           elevation: 2,
// //           shape:
// //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //           child: Padding(
// //             padding: const EdgeInsets.all(20),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   ' Details',
// //                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                 ),
// //                 const Divider(height: 32),
// //                 const BookDetailInfoRow(
// //                   icon: Icons.people_alt_outlined,
// //                   label: 'Number of Childs',
// //                   value: 'Number',
// //                   color: Colors.orange,
// //                 ),
// //                 const SizedBox(height: 20),
// //                 const BookDetailInfoRow(
// //                   icon: Icons.people_alt_outlined,
// //                   label: 'Number of Childs',
// //                   value: 'Number',
// //                   color: Colors.orange,
// //                 ),
// //                 const Divider(height: 32),
// //                 const BookDetailInfoRow(
// //                   icon: Icons.people_alt_outlined,
// //                   label: 'Number of Childs',
// //                   value: 'Number',
// //                   color: Colors.orange,
// //                 ),
// //                 const SizedBox(height: 32),
// //                 const BookDetailInfoRow(
// //                   icon: Icons.people_alt_outlined,
// //                   label: 'Number of Childs',
// //                   value: 'Number',
// //                   color: Colors.orange,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // import 'package:flutter/material.dart';
//      // const SizedBox(height: 20),
//             // // Booking Statistics Card
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: 16),
//             //   child: Card(
//             //     elevation: 2,
//             //     shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(16),
//             //     ),
//             //     child: Padding(
//             //       padding: const EdgeInsets.all(20),
//             //       child: Column(
//             //         crossAxisAlignment: CrossAxisAlignment.start,
//             //         children: [
//             //           Text(
//             //             'Booking Statistics',
//             //             style:
//             //                 Theme.of(context).textTheme.titleMedium?.copyWith(
//             //                       fontWeight: FontWeight.bold,
//             //                     ),
//             //           ),
//             //           const Divider(height: 32),
//             //           const BookDetailInfoRow(
//             //             icon: Icons.hotel,
//             //             label: 'Total Bookings',
//             //             value: '12 Hotels',
//             //             color: Colors.orange,
//             //           ),
//             //           const SizedBox(height: 20),
//             //           const BookDetailInfoRow(
//             //             icon: Icons.star,
//             //             label: 'Average Rating',
//             //             value: '4.8/5',
//             //             color: Colors.amber,
//             //           ),
//             //         ],
//             //       ),
//             //     ),
//             //   ),
//             // ),
//                // actions: [
//         //   InkWell(
//         //     onTap: () {
//         //       showDialog(
//         //         context: context,
//         //         builder: (BuildContext context) {
//         //           return CustomAlertDialog(
//         //             titleText: 'Logout',
//         //             contentText: 'Are you sure you want to logout?',
//         //             buttonText1: 'Cancel',
//         //             buttonText2: 'Logout',
//         //             onPressButton1: () {
//         //               Navigator.of(context).pop();
//         //             },
//         //             onPressButton2: () {
//         //               Navigator.of(context).pop();
//         //               context.read<AuthBloc>().add(SignOutEvent());
//         //               Navigator.of(context).pushReplacement(
//         //                 MaterialPageRoute(
//         //                   builder: (context) => const AuthSelectionPage(),
//         //                 ),
//         //               );
//         //             },
//         //           );
//         //         },
//         //       );
//         //     },
//         //     child: const Padding(
//         //       padding: EdgeInsets.only(right: 16),
//         //       child: Icon(
//         //         Icons.logout,
//         //         color: Colors.white,
//         //       ),
//         //     ),
//         //   ),
//         // ],