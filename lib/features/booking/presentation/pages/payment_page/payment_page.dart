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
import 'package:hotel_booking/utils/custom_appbar/custom_appbar.dart';
import 'package:hotel_booking/utils/snackbar.dart';

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
          appBar: const BookingAppbar(
            heading: 'Booking Payment Details',
          ),
          body: BlocConsumer<StripeBloc, StripePaymentState>(
            listener: (context, state) {
              if (state is StripePaymentSuccess) {
                // final bookingData = UserDataModel(
                //     paidAmount: double.parse(amountController.text));
                final updatedBookingData = UserDataModel(
                  name: bookingData.name, // existing data
                  age: bookingData.age,
                  place: bookingData.place,
                  startdate: bookingData.startdate,
                  enddate: bookingData.enddate,
                  noc: bookingData.noc,
                  noa: bookingData.noa,
                  roomId: bookingData.roomId,
                  paidAmount: double.parse(
                      amountController.text), // Add the entered amount
                );
                context
                    .read<UserBloc>()
                    .add(SaveUserDataEvent(updatedBookingData, hotelId));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BookingSuccessPage(),
                ));
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Payment Successful!')),
                // );
                showCustomSnackBar(
                    context, 'Payment Successful!', Colors.green);
              }
              if (state is StripePaymentFailure) {
                showCustomSnackBar(
                    context, 'Payment Failed: ${state.error}', Colors.red);
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
                                    // Create a new instance of UserDataModel with the paidAmount added

                                    // final bookingData = UserDataModel(
                                    //                                               name: nameController.text,
                                    //                                               age: int.parse(
                                    //                                                   ageController.text),
                                    //                                               place: placeController.text,
                                    //                                               startdate: startdate,
                                    //                                               enddate: enddate,
                                    //                                               noc: int.parse(
                                    //                                                   childcontroller.text),
                                    //                                               noa: int.parse(
                                    //                                                   adultcontroller.text),
                                    //                                               roomId: selectedRoomId!,
                                    //                                               // paidAmount: 0,
                                    //                                             );
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
