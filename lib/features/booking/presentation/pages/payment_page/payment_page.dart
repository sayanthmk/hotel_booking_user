import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_page/widgets/booking_form_field.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_page/widgets/section_card.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_sucess_screen/booking_success_screen.dart';
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
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Booking Payment Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: HotelBookingColors.basictextcolor,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
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
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Payment Successful!')),
                // );
                SnackBar(
                  content: const Text('Payment Successful!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }
              if (state is StripePaymentFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Payment Failed: ${state.error}'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
                      SectionCard(
                        title: 'Guest Information',
                        fields: [
                          BookingCustomFormField(
                              label: 'Enter Amount',
                              controller: amountController,
                              keyboardType: TextInputType.number),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 55,
                        child: ElevatedButton(
                          onPressed: state is! StripePaymentLoading
                              ? () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final amount =
                                        double.parse(amountController.text);

                                    context
                                        .read<StripeBloc>()
                                        .add(InitiatePayment(amount));
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HotelBookingColors.basictextcolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: state is UserLoadingState
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'Proceed to Payment',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
