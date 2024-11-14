class RoomEntity {
  final String roomArea;
  final String roomType;
  final int propertySize;
  final int extraBedType;
  final bool cupboard;
  final bool wardrobe;
  final bool freeBreakfast;
  final bool freeLunch;
  final bool freeDinner;
  final int basePrice;
  final int extraAdultsAllowed;
  final int extraChildrenAllowed;
  final bool laundry;
  final bool elevator;
  final bool airConditioner;
  final bool houseKeeping;
  final bool kitchen;
  final bool wifi;
  final bool parking;
  final List<String> images;

  RoomEntity({
    required this.roomArea,
    required this.roomType,
    required this.propertySize,
    required this.extraBedType,
    required this.cupboard,
    required this.wardrobe,
    required this.freeBreakfast,
    required this.freeLunch,
    required this.freeDinner,
    required this.basePrice,
    required this.extraAdultsAllowed,
    required this.extraChildrenAllowed,
    required this.laundry,
    required this.elevator,
    required this.airConditioner,
    required this.houseKeeping,
    required this.kitchen,
    required this.wifi,
    required this.parking,
    required this.images,
  });
}
