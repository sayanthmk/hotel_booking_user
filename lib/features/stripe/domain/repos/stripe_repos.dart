// import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/stripe/domain/entity/stripe_entity.dart';

abstract class StripePaymentRepository {
  Future<PaymentIntentEntity> createPaymentIntent({
    required int amount,
    required String currency,
  });

  Future<void> processPayment(String clientSecret);

  // Future<void> updatePaymentAmount({
  //   required String hotelId,
  //   required UserDataModel bookingData,
  //   required double amount,
  // });
}
