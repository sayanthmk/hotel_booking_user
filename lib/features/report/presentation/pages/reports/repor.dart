// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
// import 'package:hotel_booking/features/report/presentation/providers/bloc/report_bloc.dart';
// import 'package:hotel_booking/features/report/presentation/providers/bloc/report_event.dart';
// import 'package:hotel_booking/features/report/presentation/providers/bloc/report_state.dart';

// class ReportedIssuesPage extends StatelessWidget {
//   const ReportedIssuesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Reported Issues'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               final hotelId = (context.read<SelectedHotelBloc>().state
//                       as SelectedHotelLoaded)
//                   .hotel
//                   .hotelId;
//               context
//                   .read<ReportIssueBloc>()
//                   .add(FetchReportedIssuesEvent(hotelId: hotelId));
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<ReportIssueBloc, ReportIssueState>(
//         builder: (context, state) {
//           if (state is GetReportedIssuesLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is GetReportedIssuesError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(state.errorMessage),
//                   ElevatedButton(
//                     onPressed: () {
//                       final hotelId = (context.read<SelectedHotelBloc>().state
//                               as SelectedHotelLoaded)
//                           .hotel
//                           .hotelId;
//                       context
//                           .read<ReportIssueBloc>()
//                           .add(FetchReportedIssuesEvent(hotelId: hotelId));
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (state is GetReportedIssuesLoaded) {
//             if (state.issues.isEmpty) {
//               return const Center(
//                 child:
//                     Text('No issues reported', style: TextStyle(fontSize: 18)),
//               );
//             }

//             return ListView.builder(
//               itemCount: state.issues.length,
//               itemBuilder: (context, index) {
//                 final issue = state.issues[index];
//                 return Dismissible(
//                   key: Key(issue.id ?? ''),
//                   background: Container(
//                     color: Colors.red,
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.only(right: 20),
//                     child: const Icon(Icons.delete, color: Colors.white),
//                   ),
//                   direction: DismissDirection.endToStart,
//                   confirmDismiss: (direction) async {
//                     return await showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Confirm Delete'),
//                         content: const Text(
//                             'Are you sure you want to delete this issue report?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(false),
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(true),
//                             child: const Text('Delete'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   onDismissed: (direction) {
//                     final hotelId = (context.read<SelectedHotelBloc>().state
//                             as SelectedHotelLoaded)
//                         .hotel
//                         .hotelId;
//                     context.read<ReportIssueBloc>().add(
//                           DeleteReportedIssueEvent(
//                             issueId: issue.id!,
//                             hotelId: hotelId,
//                           ),
//                         );
//                   },
//                   child: Card(
//                     margin:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     child: ListTile(
//                       title: Column(
//                         children: [
//                           Text(
//                             issue.id ?? 'No details provided',
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             issue.issueContent ?? 'No details provided',
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             issue.issueDate.toString() ,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             issue.userEmail ?? 'No details provided',
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             issue.hotelId ?? 'No details provided',
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
                   
//                       trailing:
//                           const Icon(Icons.delete_sweep, color: Colors.red),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }

//           return const Center(child: Text('No data available'));
//         },
//       ),
//     );
//   }
// }

