import 'package:equatable/equatable.dart';

abstract class StripePaymentEvent extends Equatable {
  const StripePaymentEvent();

  @override
  List<Object> get props => [];
}

class UpdatePaymentAmount extends StripePaymentEvent {
  final String amount;

  const UpdatePaymentAmount(this.amount);

  @override
  List<Object> get props => [amount];
}

class InitiatePayment extends StripePaymentEvent {
  final double amount;

  const InitiatePayment(this.amount);

  @override
  List<Object> get props => [amount];
}
