import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_booking/features/stripe/domain/usecase/stripe_usecase.dart';
import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_event.dart';
import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_state.dart';

class StripeBloc extends Bloc<StripePaymentEvent, StripePaymentState> {
  final CreatePaymentIntentUseCase createPaymentIntentUseCase;

  StripeBloc({
    required this.createPaymentIntentUseCase,
  }) : super(const StripePaymentInitial()) {
    on<UpdatePaymentAmount>(_onUpdatePaymentAmount);
    on<InitiatePayment>(_onInitiatePayment);
  }

  void _onUpdatePaymentAmount(
    UpdatePaymentAmount event,
    Emitter<StripePaymentState> emit,
  ) {
    if (state is StripePaymentInitial) {
      final currentState = state as StripePaymentInitial;

      String? errorMessage;
      if (event.amount.isNotEmpty) {
        try {
          final amount = double.parse(event.amount);
          if (amount <= 0) {
            errorMessage = 'Amount must be greater than 0';
          }
        } catch (_) {
          errorMessage = 'Please enter a valid number';
        }
      }

      emit(currentState.copyWith(
        amount: event.amount,
        errorMessage: errorMessage,
      ));
    }
  }

  Future<void> _onInitiatePayment(
    InitiatePayment event,
    Emitter<StripePaymentState> emit,
  ) async {
    emit(StripePaymentLoading());

    try {
      // Convert amount to cents
      final amountInCents = (event.amount * 100).round();

      // Create Payment Intent
      final paymentIntent = await createPaymentIntentUseCase(
        amount: amountInCents,
        currency: 'usd',
      );

      // Process Payment
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent.clientSecret,
          merchantDisplayName: "Your App Name",
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();

      emit(StripePaymentSuccess());
    } catch (e) {
      emit(StripePaymentFailure(error: e.toString()));
    }
  }
}


// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:hotel_booking/core/constants/stripe_keys.dart';
// import 'package:hotel_booking/features/stripe/data/datasourse/consts.dart';

// part 'stripepayment_event.dart';
// part 'stripepayment_state.dart';

// class StripePaymentBloc extends Bloc<StripePaymentEvent, StripePaymentState> {
//   final Dio _dio = Dio();

//   StripePaymentBloc() : super(const StripePaymentInitial()) {
//     on<MakePayment>(_handleMakePayment);
//     on<UpdateAmount>(_handleUpdateAmount);
//   }

//   Future<void> _handleUpdateAmount(
//     UpdateAmount event,
//     Emitter<StripePaymentState> emit,
//   ) async {
//     if (state is StripePaymentInitial) {
//       final currentState = state as StripePaymentInitial;

//       // Validate amount
//       String? errorMessage;
//       if (event.amount.isNotEmpty) {
//         try {
//           final amount = double.parse(event.amount);
//           if (amount <= 0) {
//             errorMessage = 'Amount must be greater than 0';
//           }
//         } catch (_) {
//           errorMessage = 'Please enter a valid number';
//         }
//       }

//       emit(currentState.copyWith(
//         amount: event.amount,
//         errorMessage: errorMessage,
//       ));
//     }
//   }

//   Future<void> _handleMakePayment(
//     MakePayment event,
//     Emitter<StripePaymentState> emit,
//   ) async {
//     try {
//       emit(StripePaymentLoading());

//       // Convert amount to cents and round to nearest integer
//       final amountInCents = (event.amount * 100).round();

//       // Create payment intent
//       final String? paymentIntentClientSecret = await _createPayment(
//         amountInCents,
//         'usd',
//       );

//       if (paymentIntentClientSecret == null) {
//         emit(const StripePaymentFailure(
//           error: 'Failed to create payment intent',
//         ));
//         return;
//       }

//       // Initialize payment sheet
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntentClientSecret,
//           merchantDisplayName: "Sayanth M K",
//         ),
//       );

//       // Process payment
//       await _processPayment();

//       emit(StripePaymentSuccess());
//     } catch (e) {
//       emit(StripePaymentFailure(error: e.toString()));
//     }
//   }

//   Future<String?> _createPayment(int amountInCents, String currency) async {
//     try {
//       final Map<String, dynamic> data = {
//         "amount": amountInCents.toString(),
//         "currency": currency,
//       };

//       final response = await _dio.post(
//         "https://api.stripe.com/v1/payment_intents",
//         data: data,
//         options: Options(
//           contentType: Headers.formUrlEncodedContentType,
//           headers: {
//             "Authorization": "Bearer $stripeSecretKey",
//           },
//         ),
//       );

//       if (response.statusCode == 200 && response.data != null) {
//         return response.data['client_secret'];
//       }
//       return null;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<void> _processPayment() async {
//     await Stripe.instance.presentPaymentSheet();
//     await Stripe.instance.confirmPaymentSheetPayment();
//   }
// }
