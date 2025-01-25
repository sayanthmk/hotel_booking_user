import 'package:flutter/material.dart';
import 'package:hotel_booking/features/report/presentation/pages/add_report_page.dart';
import 'package:hotel_booking/features/review/presentation/pages/rev_new.dart';

class ReviewReportPage extends StatelessWidget {
  final String hotelId;
  const ReviewReportPage({
    super.key,
    required this.hotelId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Details',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ReviewPage(),
                      ));
                    },
                    child: const Text(
                      'Reviews',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ReportIssuePage(),
                      ));
                    },
                    child: const Text(
                      'Report',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ),
              Card(
                child: TextButton(
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => HotelReviewPage(),
                      // ));
                    },
                    child: const Text(
                      'Contact',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
