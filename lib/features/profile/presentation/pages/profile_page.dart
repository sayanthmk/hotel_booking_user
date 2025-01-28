// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/core/dependency_injection/injection_container.dart';
// import 'package:hotel_booking/features/chatbot/chat_bot.dart';
// import 'package:hotel_booking/features/profile/domain/usecase/profile_usecase.dart';
// import 'package:hotel_booking/features/profile/presentation/pages/profile_detail/edit_profile_page.dart';
// import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_bloc.dart';
// import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_event.dart';
// import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_state.dart';

// class UserProfileListPage extends StatelessWidget {
//   const UserProfileListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (context) => UserProfileBloc(
//           sl<FetchUsers>(),
//           sl<UpdateCurrentUser>(),
//           sl<UploadProfileImageUser>(),
//         )..add(LoadUsers()),
//         child: BlocBuilder<UserProfileBloc, UserProfileState>(
//           builder: (context, state) {
//             if (state is UserLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is UserLoaded) {
//               final user = state.user;
//               return CustomScrollView(
//                 slivers: [
//                   // Custom App Bar with profile image background
//                   SliverAppBar(
//                     expandedHeight: 300,
//                     floating: false,
//                     pinned: true,
//                     flexibleSpace: FlexibleSpaceBar(
//                       background: Stack(
//                         fit: StackFit.expand,
//                         children: [
//                           // Profile Image
//                           Image.network(
//                             user.profileImage,
//                             fit: BoxFit.cover,
//                           ),
//                           // Gradient overlay
//                           Container(
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   Colors.transparent,
//                                   Colors.black.withOpacity(0.7),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       title: Text(
//                         user.name,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     actions: [
//                       IconButton(
//                         icon: const Icon(Icons.chat, color: Colors.white),
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const HotelBookingChat(),
//                           ));
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.edit, color: Colors.white),
//                         onPressed: () => showDialog(
//                           context: context,
//                           builder: (context) => const EditUserProfile(),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Profile Information
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildInfoCard(
//                             context,
//                             [
//                               _buildInfoRow(Icons.email, 'Email', user.email),
//                               _buildInfoRow(
//                                   Icons.location_on, 'Location', user.location),
//                               _buildInfoRow(
//                                 Icons.calendar_today,
//                                 'Member Since',
//                                 _formatDate(user.createdAt.toDate()),
//                               ),
//                               _buildInfoRow(
//                                   Icons.fingerprint, 'User ID', user.id),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             } else if (state is UserError) {
//               return Center(child: Text(state.message));
//             }
//             return const Center(child: Text('No data found'));
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(BuildContext context, List<Widget> children) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: children,
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(icon, size: 24, color: Colors.blue),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }
