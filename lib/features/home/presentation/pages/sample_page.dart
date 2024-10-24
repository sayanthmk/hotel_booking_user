// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class HotelListPageMapUsing extends StatefulWidget {
//   const HotelListPageMapUsing({super.key});

//   @override
//   HotelDetailsReviewingPageState createState() =>
//       HotelDetailsReviewingPageState();
// }

// class HotelDetailsReviewingPageState extends State<HotelListPageMapUsing> {
//   List<Map<String, dynamic>> hotelsList = [];

//   // Fetch all hotel data from Firestore
//   Future<void> fetchHotels() async {
//     try {
//       log('fetch called');
//       // Query the Firestore collection 'hotels' to get all documents
//       QuerySnapshot querySnapshot =
//           await FirebaseFirestore.instance.collection('hotels').get();

//       setState(() {
//         log('setState called');
//         // Map Firestore documents to a list of maps
//         hotelsList = querySnapshot.docs
//             .map((doc) => {
//                   'id': doc.id, // include the document ID
//                   ...doc.data()
//                       as Map<String, dynamic>, // include the rest of the data
//                 })
//             .toList();

//         // Log the data for debugging
//         log('Hotels List: ${hotelsList.map((hotel) => hotel.toString()).toList()}');
//       });
//     } catch (e) {
//       log("Error fetching hotel data: $e");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Fetch hotel data on initialization
//     fetchHotels();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Hotel List"),
//       ),
//       body: hotelsList.isNotEmpty
//           ? ListView.builder(
//               itemCount: hotelsList.length,
//               itemBuilder: (context, index) {
//                 // Extract data from each hotel document
//                 Map<String, dynamic> hotel = hotelsList[index];

//                 // Log the hotel data for debugging
//                 log('Hotel at index $index: ${hotel.toString()}\n');

//                 return ListTile(
//                   title: Text("${hotel['hotel_name'] ?? 'Unnamed Hotel'}"),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                           "Type: ${hotel['hotel details']['hotel_type'] ?? 'N/A'}"),
//                       Text("City: ${hotel['hotel details']['city'] ?? 'N/A'}"),
//                       Text(
//                           "Contact: ${hotel['hotel details']['contact number'] ?? 'N/A'}"),
//                       Text(
//                           "Email: ${hotel['hotel details']['email address'] ?? 'N/A'}"),
//                     ],
//                   ),
//                   onTap: () {
//                     // Handle navigation or actions when tapping the item
//                     // log("Tapped on hotel: ${hotel['hotel_name']}");
//                   },
//                 );
//               },
//             )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }
