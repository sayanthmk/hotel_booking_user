import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/core/validator/validators.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/calender/calender_section.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_page/widgets/booking_form_field.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_page/widgets/section_card.dart';
import 'package:hotel_booking/features/booking/presentation/pages/payment_page/payment_page.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_bloc.dart';
import 'package:hotel_booking/features/rooms/presentation/providers/selected_rooms/bloc/selectedrooms_state.dart';
import 'package:hotel_booking/utils/custom_appbar/custom_appbar.dart';
import 'package:hotel_booking/utils/snackbar.dart';

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
        appBar: const BookingAppbar(
          heading: 'Book Your Stay',
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
                          // showErrorSnackBar(context, state.message);
                          showCustomSnackBar(
                              context, state.message, Colors.red);
                        }
                        if (state is UserDataSavedState) {
                          // showSuccessSnackBar(
                          //     context, 'Booking Saved Successfully');
                          showCustomSnackBar(context,
                              'Booking Saved Successfully', Colors.green);
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
                                      keyboardType: TextInputType.number,
                                      maxlength: 3,
                                    ),
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
                                      keyboardType: TextInputType.number,
                                      validator: CustomValidator.validateNumber,
                                      maxlength: 1,
                                    ),
                                    BookingCustomFormField(
                                      label: 'Number of Adults',
                                      controller: adultcontroller,
                                      keyboardType: TextInputType.number,
                                      validator: CustomValidator.validateNumber,
                                      maxlength: 1,
                                    ),
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
}
   