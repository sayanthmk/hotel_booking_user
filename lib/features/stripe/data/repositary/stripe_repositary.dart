// import 'dart:developer';

import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/stripe/data/datasourse/stripe_datasourse.dart';
import 'package:hotel_booking/features/stripe/data/model/stripe_model.dart';
import 'package:hotel_booking/features/stripe/domain/entity/stripe_entity.dart';
import 'package:hotel_booking/features/stripe/domain/repos/stripe_repos.dart';

class StripePaymentRepositoryImpl implements StripePaymentRepository {
  final StripeRemoteDataSource remoteDataSource;

  StripePaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PaymentIntentEntity> createPaymentIntent({
    required int amount,
    required String currency,
  }) async {
    final PaymentIntentModel paymentIntent =
        await remoteDataSource.createPaymentIntent(
      amount: amount,
      currency: currency,
    );
    return paymentIntent.toEntity();
  }

  @override
  Future<void> processPayment(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Sayanth",
      ),
    );

    await Stripe.instance.presentPaymentSheet();
    await Stripe.instance.confirmPaymentSheetPayment();
  }

  // @override
  // Future<void> updatePaymentAmount({
  //   required String hotelId,
  //   required UserDataModel bookingData,
  //   required double amount,
  // }) async {
  //   log('StripePaymentRepositoryImpl implements StripePaymentRepository');
  //   await remoteDataSource.updatePaymentAmount(
  //     hotelId: hotelId,
  //     bookingData: bookingData,
  //     amount: amount,
  //   );
  // }
}
