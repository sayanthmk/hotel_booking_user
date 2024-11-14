part of 'stripepayment_bloc.dart';

abstract class StripePaymentState {
  const StripePaymentState();
}

class StripePaymentInitial extends StripePaymentState {
  final String amount;
  final String? errorMessage;

  const StripePaymentInitial({
    this.amount = '',
    this.errorMessage,
  });

  StripePaymentInitial copyWith({
    String? amount,
    String? errorMessage,
  }) {
    return StripePaymentInitial(
      amount: amount ?? this.amount,
      errorMessage: errorMessage,
    );
  }
}

class StripePaymentLoading extends StripePaymentState {}

class StripePaymentSuccess extends StripePaymentState {}

class StripePaymentFailure extends StripePaymentState {
  final String error;
  const StripePaymentFailure({required this.error});
}
