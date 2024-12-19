// import 'package:equatable/equatable.dart';
// import 'package:hotel_booking/features/booking/data/model/booking_model.dart';

// abstract class StripePaymentEvent extends Equatable {
//   const StripePaymentEvent();

//   @override
//   List<Object> get props => [];
// }

// class UpdatePaymentAmount extends StripePaymentEvent {
//   final String amount;

//   const UpdatePaymentAmount(this.amount);

//   @override
//   List<Object> get props => [amount];
// }

// class InitiatePayment extends StripePaymentEvent {
//   final double amount;
//   final UserDataModel? bookingData;
//   final String? hotelId;

//    const InitiatePayment(
//     this.amount, {
//     this.bookingData,
//     this.hotelId,
//   });

//   @override
//   List<Object> get props => [amount];
// }
import 'package:equatable/equatable.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';

abstract class StripePaymentEvent extends Equatable {
  const StripePaymentEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePaymentAmount extends StripePaymentEvent {
  final String hotelId;
  final UserDataModel bookingData;
  final double amount;

  const UpdatePaymentAmount({
    required this.hotelId,
    required this.bookingData,
    required this.amount,
  });

  @override
  List<Object?> get props => [hotelId, bookingData, amount];
}

class InitiatePayment extends StripePaymentEvent {
  final double amount;
  final UserDataModel? bookingData;
  final String? hotelId;

  const InitiatePayment({
    required this.amount,
    this.bookingData,
    this.hotelId,
  });

  @override
  List<Object?> get props => [amount, bookingData, hotelId];
}
