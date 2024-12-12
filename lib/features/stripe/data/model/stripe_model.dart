import 'package:hotel_booking/features/stripe/domain/entity/stripe_entity.dart';

class PaymentIntentModel {
  final String clientSecret;
  final int amount;
  final String currency;
  final String id;
  final String status;

  const PaymentIntentModel({
    required this.clientSecret,
    required this.amount,
    required this.currency,
    required this.id,
    required this.status,
  });
  PaymentIntentEntity toEntity() {
    return PaymentIntentEntity(
      clientSecret: clientSecret,
      amount: amount,
      currency: currency,
    );
  }

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentModel(
      clientSecret: json['client_secret'] as String,
      amount: json['amount'] as int,
      currency: json['currency'] as String,
      id: json['id'] as String,
      status: json['status'] as String,
    );
  }
}
