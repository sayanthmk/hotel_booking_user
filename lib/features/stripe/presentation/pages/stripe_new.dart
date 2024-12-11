// import '../entities/payment_intent_entity.dart';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_booking/features/stripe/data/datasourse/consts.dart';

abstract class StripePaymentRepository {
  Future<PaymentIntentEntity> createPaymentIntent({
    required int amount,
    required String currency,
  });

  Future<void> processPayment(String clientSecret);
}

// import '../entities/payment_intent_entity.dart';
// import '../repositories/stripe_payment_repository.dart';

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

// import 'package:flutter_stripe/flutter_stripe.dart';

// import '../../domain/entities/payment_intent_entity.dart';
// import '../../domain/repositories/stripe_payment_repository.dart';
// import '../datasources/stripe_remote_datasource.dart';
// import '../models/payment_intent_model.dart';

class StripePaymentRepositoryImpl implements StripePaymentRepository {
  final StripeRemoteDataSource remoteDataSource;

  StripePaymentRepositoryImpl(this.remoteDataSource);

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
        merchantDisplayName: "Your App Name",
      ),
    );

    await Stripe.instance.presentPaymentSheet();
    await Stripe.instance.confirmPaymentSheetPayment();
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// import '../../domain/usecases/create_payment_intent_usecase.dart';

// part 'stripe_payment_event.dart';
// part 'stripe_payment_state.dart';

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

// Events
abstract class StripePaymentEvent extends Equatable {
  const StripePaymentEvent();

  @override
  List<Object> get props => [];
}

class UpdatePaymentAmount extends StripePaymentEvent {
  final String amount;

  const UpdatePaymentAmount(this.amount);

  @override
  List<Object> get props => [amount];
}

class InitiatePayment extends StripePaymentEvent {
  final double amount;

  const InitiatePayment(this.amount);

  @override
  List<Object> get props => [amount];
}

// States
abstract class StripePaymentState extends Equatable {
  const StripePaymentState();

  @override
  List<Object> get props => [];
}

class StripePaymentInitial extends StripePaymentState {
  final String amount;
  final String? errorMessage;

  const StripePaymentInitial({
    this.amount = '',
    this.errorMessage,
  });

  StripePaymentInitial copyWith({
    String? amount,
    String? errorMessage,
  }) {
    return StripePaymentInitial(
      amount: amount ?? this.amount,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object> get props => [
        amount,
      ];
}

class StripePaymentLoading extends StripePaymentState {}

class StripePaymentSuccess extends StripePaymentState {}

class StripePaymentFailure extends StripePaymentState {
  final String error;

  const StripePaymentFailure({required this.error});

  @override
  List<Object> get props => [error];
}

abstract class StripeRemoteDataSource {
  Future<PaymentIntentModel> createPaymentIntent({
    required int amount,
    required String currency,
  });
}

class StripeRemoteDataSourceImpl implements StripeRemoteDataSource {
  final Dio _dio;

  StripeRemoteDataSourceImpl(this._dio);

  @override
  Future<PaymentIntentModel> createPaymentIntent({
    required int amount,
    required String currency,
  }) async {
    try {
      final response = await _dio.post(
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
// import '../../../domain/entities/payment_intent_entity.dart';

// import '../../../domain/entities/payment_intent_entity.dart';

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
  // Convert model to domain entity
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

class StripePaymentPage extends StatelessWidget {
  const StripePaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stripe Payment')),
      body: BlocConsumer<StripeBloc, StripePaymentState>(
        listener: (context, state) {
          if (state is StripePaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment Successful!')),
            );
          }
          if (state is StripePaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment Failed: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is StripePaymentLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    errorText: state is StripePaymentInitial
                        ? state.errorMessage
                        : null,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    context.read<StripeBloc>().add(
                          UpdatePaymentAmount(value),
                        );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state is StripePaymentInitial &&
                          state.errorMessage == null &&
                          state.amount.isNotEmpty
                      ? () {
                          final amount = double.parse(state.amount);
                          context.read<StripeBloc>().add(
                                InitiatePayment(amount),
                              );
                        }
                      : null,
                  child: const Text('Pay Now'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
