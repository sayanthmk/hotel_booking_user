// import 'package:equatable/equatable.dart';

// abstract class StripePaymentState extends Equatable {
//   const StripePaymentState();

//   @override
//   List<Object> get props => [];
// }

// class StripePaymentInitial extends StripePaymentState {
//   final String amount;
//   final String? errorMessage;

//   const StripePaymentInitial({
//     this.amount = '',
//     this.errorMessage,
//   });

//   StripePaymentInitial copyWith({
//     String? amount,
//     String? errorMessage,
//   }) {
//     return StripePaymentInitial(
//       amount: amount ?? this.amount,
//       errorMessage: errorMessage,
//     );
//   }

//   @override
//   List<Object> get props => [
//         amount,
//       ];
// }

// class StripePaymentLoading extends StripePaymentState {}

// class StripePaymentSuccess extends StripePaymentState {}

// class StripePaymentFailure extends StripePaymentState {
//   final String error;

//   const StripePaymentFailure({required this.error});

//   @override
//   List<Object> get props => [error];
// }
import 'package:equatable/equatable.dart';

abstract class StripePaymentState extends Equatable {
  const StripePaymentState();

  @override
  List<Object?> get props => [];
}

class StripePaymentInitial extends StripePaymentState {
  final String? amount;
  final String? errorMessage;

  const StripePaymentInitial({
    this.amount,
    this.errorMessage,
  });

  StripePaymentInitial copyWith({
    String? amount,
    String? errorMessage,
  }) {
    return StripePaymentInitial(
      amount: amount ?? this.amount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [amount, errorMessage];
}

class StripePaymentLoading extends StripePaymentState {}

class StripePaymentSuccess extends StripePaymentState {}

class StripePaymentAmountUpdated extends StripePaymentState {}

class StripePaymentFailure extends StripePaymentState {
  final String error;

  const StripePaymentFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
