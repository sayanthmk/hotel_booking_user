import 'dart:developer';

import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
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

class UpdatePaymentAmountUseCase {
  final StripePaymentRepository repository;

  UpdatePaymentAmountUseCase(this.repository);

  Future<void> call({
    required String hotelId,
    required UserDataModel bookingData,
    required double amount,
  }) async {
    log('UpdatePaymentAmountUseCase');
    await repository.updatePaymentAmount(
      hotelId: hotelId,
      bookingData: bookingData,
      amount: amount,
    );
  }
}
