import 'dart:developer';

import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

class HotelModel extends HotelEntity {
  HotelModel({
    required super.hotelType,
    required super.propertySetup,
    required super.hotelName,
    required super.bookingSince,
    required super.contactNumber,
    required super.emailAddress,
    required super.city,
    required super.state,
    required super.country,
    required super.entireProperty,
    required super.privateProperty,
    required super.pincode,
    required super.freeCancel,
    required super.coupleFriendly,
    required super.parkingFacility,
    required super.restaurantFacility,
    required super.panNumber,
    required super.propertyNumber,
    required super.gstNumber,
    required super.leased,
    required super.registration,
    required super.documentImage,
    required super.images,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    log('model');
    return HotelModel(
      hotelType: json['hotel_type'] ?? '',
      propertySetup: json['property_setup'] ?? '',
      hotelName: json['hotel_name'] ?? '',
      bookingSince: json['Booking_since'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      emailAddress: json['email_address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      entireProperty: json['entire_property'] ?? false,
      privateProperty: json['private_property'] ?? false,
      pincode: json['pincode'] ?? 0,
      freeCancel: json['free_cancel'] ?? false,
      coupleFriendly: json['couple_friendly'] ?? false,
      parkingFacility: json['parking_facility'] ?? false,
      restaurantFacility: json['restaurant_facility'] ?? false,
      panNumber: json['pan_number'] ?? '',
      propertyNumber: json['property_number'] ?? '',
      gstNumber: json['gst_number'] ?? '',
      leased: json['leased'] ?? false,
      registration: json['registration'] ?? false,
      documentImage: json['document_image'] ?? false,
      images: List<String>.from(json['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hotel_type": hotelType,
      "property_setup": propertySetup,
      "hotel_name": hotelName,
      "Booking_since": bookingSince,
      "contact_number": contactNumber,
      "email_address": emailAddress,
      "city": city,
      "state": state,
      "country": country,
      "entire_property": entireProperty,
      "private_property": privateProperty,
      "pincode": pincode,
      "free_cancel": freeCancel,
      "couple_friendly": coupleFriendly,
      "parking_facility": parkingFacility,
      "restaurant_facility": restaurantFacility,
      "pan_number": panNumber,
      "property number": propertyNumber,
      "gst_number": gstNumber,
      "leased": leased,
      "registration": registration,
      "document_image": documentImage,
      "images": images,
    };
  }
}

















//////////////////////////////////////////////////////////////////////

// import 'dart:developer';

// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

// class HotelModel extends HotelEntity {
//   HotelModel({
//     required super.hotelType,
//     required super.propertySetup,
//     required super.hotelName,
//     required super.bookingSince,
//     required super.contactNumber,
//     required super.emailAddress,
//     required super.city,
//     required super.state,
//     required super.country,
//     required super.pincode,
//     required super.policy1,
//     required super.policy2,
//     required super.policy3,
//     required super.policy4,
//     required super.panNumber,
//     required super.propertyNumber,
//     required super.gstNumber,
//     required super.leased,
//     required super.registration,
//     required super.documentImage,
//     required super.images,
//   });

//   factory HotelModel.fromJson(Map<String, dynamic> json) {
//     log('model');
//     return HotelModel(
//       hotelType: json['hotel details']['hotel_type'] ?? '',
//       propertySetup: json['hotel details']['property_setup'] ?? '',
//       hotelName: json['hotel details']['hotel_name'] ?? '',
//       bookingSince: json['hotel details']['Booking_since'] ?? 0,
//       contactNumber: json['hotel details']['contact number'] ?? '',
//       emailAddress: json['hotel details']['email address'] ?? '',
//       city: json['hotel details']['city'] ?? '',
//       state: json['hotel details']['state'] ?? '',
//       country: json['hotel details']['country'] ?? '',
//       pincode: json['hotel details']['pincode'] ?? 0,
//       policy1: json['hotel details']['policy 1'] ?? false,
//       policy2: json['hotel details']['policy 2'] ?? false,
//       policy3: json['hotel details']['policy 3'] ?? false,
//       policy4: json['hotel details']['policy 4'] ?? false,
//       panNumber: json['hotel details']['pan number'] ?? '',
//       propertyNumber: json['hotel details']['property number'] ?? '',
//       gstNumber: json['hotel details']['GST number'] ?? '',
//       leased: json['hotel details']['leased'] ?? false,
//       registration: json['hotel details']['registration'] ?? false,
//       documentImage: json['hotel details']['document image'] ?? '',
//       images: List<String>.from(json['hotel details']['images'] ?? []),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "hotel details": {
//         "hotel_type": hotelType,
//         "property_setup": propertySetup,
//         "hotel_name": hotelName,
//         "Booking_since": bookingSince,
//         "contact number": contactNumber,
//         "email address": emailAddress,
//         "city": city,
//         "state": state,
//         "country": country,
//         "pincode": pincode,
//         "policy 1": policy1,
//         "policy 2": policy2,
//         "policy 3": policy3,
//         "policy 4": policy4,
//         "pan number": panNumber,
//         "property number": propertyNumber,
//         "GST number": gstNumber,
//         "leased": leased,
//         "registration": registration,
//         "document image": documentImage,
//         "images": images,
//       },
//     };
//   }
// }
    // 'hotel_type': '',
    // 'property_setup': '',
    // 'hotel_name': '',
    // 'Booking_since': '',
    // 'contact_number': '',
    // 'email_address': '',
    // 'city': '',
    // 'state': '',
    // 'country': '',
    // 'entire_property': false,
    // 'private_property': false,
    // 'pincode': null,
    // 'free_cancel': false,
    // 'couple_friendly': false,
    // 'parking_facility': false,
    // 'restaurant_facility': false,
    // 'pan_number': '',
    // 'property_number': '',
    // 'gst_number': '',
    // 'leased': false,
    // 'registration': false,
    // 'document_image': false,
    // 'images': [],