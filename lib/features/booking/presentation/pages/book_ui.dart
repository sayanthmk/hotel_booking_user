import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/textfrom_field.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_success_screen.dart';
import 'package:hotel_booking/features/booking/presentation/pages/bookings.dart';
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
    return
        // MultiBlocProvider(
        //   providers: [
        //     BlocProvider.value(value: di.sl<SelectedHotelBloc>()),
        //     BlocProvider.value(value: di.sl<UserBloc>()),
        //   ],
        //   child: Scaffold(
        //     appBar: AppBar(
        //       title: const Text('Hotel Booking'),
        //     ),
        //     body:

        Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
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
                    final currentUserId =
                        FirebaseAuth.instance.currentUser?.uid;
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // CustomButton(
                            //   text: "Bookings",
                            //   onTap: () async {
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => const UserBookingsPage(),
                            //     ));
                            //   },
                            //   color: Colors.blue[300]!,
                            //   textColor: Colors.white,
                            //   borderRadius: 12.0,
                            //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                            //   fontSize: 16.0,
                            //   fontWeight: FontWeight.bold,
                            //   height: 55,
                            //   width: 100,
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => const UserBookingsPage(),
                            //     ));
                            //   },
                            //   child: const Text('bookings'),
                            // ),
                            Text(
                              'User ID: $currentUserId',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Room ID: $selectedRoomId',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Booking for Hotel ID: $hotelId',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            // Name Input
                            CustomTextFormField(
                              controller: nameController,
                              labelText: 'Name',
                              hintText: 'Enter your Name',
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name is required';
                                }
                                return null;
                              },
                              borderColor: Colors.grey,
                              focusedBorderColor: Colors.blue,
                              enabledBorderColor: Colors.grey,
                              errorBorderColor: Colors.red,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              controller: ageController,
                              labelText: 'Age',
                              hintText: 'Enter your Age',
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Age is required';
                                }
                                return null;
                              },
                              borderColor: Colors.grey,
                              focusedBorderColor: Colors.blue,
                              enabledBorderColor: Colors.grey,
                              errorBorderColor: Colors.red,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              controller: placeController,
                              labelText: 'Place',
                              hintText: 'Enter your Place',
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Place is required';
                                }
                                return null;
                              },
                              borderColor: Colors.grey,
                              focusedBorderColor: Colors.blue,
                              enabledBorderColor: Colors.grey,
                              errorBorderColor: Colors.red,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              controller: childcontroller,
                              labelText: 'No of childs',
                              hintText: 'Enter the number',
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field is required';
                                }
                                return null;
                              },
                              borderColor: Colors.grey,
                              focusedBorderColor: Colors.blue,
                              enabledBorderColor: Colors.grey,
                              errorBorderColor: Colors.red,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              controller: adultcontroller,
                              labelText: 'No of adults',
                              hintText: 'Enter the number',
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field is required';
                                }
                                return null;
                              },
                              borderColor: Colors.grey,
                              focusedBorderColor: Colors.blue,
                              enabledBorderColor: Colors.grey,
                              errorBorderColor: Colors.red,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // CustomButton(
                            //   text: "Payment",
                            //   onTap: () async {
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => const PaymentScreen(),
                            //     ));
                            //   },
                            //   color: Colors.blue[300]!,
                            //   textColor: Colors.white,
                            //   borderRadius: 12.0,
                            //   padding:
                            //       const EdgeInsets.symmetric(vertical: 16.0),
                            //   fontSize: 16.0,
                            //   fontWeight: FontWeight.bold,
                            //   height: 55,
                            //   width: 100,
                            // ),
                            // ElevatedButton(
                            //     onPressed: () {
                            //       Navigator.of(context).push(MaterialPageRoute(
                            //         builder: (context) => const PaymentScreen(),
                            //       ));
                            //     },
                            //     child: const Text('payment'))
                            // DateRangePickerDemo(),
                            DateRangePickerWidget(
                              onDateRangeSelected:
                                  (DateTimeRange? selectedRange) {
                                if (selectedRange != null) {
                                  startdate = selectedRange.start;
                                  enddate = selectedRange.end;
                                  print(
                                      "Selected Start Date: ${selectedRange.start}");
                                  print(
                                      "Selected End Date: ${selectedRange.end}");
                                }
                              },
                            ),

                            // SfDateRangePicker(
                            //   view: DateRangePickerView.month,
                            //   monthViewSettings:
                            //       const DateRangePickerMonthViewSettings(
                            //     firstDayOfWeek: 1,
                            //   ),
                            //   selectionMode: DateRangePickerSelectionMode.range,
                            //   initialSelectedRange: PickerDateRange(
                            //     DateTime(2024, 11, 1),
                            //     DateTime(2024, 11, 7),
                            //   ),
                            // ),

                            ElevatedButton(
                              onPressed: state is! UserLoadingState
                                  ? () {
                                      if (_formKey.currentState!.validate()) {
                                        final bookingData = UserDataModel(
                                          name: nameController.text,
                                          age: int.parse(ageController.text),
                                          place: placeController.text,
                                          startdate: startdate,
                                          enddate: enddate,
                                          noc: int.parse(childcontroller.text),
                                          noa: int.parse(adultcontroller.text),
                                          cuid: selectedRoomId!,
                                        );

                                        context.read<UserBloc>().add(
                                              SaveHotelBookingEvent(
                                                hotelId: hotelId,
                                                bookingData: bookingData,
                                              ),
                                            );
                                        context.read<UserBloc>().add(
                                              SaveUserDataEvent(bookingData),
                                            );
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              BookingSuccessPage(),
                                        ));
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Save Booking',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            if (state is UserLoadingState)
                              const Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
                child: Text('Failed to load hotel information.'));
          }
        },
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
      ),
    );
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
