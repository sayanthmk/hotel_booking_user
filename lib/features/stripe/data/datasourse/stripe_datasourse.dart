import 'package:dio/dio.dart';
import 'package:hotel_booking/core/constants/stripe_keys.dart';
import 'package:hotel_booking/features/stripe/data/model/stripe_model.dart';

abstract class StripeRemoteDataSource {
  Future<PaymentIntentModel> createPaymentIntent({
    required int amount,
    required String currency,
  });
}

class StripeRemoteDataSourceImpl implements StripeRemoteDataSource {
  final Dio dio;

  StripeRemoteDataSourceImpl({required this.dio});

  @override
  Future<PaymentIntentModel> createPaymentIntent({
    required int amount,
    required String currency,
  }) async {
    try {
      final response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: {
          "amount": amount.toString(),
          "currency": currency,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return PaymentIntentModel.fromJson(response.data);
      }
      throw Exception('Failed to create payment intent');
    } catch (e) {
      rethrow;
    }
  }
}



// const String stripePublishableKey =
//     "pk_test_51Q67rZRvOo5scIqu2fwvkrkZxPPoToGtKJf6eq3GyTNIfdCXM06Wa7OHXR1HUkJP7ij8douLXzVUht7xsFAKzIvE00a0kLCb9Y";
// const String stripeSecretKey =
//     "sk_test_51Q67rZRvOo5scIquMcZaJ5Iqh6BfVh20cXhNcseuc1E7rGEw0yPfxORgoyyYPBAl4S52Ne9tugdLRfnL6jG4E8MB00D8soBPN2";
