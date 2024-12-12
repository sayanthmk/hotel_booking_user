class PaymentIntentEntity {
  final String clientSecret;
  final int amount;
  final String currency;

  const PaymentIntentEntity({
    required this.clientSecret,
    required this.amount,
    required this.currency,
  });
}
