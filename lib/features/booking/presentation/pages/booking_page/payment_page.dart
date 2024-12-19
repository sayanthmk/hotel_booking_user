import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_success_screen.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_bloc.dart';
import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_event.dart';
import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_state.dart';

class PaymentPage extends StatelessWidget {
  final UserDataModel bookingData;
  final String hotelId;
  PaymentPage({required this.bookingData, required this.hotelId, super.key});

  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
        centerTitle: true,
      ),
      body: BlocConsumer<StripeBloc, StripePaymentState>(
        listener: (context, state) {
          if (state is StripePaymentSuccess) {
            context
                .read<UserBloc>()
                .add(SaveUserDataEvent(bookingData, hotelId));
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const BookingSuccessPage(),
            ));
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Enter Amount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    controller: amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      hintText: 'Enter the payment amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Amount is required';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Please enter a valid amount';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state is! StripePaymentLoading
                        ? () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final amount =
                                  double.parse(amountController.text);

                              context
                                  .read<StripeBloc>()
                                  .add(InitiatePayment(amount));
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Proceed to Payment'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
