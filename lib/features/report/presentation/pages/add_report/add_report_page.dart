import 'package:flutter/material.dart';
import 'package:hotel_booking/features/report/presentation/pages/add_report/reports.dart';
import 'package:hotel_booking/features/report/presentation/pages/reports/repor.dart';
import 'package:hotel_booking/utils/custom_appbar/custom_appbar.dart';

class ReportIssuePage extends StatelessWidget {
  const ReportIssuePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> predefinedIssues = [
      {
        "title": "Room cleanliness issue",
        "icon": Icons.cleaning_services,
        "color": Colors.blue[700]
      },
      {
        "title": "Faulty air conditioner",
        "icon": Icons.ac_unit,
        "color": Colors.cyan[700]
      },
      {
        "title": "Unresponsive hotel staff",
        "icon": Icons.person_outline,
        "color": Colors.orange[700]
      },
      {
        "title": "Incorrect booking details",
        "icon": Icons.book_outlined,
        "color": Colors.purple[700]
      },
      {
        "title": "Noisy environment",
        "icon": Icons.volume_up,
        "color": Colors.red[700]
      },
      {
        "title": "Wi-Fi not working",
        "icon": Icons.wifi_off,
        "color": Colors.green[700]
      },
      {
        "title": "Overcharging issues",
        "icon": Icons.money_off,
        "color": Colors.amber[700]
      },
      {
        "title": "Uncomfortable bed",
        "icon": Icons.bed,
        "color": Colors.indigo[700]
      },
      {
        "title": "Hygiene issue",
        "icon": Icons.sanitizer,
        "color": Colors.teal[700]
      },
    ];

    return Scaffold(
      appBar: const BookingAppbar(
        heading: 'Report an Issue',
        // appbaractions: [
        //   // IconButton(
        //   //   icon: const Icon(Icons.history),
        //   //   onPressed: () {
        //   //     Navigator.of(context).push(MaterialPageRoute(
        //   //       builder: (context) => const ReportedIssuesPage(),
        //   //     ));
        //   //   },
        //   // ),
        // ],
      ),
      body: ReportListPage(predefinedIssues: predefinedIssues),
    );
  }
}
