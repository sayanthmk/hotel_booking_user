import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/textfrom_field.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/stripe/presentation/pages/stripe_bloc_payment_page.dart';

class HotelBookingPage extends StatelessWidget {
  HotelBookingPage({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _childcontroller = TextEditingController();

  final TextEditingController _adultcontroller = TextEditingController();

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
          // Ensure the hotel is loaded before showing the booking form
          if (hotelState is SelectedHotelLoaded) {
            final hotelId = hotelState.hotel.hotelId;
            return BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                // Handle different states
                if (state is UserErrorState) {
                  _showErrorSnackBar(context, state.errorMessage);
                }

                if (state is UserDataSavedState) {
                  _showSuccessSnackBar(context, 'Booking Saved Successfully');
                  // Optional: Clear fields after successful booking
                  _clearAllFields();
                }
              },
              builder: (context, state) {
                // return _buildBookingForm(context, state, hotelId);
                // return Container();
                final currentUserId = FirebaseAuth.instance.currentUser?.uid;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Display the selected Hotel ID
                        // UserBookingsPage(),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UserBookingsPage(),
                              ));
                            },
                            child: const Text('bookings')),
                        Text(
                          'User ID: $currentUserId',
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
                          controller: _nameController,
                          labelText: 'Name',
                          hintText: 'Enter your Name',
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          // obscureText: true,
                          // suffixIcon: const Icon(Icons.remove_red_eye),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: _ageController,
                          labelText: 'Age',
                          hintText: 'Enter your Age',
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          // obscureText: true,
                          // suffixIcon: const Icon(Icons.remove_red_eye),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: _placeController,
                          labelText: 'Place',
                          hintText: 'Enter your Place',
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          // obscureText: true,
                          // suffixIcon: const Icon(Icons.remove_red_eye),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: _childcontroller,
                          labelText: 'No of childs',
                          hintText: 'Enter the number',
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          // obscureText: true,
                          // suffixIcon: const Icon(Icons.remove_red_eye),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: _adultcontroller,
                          labelText: 'No of adults',
                          hintText: 'Enter the number',
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          // obscureText: true,
                          // suffixIcon: const Icon(Icons.remove_red_eye),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaymentScreen(),
                              ));
                            },
                            child: Text('pay'))

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

                        // Conditional Loading or Submit Button
                        // _buildSubmitButton(context, state, hotelId),
                        ,
                        ElevatedButton(
                          onPressed: state is! UserLoadingState
                              ? () {
                                  // _submitBooking(context, hotelId)
                                  if (_formKey.currentState!.validate()) {
                                    // Create UserDataModel
                                    final bookingData = UserDataModel(
                                      name: _nameController.text,
                                      age: int.parse(_ageController.text),
                                      place: _placeController.text,
                                      date: DateTime.now(),
                                      noc: 1,
                                      noa: 1,
                                    );

                                    // Dispatch SaveHotelBookingEvent
                                    context.read<UserBloc>().add(
                                          SaveHotelBookingEvent(
                                            hotelId: hotelId,
                                            bookingData: bookingData,
                                          ),
                                        );
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Save Booking',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Show loading indicator if state is loading
                        if (state is UserLoadingState)
                          const Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
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

  void _clearAllFields() {
    _nameController.clear();
    _ageController.clear();
    _placeController.clear();
    _adultcontroller.clear();
    _childcontroller.clear();
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// class UserDataModel {
//   final String? id; // Optional ID for document reference
//   final String name;
//   final int age;
//   final String place;
//   final DateTime date;

//   UserDataModel({
//     this.id,
//     required this.name,
//     required this.age,
//     required this.place,
//     required this.date,
//   });

//   // Convert to Map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'age': age,
//       'place': place,
//       'date': Timestamp.fromDate(date),
//     };
//   }

//   // Create from Firestore document
//   factory UserDataModel.fromMap(Map<String, dynamic> map, {String? id}) {
//     return UserDataModel(
//       id: id,
//       name: map['bookingDetails']['name'] ?? '',
//       age: map['bookingDetails']['age'] ?? 0,
//       place: map['bookingDetails']['place'] ?? '',
//       date: (map['bookingDetails']['date'] != null &&
//               map['bookingDetails']['date'] is Timestamp)
//           ? (map['bookingDetails']['date'] as Timestamp).toDate()
//           : DateTime.now(),
//     );
//   }
// }

// data/datasources/user_remote_datasource.dart

// abstract class UserRemoteDataSource {
//   Future<void> saveUserBooking(UserDataModel userData);
//   Future<List<UserDataModel>> getUserBookings();

//   // New method for hotel bookings
//   Future<void> saveHotelBooking({
//     required String hotelId,
//     required UserDataModel bookingData,
//   });

//   // Optional: Method to retrieve hotel bookings
//   Future<List<UserDataModel>> getHotelBookings(String hotelId);
// }

// class UserRemoteDataSourceImpl implements UserRemoteDataSource {
//   final FirebaseFirestore _firestore;
//   final FirebaseAuth _auth;

//   UserRemoteDataSourceImpl(this._firestore, this._auth);

//   @override
//   Future<void> saveUserBooking(UserDataModel userData) async {
//     try {
//       // Get current user's UID
//       final User? currentUser = _auth.currentUser;
//       if (currentUser == null) {
//         throw Exception('No authenticated user found');
//       }

//       // Reference to the user's booking subcollection
//       final bookingRef = _firestore
//           .collection('users')
//           .doc(currentUser.uid)
//           .collection('bookings')
//           .doc(); // Auto-generate document ID
//       log('users/bookings');
//       // Save the booking
//       await bookingRef.set(userData.toMap());
//     } catch (e) {
//       throw Exception('Failed to save user booking: $e');
//     }
//   }

//   @override
//   Future<List<UserDataModel>> getUserBookings() async {
//     try {
//       // Get current user's UID
//       final User? currentUser = _auth.currentUser;
//       if (currentUser == null) {
//         throw Exception('No authenticated user found');
//       }

//       // Get all bookings for the current user
//       final querySnapshot = await _firestore
//           .collection('users')
//           .doc(currentUser.uid)
//           .collection('bookings')
//           .get();
//       log('users/bookings/get');
//       // Convert documents to UserDataModel
//       final bookings = querySnapshot.docs
//           .map((doc) => UserDataModel.fromMap(doc.data(), id: doc.id))
//           .toList();
//       log('Fetching user bookings...');
//       for (var doc in querySnapshot.docs) {
//         log('Document ID: ${doc.id}');
//         log('Document Data: ${doc.data()}');
//       }

//       return bookings;
//     } catch (e) {
//       throw Exception('Failed to retrieve user bookings: $e');
//     }
//   }

//   @override
//   Future<void> saveHotelBooking({
//     required String hotelId,
//     required UserDataModel bookingData,
//   }) async {
//     try {
//       // Get current user's UID
//       final User? currentUser = _auth.currentUser;
//       if (currentUser == null) {
//         throw Exception('No authenticated user found');
//       }

//       // Reference to the hotel's booking subcollection
//       final bookingRef = _firestore
//           .collection('hotels')
//           .doc(hotelId)
//           .collection('bookings')
//           .doc(); // Auto-generate document ID
//       log('users/bookings/save');
//       // Prepare booking data with user ID
//       final bookingMap = bookingData.toMap();
//       bookingMap['userId'] = currentUser.uid; // Add user ID to the booking

//       // Save the booking
//       await bookingRef.set(bookingMap);

//       // Optionally, save a reference in the user's bookings
//       await _firestore
//           .collection('users')
//           .doc(currentUser.uid)
//           .collection('bookings')
//           .doc(bookingRef.id)
//           .set({
//         'hotelId': hotelId,
//         'bookingDetails': bookingMap,
//       });
//     } catch (e) {
//       throw Exception('Failed to save hotel booking: $e');
//     }
//   }

//   @override
//   Future<List<UserDataModel>> getHotelBookings(String hotelId) async {
//     try {
//       // Get all bookings for a specific hotel
//       final querySnapshot = await _firestore
//           .collection('hotels')
//           .doc(hotelId)
//           .collection('bookings')
//           .get();
//       log('users/bookings/get hotel');
//       // Convert documents to UserDataModel
//       return querySnapshot.docs
//           .map((doc) => UserDataModel.fromMap(doc.data(), id: doc.id))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to retrieve hotel bookings: $e');
//     }
//   }
// }

// domain/repositories/user_repository.dart

// abstract class UserRepository {
//   Future<void> saveUserBooking(UserDataModel userData);
//   Future<List<UserDataModel>> getUserBookings();

//   // New methods for hotel bookings
//   Future<void> saveHotelBooking({
//     required String hotelId,
//     required UserDataModel bookingData,
//   });

//   Future<List<UserDataModel>> getHotelBookings(String hotelId);
// }

// class UserRepositoryImpl implements UserRepository {
//   final UserRemoteDataSource remoteDataSource;

//   UserRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<void> saveUserBooking(UserDataModel userData) async {
//     return await remoteDataSource.saveUserBooking(userData);
//   }

//   @override
//   Future<List<UserDataModel>> getUserBookings() async {
//     return await remoteDataSource.getUserBookings();
//   }

//   @override
//   Future<void> saveHotelBooking({
//     required String hotelId,
//     required UserDataModel bookingData,
//   }) async {
//     return await remoteDataSource.saveHotelBooking(
//       hotelId: hotelId,
//       bookingData: bookingData,
//     );
//   }

//   @override
//   Future<List<UserDataModel>> getHotelBookings(String hotelId) async {
//     return await remoteDataSource.getHotelBookings(hotelId);
//   }
// }

// presentation/bloc/user_event.dart
// abstract class UserEvent {}

// class SaveUserDataEvent extends UserEvent {
//   final UserDataModel userData;

//   SaveUserDataEvent(this.userData);
// }

// class GetUserDataEvent extends UserEvent {}

// // New event for hotel booking
// class SaveHotelBookingEvent extends UserEvent {
//   final String hotelId;
//   final UserDataModel bookingData;

//   SaveHotelBookingEvent({
//     required this.hotelId,
//     required this.bookingData,
//   });
// }

// class GetHotelBookingsEvent extends UserEvent {
//   final String hotelId;

//   GetHotelBookingsEvent(this.hotelId);
// }

// presentation/bloc/user_state.dart
// abstract class UserState {}

// class UserInitialState extends UserState {}

// class UserLoadingState extends UserState {}

// class UserDataSavedState extends UserState {}

// class UserDataLoadedState extends UserState {
//   final List<UserDataModel> userData;

//   UserDataLoadedState(this.userData);
// }

// class UserErrorState extends UserState {
//   final String errorMessage;

//   UserErrorState(this.errorMessage);
// }

// presentation/bloc/user_bloc.dart

// class UserBloc extends Bloc<UserEvent, UserState> {
//   final UserRepository repository;

//   UserBloc(this.repository) : super(UserInitialState()) {
//     on<SaveUserDataEvent>(_onSaveUserData);
//     on<GetUserDataEvent>(_onGetUserData);
//     on<SaveHotelBookingEvent>(_onSaveHotelBooking);
//     on<GetHotelBookingsEvent>(_onGetHotelBookings);
//   }

//   void _onSaveUserData(SaveUserDataEvent event, Emitter<UserState> emit) async {
//     try {
//       emit(UserLoadingState());
//       await repository.saveUserBooking(event.userData);
//       emit(UserDataSavedState());
//     } catch (e) {
//       emit(UserErrorState('Failed to save user data: $e'));
//     }
//   }

//   void _onGetUserData(GetUserDataEvent event, Emitter<UserState> emit) async {
//     try {
//       emit(UserLoadingState());
//       final userData = await repository.getUserBookings();
//       emit(UserDataLoadedState(userData));
//     } catch (e) {
//       emit(UserErrorState('Failed to load user data: $e'));
//     }
//   }

//   void _onSaveHotelBooking(
//       SaveHotelBookingEvent event, Emitter<UserState> emit) async {
//     try {
//       emit(UserLoadingState());
//       await repository.saveHotelBooking(
//         hotelId: event.hotelId,
//         bookingData: event.bookingData,
//       );
//       emit(UserDataSavedState());
//     } catch (e) {
//       emit(UserErrorState('Failed to save hotel booking: $e'));
//     }
//   }

//   void _onGetHotelBookings(
//       GetHotelBookingsEvent event, Emitter<UserState> emit) async {
//     try {
//       emit(UserLoadingState());
//       final hotelBookings = await repository.getHotelBookings(event.hotelId);
//       emit(UserDataLoadedState(hotelBookings));
//     } catch (e) {
//       emit(UserErrorState('Failed to load hotel bookings: $e'));
//     }
//   }
// }
 // Widget _buildBookingForm(
  //     BuildContext context, UserState state, String hotelId) {
  //   final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Form(
  //       key: _formKey,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           // Display the selected Hotel ID
  //           // UserBookingsPage(),
  //           ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).push(MaterialPageRoute(
  //                   builder: (context) => const UserBookingsPage(),
  //                 ));
  //               },
  //               child: const Text('bookings')),
  //           Text(
  //             'User ID: $currentUserId',
  //             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //           ),
  //           Text(
  //             'Booking for Hotel ID: $hotelId',
  //             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 16),
  //           // Name Input
  //           _buildTextFormField(
  //             controller: _nameController,
  //             label: 'Name',
  //             validator: (value) {
  //               if (value == null || value.isEmpty) {
  //                 return 'Please enter your name';
  //               }
  //               return null;
  //             },
  //           ),

  //           // Age Input
  //           _buildTextFormField(
  //             controller: _ageController,
  //             label: 'Age',
  //             keyboardType: TextInputType.number,
  //             validator: (value) {
  //               if (value == null || value.isEmpty) {
  //                 return 'Please enter your age';
  //               }
  //               if (int.tryParse(value) == null) {
  //                 return 'Please enter a valid number';
  //               }
  //               return null;
  //             },
  //           ),

  //           // Place Input
  //           _buildTextFormField(
  //             controller: _placeController,
  //             label: 'Place',
  //             validator: (value) {
  //               if (value == null || value.isEmpty) {
  //                 return 'Please enter your place';
  //               }
  //               return null;
  //             },
  //           ),

  //           // Conditional Loading or Submit Button
  //           _buildSubmitButton(context, state, hotelId),

  //           // Show loading indicator if state is loading
  //           if (state is UserLoadingState)
  //             const Center(child: CircularProgressIndicator()),
  //         ],
  //       ),
  //     ),
  //   );
  // }
   // _buildTextFormField(
                        //   controller: _nameController,
                        //   label: 'Name',
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your name';
                        //     }
                        //     return null;
                        //   },
                        // ),

                        // Age Input
                        // _buildTextFormField(
                        //   controller: _ageController,
                        //   label: 'Age',
                        //   keyboardType: TextInputType.number,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your age';
                        //     }
                        //     if (int.tryParse(value) == null) {
                        //       return 'Please enter a valid number';
                        //     }
                        //     return null;
                        //   },
                        // ),

                        // Place Input
                        // _buildTextFormField(
                        //   controller: _placeController,
                        //   label: 'Place',
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your place';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // _buildTextFormField(
                        //   controller: _childcontroller,
                        //   label: 'Number of childs',
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter noc ';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // _buildTextFormField(
                        //   controller: _adultcontroller,
                        //   label: 'Number of Adults',
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter noa';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // EasyDateTimeLinePicker(
                        //   firstDate: DateTime(2025, 1, 1),
                        //   lastDate: DateTime(2030, 3, 18),
                        //   focusedDate: DateTime(2025, 6, 15),
                        //   onDateChange: (date) {
                        //     // Handle the selected date.
                        //   },
                        // ),
                         // Widget _buildTextFormField({
  //   required TextEditingController controller,
  //   required String label,
  //   TextInputType keyboardType = TextInputType.text,
  //   String? Function(String?)? validator,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: TextFormField(
  //       controller: controller,
  //       decoration: InputDecoration(
  //         labelText: label,
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ),
  //       keyboardType: keyboardType,
  //       validator: validator,
  //     ),
  //   );
  // }
  
  // Widget _buildSubmitButton(
  //     BuildContext context, UserState state, String hotelId) {
  //   return ElevatedButton(
  //     onPressed: state is! UserLoadingState
  //         ? () => _submitBooking(context, hotelId)
  //         : null,
  //     style: ElevatedButton.styleFrom(
  //       padding: const EdgeInsets.symmetric(vertical: 16),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),
  //     child: const Text(
  //       'Save Booking',
  //       style: TextStyle(fontSize: 16),
  //     ),
  //   );
  // }

  // void _submitBooking(BuildContext context, String hotelId) {
  //   // Validate form
  //   if (_formKey.currentState!.validate()) {
  //     // Create UserDataModel
  //     final bookingData = UserDataModel(
  //       name: _nameController.text,
  //       age: int.parse(_ageController.text),
  //       place: _placeController.text,
  //       date: DateTime.now(),
  //       noc: 1,
  //       noa: 1,
  //     );

  //     // Dispatch SaveHotelBookingEvent
  //     context.read<UserBloc>().add(
  //           SaveHotelBookingEvent(
  //             hotelId: hotelId,
  //             bookingData: bookingData,
  //           ),
  //         );
  //   }
  // }