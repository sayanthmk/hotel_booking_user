part of 'stripepayment_bloc.dart';

abstract class StripePaymentEvent {
  const StripePaymentEvent();
}

class MakePayment extends StripePaymentEvent {
  final double amount;
  const MakePayment({required this.amount});
}

class UpdateAmount extends StripePaymentEvent {
  final String amount;
  const UpdateAmount({required this.amount});
}
