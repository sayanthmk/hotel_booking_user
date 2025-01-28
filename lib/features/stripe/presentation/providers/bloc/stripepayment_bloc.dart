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
      final amountInCents = (event.amount * 100).round();

      final paymentIntent = await createPaymentIntentUseCase(
        amount: amountInCents,
        currency: 'inr',
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent.clientSecret,
          merchantDisplayName: "Staywise",
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      emit(StripePaymentSuccess());
    } catch (e) {
      emit(StripePaymentFailure(error: e.toString()));
    }
  }
}
