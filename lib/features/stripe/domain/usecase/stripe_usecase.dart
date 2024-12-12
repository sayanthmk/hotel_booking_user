import 'package:hotel_booking/features/stripe/domain/entity/stripe_entity.dart';
import 'package:hotel_booking/features/stripe/domain/repos/stripe_repos.dart';

class CreatePaymentIntentUseCase {
  final StripePaymentRepository repository;

  CreatePaymentIntentUseCase(this.repository);

  Future<PaymentIntentEntity> call({
    required int amount,
    required String currency,
  }) async {
    return await repository.createPaymentIntent(
      amount: amount,
      currency: currency,
    );
  }
}
