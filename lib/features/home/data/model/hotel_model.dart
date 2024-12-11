import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';

class HotelModel extends HotelEntity {
  HotelModel({
    required super.hotelId,
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
    // log('model');
    return HotelModel(
      hotelId: json['userId'] ?? '',
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
      "userId": hotelId,
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
