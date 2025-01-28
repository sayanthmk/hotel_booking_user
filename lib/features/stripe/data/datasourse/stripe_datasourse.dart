import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:hotel_booking/core/constants/stripe_api_key.dart';
import 'package:hotel_booking/features/stripe/data/model/stripe_model.dart';

abstract class StripeRemoteDataSource {
  Future<PaymentIntentModel> createPaymentIntent({
    required int amount,
    required String currency,
  });
}

class StripeRemoteDataSourceImpl implements StripeRemoteDataSource {
  final Dio dio;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  StripeRemoteDataSourceImpl({required this.dio, required this.firestore});

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
      log(response.statusCode.toString());
      if (response.statusCode == 200 && response.data != null) {
        return PaymentIntentModel.fromJson(response.data);
      }
      throw Exception('Failed to create payment intent');
    } catch (e) {
      rethrow;
    }
  }
}
