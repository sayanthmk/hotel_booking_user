import 'package:hotel_booking/features/stripe/domain/entity/stripe_entity.dart';

abstract class StripePaymentRepository {
  Future<PaymentIntentEntity> createPaymentIntent({
    required int amount,
    required String currency,
  });

  Future<void> processPayment(String clientSecret);
}
