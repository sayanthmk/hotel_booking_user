import 'dart:developer';

import 'package:hotel_booking/features/rooms/domain/entity/rooms_entity.dart';

class RoomModel extends RoomEntity {
  RoomModel({
    required super.roomArea,
    required super.roomType,
    required super.propertySize,
    required super.extraBedType,
    required super.cupboard,
    required super.wardrobe,
    required super.freeBreakfast,
    required super.freeLunch,
    required super.freeDinner,
    required super.basePrice,
    required super.extraAdultsAllowed,
    required super.extraChildrenAllowed,
    required super.laundry,
    required super.elevator,
    required super.airConditioner,
    required super.houseKeeping,
    required super.kitchen,
    required super.wifi,
    required super.parking,
    required super.images,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    log('model');
    return RoomModel(
      roomArea: json['room_area'] ?? '',
      roomType: json['room_type'] ?? '',
      propertySize: json['Property Size'] ?? 0,
      extraBedType: json['Select Extra Bed Types'] ?? 0,
      cupboard: json['Cupboard'] ?? false,
      wardrobe: json['Wardrobe'] ?? false,
      freeBreakfast: json['Free Breakfast'] ?? false,
      freeLunch: json['Free Lunch'] ?? false,
      freeDinner: json['Free Dinner'] ?? false,
      basePrice: json['Base Price'] ?? 0,
      extraAdultsAllowed: json['Number of Extra Adults Allowed'] ?? 0,
      extraChildrenAllowed: json['Number of Extra Child Allowed'] ?? 0,
      laundry: json['Laundry'] ?? false,
      elevator: json['Elevator'] ?? false,
      airConditioner: json['Air Conditioner'] ?? false,
      houseKeeping: json['House Keeping'] ?? false,
      kitchen: json['Kitchen'] ?? false,
      wifi: json['Wifi'] ?? false,
      parking: json['Parking'] ?? false,
      images: List<String>.from(json['room_images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'room_area': roomArea,
      'room_type': roomType,
      'Property Size': propertySize,
      'Select Extra Bed Types': extraBedType,
      'Cupboard': cupboard,
      'Wardrobe': wardrobe,
      'Free Breakfast': freeBreakfast,
      'Free Lunch': freeLunch,
      'Free Dinner': freeDinner,
      'Base Price': basePrice,
      'Number of Extra Adults Allowed': extraAdultsAllowed,
      'Number of Extra Child Allowed': extraChildrenAllowed,
      'Laundry': laundry,
      'Elevator': elevator,
      'Air Conditioner': airConditioner,
      'House Keeping': houseKeeping,
      'Kitchen': kitchen,
      'Wifi': wifi,
      'Parking': parking,
      'room_images': images,
    };
  }
}
