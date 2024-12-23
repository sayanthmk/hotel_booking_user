import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/calender/calender_section.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_page/widgets/booking_form_field.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_page/widgets/section_card.dart';
import 'package:hotel_booking/features/booking/presentation/pages/payment_page/payment_page.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_state.dart';

class HotelBookingPage extends StatelessWidget {
  HotelBookingPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController childcontroller = TextEditingController();
  final TextEditingController adultcontroller = TextEditingController();
  late final DateTime startdate;
  late final DateTime enddate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Book Your Stay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey[50]!,
                Colors.white,
              ],
            ),
          ),
          child: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
            builder: (context, hotelState) {
              if (hotelState is SelectedHotelLoaded) {
                final hotelId = hotelState.hotel.hotelId;
                return BlocBuilder<SelectedRoomBloc, SelectedRoomState>(
                  builder: (context, roomState) {
                    String? selectedRoomId;
                    if (roomState is RoomSelected) {
                      selectedRoomId = roomState.selectedRoom.roomId;
                    }
                    return BlocConsumer<UserBloc, UserState>(
                      listener: (context, state) {
                        if (state is UserErrorState) {
                          showErrorSnackBar(context, state.message);
                        }
                        if (state is UserDataSavedState) {
                          showSuccessSnackBar(
                              context, 'Booking Saved Successfully');
                          clearAllFields();
                        }
                      },
                      builder: (context, state) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SectionCard(
                                  title: 'Personal Information',
                                  fields: [
                                    BookingCustomFormField(
                                        label: 'Full Name',
                                        controller: nameController),
                                    BookingCustomFormField(
                                        label: 'Age',
                                        controller: ageController,
                                        keyboardType: TextInputType.number),
                                    BookingCustomFormField(
                                        label: 'Place',
                                        controller: placeController),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SectionCard(
                                  title: 'Guest Information',
                                  fields: [
                                    BookingCustomFormField(
                                        label: 'Number of Children',
                                        controller: childcontroller,
                                        keyboardType: TextInputType.number),
                                    BookingCustomFormField(
                                        label: 'Number of Adults',
                                        controller: adultcontroller,
                                        keyboardType: TextInputType.number),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Select Dates',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: HotelBookingColors
                                                .basictextcolor,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        DateRangePickerWidget(
                                          onDateRangeSelected:
                                              (DateTimeRange? selectedRange) {
                                            if (selectedRange != null) {
                                              startdate = selectedRange.start;
                                              enddate = selectedRange.end;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  height: 55,
                                  child: ElevatedButton(
                                    onPressed: state is! UserLoadingState
                                        ? () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              final bookingData = UserDataModel(
                                                name: nameController.text,
                                                age: int.parse(
                                                    ageController.text),
                                                place: placeController.text,
                                                startdate: startdate,
                                                enddate: enddate,
                                                noc: int.parse(
                                                    childcontroller.text),
                                                noa: int.parse(
                                                    adultcontroller.text),
                                                roomId: selectedRoomId!,
                                                paidAmount: 0,
                                              );
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PaymentPage(
                                                    bookingData: bookingData,
                                                    hotelId: hotelId,
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          HotelBookingColors.basictextcolor,
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
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
              return const Center(
                child: Text(
                  'Failed to load hotel information.',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void clearAllFields() {
    nameController.clear();
    ageController.clear();
    placeController.clear();
    adultcontroller.clear();
    childcontroller.clear();
  }

  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/core/validator/validators.dart';
// import 'package:hotel_booking/features/auth/presentation/widgets/textfrom_field.dart';
// import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
// import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/calender/calender_section.dart';
// import 'package:hotel_booking/features/booking/presentation/pages/booking_page/payment_page.dart';
// import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
// import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';
// import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_state.dart';

// class HotelBookingPage extends StatelessWidget {
//   HotelBookingPage({super.key});
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   final TextEditingController placeController = TextEditingController();
//   final TextEditingController childcontroller = TextEditingController();
//   final TextEditingController adultcontroller = TextEditingController();
//   late final DateTime startdate;
//   late final DateTime enddate;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Book Hotel',
//             style: TextStyle(color: Colors.white),
//           ),
//           centerTitle: true,
//           backgroundColor: HotelBookingColors.basictextcolor,
//           elevation: 0,
//           iconTheme: const IconThemeData(color: Colors.white),
//         ),
//         body: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
//           builder: (context, hotelState) {
//             if (hotelState is SelectedHotelLoaded) {
//               final hotelId = hotelState.hotel.hotelId;

//               return BlocBuilder<SelectedRoomBloc, SelectedRoomState>(
//                 builder: (context, roomState) {
//                   String? selectedRoomId;
//                   if (roomState is RoomSelected) {
//                     selectedRoomId = roomState.selectedRoom.roomId;
//                   }
//                   return BlocConsumer<UserBloc, UserState>(
//                     listener: (context, state) {
//                       if (state is UserErrorState) {
//                         showErrorSnackBar(context, state.message);
//                       }

//                       if (state is UserDataSavedState) {
//                         showSuccessSnackBar(
//                             context, 'Booking Saved Successfully');
//                         clearAllFields();
//                       }
//                     },
//                     builder: (context, state) {
//                       return SingleChildScrollView(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Form(
//                           key: _formKey,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Name',
//                                   style: TextStyle(
//                                     color: HotelBookingColors.basictextcolor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               CustomTextFormField(
//                                 controller: nameController,
//                                 labelText: 'Name',
//                                 hintText: 'Enter your Name',
//                                 keyboardType: TextInputType.visiblePassword,
//                                 textInputAction: TextInputAction.done,
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 validator: CustomValidator.validateRequired,
//                                 borderColor: Colors.grey,
//                                 focusedBorderColor: Colors.blue,
//                                 enabledBorderColor: Colors.grey,
//                                 errorBorderColor: Colors.red,
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Age',
//                                   style: TextStyle(
//                                     color: HotelBookingColors.basictextcolor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               CustomTextFormField(
//                                 controller: ageController,
//                                 labelText: 'Age',
//                                 hintText: 'Enter your Age',
//                                 keyboardType: TextInputType.visiblePassword,
//                                 textInputAction: TextInputAction.done,
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 validator: CustomValidator.validateRequired,
//                                 borderColor: Colors.grey,
//                                 focusedBorderColor: Colors.blue,
//                                 enabledBorderColor: Colors.grey,
//                                 errorBorderColor: Colors.red,
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Place',
//                                   style: TextStyle(
//                                     color: HotelBookingColors.basictextcolor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               CustomTextFormField(
//                                 controller: placeController,
//                                 labelText: 'Place',
//                                 hintText: 'Enter your Place',
//                                 keyboardType: TextInputType.visiblePassword,
//                                 textInputAction: TextInputAction.done,
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 validator: CustomValidator.validateRequired,
//                                 borderColor: Colors.grey,
//                                 focusedBorderColor: Colors.blue,
//                                 enabledBorderColor: Colors.grey,
//                                 errorBorderColor: Colors.red,
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'No of childs',
//                                   style: TextStyle(
//                                     color: HotelBookingColors.basictextcolor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               CustomTextFormField(
//                                 controller: childcontroller,
//                                 labelText: 'No of childs',
//                                 hintText: 'Enter the number',
//                                 keyboardType: TextInputType.visiblePassword,
//                                 textInputAction: TextInputAction.done,
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 validator: CustomValidator.validateRequired,
//                                 borderColor: Colors.grey,
//                                 focusedBorderColor: Colors.blue,
//                                 enabledBorderColor: Colors.grey,
//                                 errorBorderColor: Colors.red,
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'No of adults',
//                                   style: TextStyle(
//                                     color: HotelBookingColors.basictextcolor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               CustomTextFormField(
//                                 controller: adultcontroller,
//                                 labelText: 'No of adults',
//                                 hintText: 'Enter the number',
//                                 keyboardType: TextInputType.visiblePassword,
//                                 textInputAction: TextInputAction.done,
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 validator: CustomValidator.validateRequired,
//                                 borderColor: Colors.grey,
//                                 focusedBorderColor: Colors.blue,
//                                 enabledBorderColor: Colors.grey,
//                                 errorBorderColor: Colors.red,
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               DateRangePickerWidget(
//                                 onDateRangeSelected:
//                                     (DateTimeRange? selectedRange) {
//                                   if (selectedRange != null) {
//                                     startdate = selectedRange.start;
//                                     enddate = selectedRange.end;
//                                   }
//                                 },
//                               ),
//                               const Center(),
//                               ElevatedButton(
//                                 onPressed: state is! UserLoadingState
//                                     ? () {
//                                         if (_formKey.currentState!.validate()) {
//                                           final bookingData = UserDataModel(
//                                             name: nameController.text,
//                                             age: int.parse(ageController.text),
//                                             place: placeController.text,
//                                             startdate: startdate,
//                                             enddate: enddate,
//                                             noc:
//                                                 int.parse(childcontroller.text),
//                                             noa:
//                                                 int.parse(adultcontroller.text),
//                                             roomId: selectedRoomId!,
//                                             paidAmount: 0,
//                                           );

//                                           // Navigate to the payment page and pass booking data
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) => PaymentPage(
//                                                 bookingData: bookingData,
//                                                 hotelId: hotelId,
//                                               ),
//                                             ),
//                                           );
//                                         }
//                                       }
//                                     : null,
//                                 style: ElevatedButton.styleFrom(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 16),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Save Booking',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                               if (state is UserLoadingState)
//                                 const Center(
//                                     child: CircularProgressIndicator()),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             } else {
//               return const Center(
//                   child: Text('Failed to load hotel information.'));
//             }
//           },
//         ),
//       ),
//     );
//   }

//   void clearAllFields() {
//     nameController.clear();
//     ageController.clear();
//     placeController.clear();
//     adultcontroller.clear();
//     childcontroller.clear();
//   }

//   void showErrorSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   void showSuccessSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
// }
    // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Place is required';
                                //   }
                                //   return null;
                                // },
                                    // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Name is required';
                                //   }
                                //   return null;
                                // },
                                     // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Field is required';
                                //   }
                                //   return null;
                                // },
                                       // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Field is required';
                                //   }
                                //   return null;
                                // },// validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Age is required';
                                //   }
                                //   return null;
                                // },
                                
                                          // context.read<UserBloc>().add(
                                          //       SaveHotelBookingEvent(
                                          //         hotelId: hotelId,
                                          //         bookingData: bookingData,
                                          //       ),
                                          //     );





                                                 // Center(
                              //   child: ElevatedButton(
                              //     onPressed: () {
                              //       Navigator.of(context)
                              //           .push(MaterialPageRoute(
                              //         builder: (context) =>
                              //             const StripePaymentPage(),
                              //       ));
                              //     },
                              //     child: const Text('payment'),
                              //   ),
                              // ),
                              // ElevatedButton(
                              //   onPressed: state is! UserLoadingState
                              //       ? () {
                              //           if (_formKey.currentState!.validate()) {
                              //             final bookingData = UserDataModel(

                              //               name: nameController.text,
                              //               age: int.parse(ageController.text),
                              //               place: placeController.text,
                              //               startdate: startdate,
                              //               enddate: enddate,
                              //               noc:
                              //                   int.parse(childcontroller.text),
                              //               noa:
                              //                   int.parse(adultcontroller.text),
                              //               roomId: selectedRoomId!,
                              //             );

                              //             context.read<UserBloc>().add(
                              //                   SaveUserDataEvent(
                              //                       bookingData, hotelId),
                              //                 );

                              //             Navigator.of(context)
                              //                 .push(MaterialPageRoute(
                              //               builder: (context) =>
                              //                   const BookingSuccessPage(),
                              //             ));
                              //           }
                              //         }
                              //       : null,
                              //   style: ElevatedButton.styleFrom(
                              //     padding:
                              //         const EdgeInsets.symmetric(vertical: 16),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //   ),
                              //   child: const Text(
                              //     'Save Booking',
                              //     style: TextStyle(fontSize: 16),
                              //   ),
                              // ),
                                    // BlocConsumer<StripeBloc, StripePaymentState>(
                              //   listener: (context, state) {
                              //     if (state is StripePaymentSuccess) {
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         const SnackBar(
                              //             content: Text('Payment Successful!')),
                              //       );
                              //     }
                              //     if (state is StripePaymentFailure) {
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         SnackBar(
                              //             content: Text(
                              //                 'Payment Failed: ${state.error}')),
                              //       );
                              //     }
                              //   },
                              //   builder: (context, state) {
                              //     if (state is StripePaymentLoading) {
                              //       return const Center(
                              //           child: CircularProgressIndicator());
                              //     }

                              //     return Padding(
                              //       padding: const EdgeInsets.all(16.0),
                              //       child: Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: [
                              //           TextField(
                              //             decoration: InputDecoration(
                              //               labelText: 'Enter Amount',
                              //               errorText:
                              //                   state is StripePaymentInitial
                              //                       ? state.errorMessage
                              //                       : null,
                              //             ),
                              //             keyboardType: TextInputType.number,
                              //             onChanged: (value) {
                              //               context.read<StripeBloc>().add(
                              //                     UpdatePaymentAmount(value),
                              //                   );
                              //             },
                              //           ),
                              //           const SizedBox(height: 20),
                              //           ElevatedButton(
                              //             onPressed: state is! UserLoadingState
                              //                 ? () {
                              //                     if (_formKey.currentState!
                              //                         .validate()) {
                              //                       final amount = state
                              //                                   is StripePaymentInitial &&
                              //                               state.amount
                              //                                   .isNotEmpty
                              //                           ? double.parse(
                              //                               state.amount)
                              //                           : 0.0; // Default to 0 if not set

                              //                       final bookingData =
                              //                           UserDataModel(
                              //                         name: nameController.text,
                              //                         age: int.parse(
                              //                             ageController.text),
                              //                         place:
                              //                             placeController.text,
                              //                         startdate: startdate,
                              //                         enddate: enddate,
                              //                         noc: int.parse(
                              //                             childcontroller.text),
                              //                         noa: int.parse(
                              //                             adultcontroller.text),
                              //                         roomId: selectedRoomId!,
                              //                         paidAmount:
                              //                             amount, // Add paidAmount here
                              //                       );

                              //                       context
                              //                           .read<UserBloc>()
                              //                           .add(
                              //                             SaveUserDataEvent(
                              //                                 bookingData,
                              //                                 hotelId),
                              //                           );
                              //                       context
                              //                           .read<StripeBloc>()
                              //                           .add(
                              //                             InitiatePayment(
                              //                                 amount),
                              //                           );

                              //                       Navigator.of(context)
                              //                           .push(MaterialPageRoute(
                              //                         builder: (context) =>
                              //                             const BookingSuccessPage(),
                              //                       ));
                              //                     }
                              //                   }
                              //                 : null,
                              //             style: ElevatedButton.styleFrom(
                              //               padding: const EdgeInsets.symmetric(
                              //                   vertical: 16),
                              //               shape: RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadius.circular(10),
                              //               ),
                              //             ),
                              //             child: const Text(
                              //               'Save Booking',
                              //               style: TextStyle(fontSize: 16),
                              //             ),
                              //           ),

                              //         ],
                              //       ),
                              //     );
                              //   },
                              // ),
                              
                                // validator: CustomValidator.validateRequired,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Email is required';
                                //   }
                                //   const emailRegex =
                                //       r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-z]{2,7}$';
                                //   if (!RegExp(emailRegex).hasMatch(value)) {
                                //     return 'Please enter a valid email address';
                                //   }
                                //   return null;
                                // },
                                
                                          // context.read<UserBloc>().add(
                                          //       SaveUserDataEvent(
                                          //           bookingData, hotelId),
                                          //     );

                                          // Navigator.of(context)
                                          //     .push(MaterialPageRoute(
                                          //   builder: (context) =>
                                          //       const BookingSuccessPage(),
                                          // ));
         // child: ElevatedButton(
                                  //   onPressed: () {
                                  //     Navigator.of(context)
                                  //         .push(MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const StripePaymentPage(),
                                  //     ));
                                  //   },
                                  //   child: const Text('payment'),
                                  // ),

                                    // Widget _buildSectionCard(String title, List<Widget> fields) {
  //   return Card(
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             title,
  //             style: const TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: HotelBookingColors.basictextcolor,
  //             ),
  //           ),
  //           const SizedBox(height: 16),
  //           ...fields,
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildFormField(String label, TextEditingController controller,
  //     {TextInputType? keyboardType}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: const TextStyle(
  //           color: HotelBookingColors.basictextcolor,
  //           fontWeight: FontWeight.w500,
  //           fontSize: 14,
  //         ),
  //       ),
  //       const SizedBox(height: 8),
  //       CustomTextFormField(
  //         controller: controller,
  //         labelText: label,
  //         hintText: 'Enter $label',
  //         keyboardType: keyboardType ?? TextInputType.text,
  //         textInputAction: TextInputAction.next,
  //         autovalidateMode: AutovalidateMode.onUserInteraction,
  //         validator: CustomValidator.validateRequired,
  //         borderColor: Colors.grey.shade300,
  //         focusedBorderColor: HotelBookingColors.basictextcolor,
  //         enabledBorderColor: Colors.grey.shade300,
  //         errorBorderColor: Colors.red.shade300,
  //       ),
  //       const SizedBox(height: 16),
  //     ],
  //   );
  // }