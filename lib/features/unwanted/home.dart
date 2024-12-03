// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/pages/selected_hotel/sample_det.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';

// class HotelListPage extends StatelessWidget {
//   const HotelListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Load hotels when the page is built
//     context.read<HotelBloc>().add(LoadHotelsEvent());

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hotel List'),
//       ),
//       body: BlocBuilder<HotelBloc, HotelState>(
//         builder: (context, state) {
//           if (state is HotelLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is HotelErrorState) {
//             return Center(child: Text(state.message));
//           } else if (state is HotelLoadedState) {
//             final hotels = state.hotels;
//             return ListView.builder(
//               itemCount: hotels.length,
//               itemBuilder: (context, index) {
//                 final hotel = hotels[index];
//                 return ListTile(
//                   // title: Text('hello'),
//                   title: Text(hotel.hotelName),
//                   subtitle: Text(hotel.hotelId),
//                   onTap: () {
//                     context
//                         .read<SelectedHotelBloc>()
//                         .add(SelectHotelEvent(hotel));
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const HotelDetailsPage(),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//           return const Center(child: Text('No data available'));
//         },
//       ),
//     );
//   }
// }
//    // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (_) => BlocProvider.value(
//                     //       value: sl<HotelBloc>()
//                     //         ..add(LoadHotelByIdEvent(hotel.hotelId)),
//                     //       child: HotelDetailPage(hotelId: hotel.hotelId),
//                     //     ),
//                     //   ),
//                     // );
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:rentit/features/home/domain/entity/car_entity.dart';
// // import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
// // import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_event.dart';
// // import 'package:rentit/utils/appcolors.dart';
// // import 'package:rentit/widgets/custom_container.dart';

// // class CarCard extends StatelessWidget {
// //   final CarVehicleEntity car;

// //   const CarCard({
// //     super.key,
// //     required this.car,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         context.read<SelectedCarBloc>().add(SelectCar(car));
// //         context.push('/carDetailPage');
// //       },
// //       child: Padding(
// //         padding: const EdgeInsets.all(5.0),
// //         child: Container(
// //           padding: const EdgeInsets.all(16),
// //           margin: const EdgeInsets.only(bottom: 16),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(16),
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Stack(
// //                 children: [
// //                   Container(
// //                     decoration: BoxDecoration(
// //                         color: ExternalAppColors.bg,
// //                         borderRadius: BorderRadius.circular(16)),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: ClipRRect(
// //                         borderRadius: BorderRadius.circular(16),
// //                         child: Image.network(
// //                           car.imageUrls.last,
// //                           width: double.infinity,
// //                           height: 200,
// //                           fit: BoxFit.cover,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   Positioned(
// //                     top: 15,
// //                     left: 15,
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 8, vertical: 4),
// //                       decoration: BoxDecoration(
// //                         color: Colors.black.withOpacity(0.5),
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                       child: const Row(
// //                         children: [
// //                           Icon(Icons.star, color: Colors.yellow, size: 16),
// //                           SizedBox(width: 4),
// //                           Text(
// //                             '4.9',
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   Positioned(
// //                     top: 15,
// //                     right: 15,
// //                     child: IconButton(
// //                       icon: const Icon(Icons.favorite_border,
// //                           color: Colors.black),
// //                       onPressed: () {},
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 16),
// //               CustomContainer(text: car.body),
// //               const SizedBox(height: 8),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(car.make,
// //                       style: const TextStyle(
// //                           fontWeight: FontWeight.bold, fontSize: 18)),
// //                   RichText(
// //                     text: TextSpan(
// //                       children: [
// //                         TextSpan(
// //                           text:
// //                               '₹${car.rentalPriceRange.start.toStringAsFixed(2)}',
// //                           style: TextStyle(
// //                             color: ExternalAppColors.blue,
// //                             fontSize: 20,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         TextSpan(
// //                           text: '/day',
// //                           style: TextStyle(
// //                               color: ExternalAppColors.grey,
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.w600),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               Divider(
// //                 color: ExternalAppColors.bg,
// //                 thickness: 1,
// //               ),
// //               const SizedBox(height: 8),
// //               Row(
// //                 children: [
// //                   const SizedBox(width: 20),
// //                   const Icon(
// //                     Icons.local_gas_station,
// //                     size: 16,
// //                     color: Colors.blue,
// //                   ),
// //                   Text(car.engine),
// //                   const SizedBox(width: 90),
// //                   const SizedBox(width: 8),
// //                   const Icon(
// //                     Icons.person,
// //                     size: 16,
// //                     color: Colors.blue,
// //                   ),
// //                   Text('${car.seatCapacity} Seats'),
// //                   const SizedBox(width: 90),
// //                   const Icon(
// //                     Icons.adjust_outlined,
// //                     size: 16,
// //                     color: Colors.blue,
// //                   ),
// //                   const SizedBox(width: 8),
// //                   const Text('Manual', style: TextStyle(color: Colors.black)),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
// // import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_state.dart';
// // import 'package:rentit/features/home/presentation/pages/widgets/rating.dart';
// // import 'package:rentit/features/home/presentation/pages/widgets/tapbar.dart';
// // import 'package:rentit/features/rental/presentation/pages/rental/widgets/booknowbutton.dart';
// // import 'package:rentit/utils/appcolors.dart';
// // import 'package:rentit/utils/primary_text.dart';
// // import 'package:rentit/widgets/custom_carbody_container.dart';

// // class CarDetailPage extends StatelessWidget {
// //   const CarDetailPage({
// //     super.key,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<SelectedCarBloc, SelectedCarState>(
// //       builder: (context, state) {
// //         if (state is CarSelected) {
// //           final car = state.car;
// //           debugPrint('Car updated: ${state.car.make} ${state.car.model}');

// //           return Scaffold(
// //             backgroundColor: ExternalAppColors.bg,
// //             appBar: AppBar(
// //               backgroundColor: ExternalAppColors.bg,
// //               leading: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                       shape: BoxShape.circle, color: ExternalAppColors.white),
// //                   child: IconButton(
// //                     icon: const Icon(Icons.arrow_back),
// //                     onPressed: () => context.pop(),
// //                   ),
// //                 ),
// //               ),
// //               title: PrimaryText(
// //                 text: "Car Details",
// //                 color: ExternalAppColors.black,
// //               ),
// //               centerTitle: true,
// //               // actions: [
// //               //   Padding(
// //               //     padding: const EdgeInsets.all(6.0),
// //               //     child: Container(
// //               //         decoration: BoxDecoration(
// //               //             shape: BoxShape.circle,
// //               //             color: ExternalAppColors.white),
// //               //         child: IconButton(
// //               //             icon: const Icon(Icons.share), onPressed: () {})),
// //               //   ),
// //               //   Padding(
// //               //     padding: const EdgeInsets.all(6.0),
// //               //     child: Container(
// //               //         decoration: BoxDecoration(
// //               //             shape: BoxShape.circle,
// //               //             color: ExternalAppColors.white),
// //               //         child: IconButton(
// //               //             icon: const Icon(Icons.favorite_outline),
// //               //             onPressed: () {})),
// //               //   ),
// //               // ],
// //             ),
// //             body: Column(
// //               children: [
// //                 Expanded(
// //                   child: ListView(
// //                     children: [
// //                       Center(
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(8.0),
// //                           child: ClipRRect(
// //                             borderRadius: BorderRadius.circular(15),
// //                             child: Image.network(car.imageUrls.last,
// //                                 fit: BoxFit.cover),
// //                           ),
// //                         ),
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                               borderRadius: BorderRadius.circular(10),
// //                               color: ExternalAppColors.white),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(8.0),
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 const SizedBox(height: 16),
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     CustomCarBodyContainer(
// //                                       text: car.body.toUpperCase(),
// //                                     ),
// //                                     const StarRating(
// //                                       rating: 4.9,
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 const SizedBox(height: 20),
// //                                 Row(
// //                                   children: [
// //                                     PrimaryText(
// //                                       text: car.make.toUpperCase(),
// //                                       size: 24,
// //                                       fontWeight: FontWeight.bold,
// //                                       color: ExternalAppColors.black,
// //                                     ),
// //                                     PrimaryText(
// //                                       text: ' - ${car.model.toUpperCase()}',
// //                                       size: 24,
// //                                       fontWeight: FontWeight.bold,
// //                                       color: ExternalAppColors.black,
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 const SizedBox(height: 16),
// //                                 const TabBarSection(),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       const SizedBox(
// //                         height: 10,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: ListTile(
// //                       splashColor: Colors.amber,
// //                       tileColor: ExternalAppColors.white,
// //                       contentPadding: const EdgeInsets.all(15),
// //                       shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(10)),
// //                       title: const Text(
// //                         'Price:',
// //                         style: TextStyle(
// //                           fontSize: 19,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       subtitle: RichText(
// //                         text: TextSpan(
// //                           children: [
// //                             TextSpan(
// //                               text:
// //                                   '\₹${car.rentalPriceRange.start.toStringAsFixed(2)}',
// //                               style: TextStyle(
// //                                 color: ExternalAppColors.blue,
// //                                 fontSize: 20,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             TextSpan(
// //                               text: '/day',
// //                               style: TextStyle(
// //                                   color: ExternalAppColors.grey,
// //                                   fontSize: 18,
// //                                   fontWeight: FontWeight.w600),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       trailing: BookNowButton(
// //                         onPressed: () {
// //                           context.push("/bookingContinuePage");
// //                         },
// //                       )
// //                       // BookingButton(carId: car.carId),
// //                       ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         } else {
// //           return const Center(child: CircularProgressIndicator());
// //         }
// //       },
// //     );
// //   }
// // }
// // // ignore_for_file: avoid_print
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:rentit/features/home/data/model/carvehicle_model.dart';
// // import 'package:rentit/features/home/domain/entity/car_entity.dart';
// // import 'package:rentit/features/home/domain/usecases/getcar_usecase.dart';
// // import 'package:rentit/features/home/domain/usecases/search_filter_usecases.dart';
// // import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
// // import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';

// // class CarBloc extends Bloc<CarEvent, CarState> {
// //   final GetCarsStreamUseCase getCarsStreamUseCase;
// //     final SearchCarsUsecase searchCarsUsecase;
// //   final FilterCarsUsecase filterCarsUsecase;


// // //==========Constructor DI===========================
// //   CarBloc({required this.getCarsStreamUseCase, required this.searchCarsUsecase,
// //     required this.filterCarsUsecase,}) : super(CarInitial()) {
// // //============EVENT HANDER=========================
// //     on<FetchCars>(onFetchCars);
// //     on<RefreshCars>(onRefreshCars);
// //     on<SearchCars>(_onSearchCars);
// //     on<FilterCars>(_onFilterCars);
// //   }

// //   onFetchCars(FetchCars event, Emitter<CarState> emit) async {
// //     emit(CarLoading());
// //     try {
// //       final cars = getCarsStreamUseCase();
// //       await emit.forEach<List<CarVehicleEntity>>(
// //         cars,
// //         onData: (cars) => CarLoaded(cars),
// //         onError: (error, stackTrace) => CarError(error.toString()),
// //       );
// //     } catch (e) {
// //       debugPrint("Error in onFetchCars: $e");
// //       emit(CarError(e.toString()));
// //     }
// //   }

// //   onRefreshCars(RefreshCars event, Emitter<CarState> emit) async {
// //     emit(CarLoading());
// //     try {
// //       final cars = getCarsStreamUseCase();
// //       await emit.forEach<List<CarVehicleEntity>>(
// //         cars,
// //         onData: (cars) => CarLoaded(cars),
// //         onError: (error, stackTrace) => CarError(error.toString()),
// //       );
// //     } catch (e) {
// //       debugPrint("Error in onRefreshCars: $e");
// //       emit(CarError(e.toString()));
// //     }
// //   }
 
// //  void _onSearchCars(SearchCars event, Emitter<CarState> emit) async {
// //   print('Searching for cars with term: ${event.searchTerm}');
// //   emit(CarLoading());
// //   try {
// //     await emit.forEach(
// //       searchCarsUsecase.call(event.searchTerm),
// //       onData: (List<CarVehicleModel> cars) {
// //         print('Cars found: ${cars.length}');
// //         return CarSearchLoaded(cars);
// //       },
// //       onError: (error, stackTrace) {
// //         print('Search error: $error');
// //         return CarError(error.toString());
// //       },
// //     );
// //   } catch (e) {
// //     print('Exception during search: $e');
// //     emit(CarError(e.toString()));
// //   }
// // }


// //   void _onFilterCars(FilterCars event, Emitter<CarState> emit) async {
// //     emit(CarLoading());
// //     try {
// //       await emit.forEach(
// //         filterCarsUsecase.call(
// //           make: event.make,
// //           model: event.model,
// //          // priceRange: event.priceRange,
// //           year: event.year,
// //         ),
// //         onData: (List<CarVehicleModel> cars) => CarSearchLoaded(cars),
// //         onError: (error, stackTrace) => CarError( error.toString()),
// //       );
// //     } catch (e) {
// //       emit(CarError( e.toString()));
// //     }
// //   }
// // }
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_event.dart';
// // import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_state.dart';

// // class SelectedCarBloc extends Bloc<SelectedCarEvent, SelectedCarState> {
// //   SelectedCarBloc() : super(SelectedCarInitial()) {
// //     on<SelectCar>((event, emit) {
// //       emit(CarSelected(event.selectedCar));
// //     });
// //   }
// // }








// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
// import 'package:hotel_booking/features/home/presentation/pages/detailed_page/detail_page.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_bloc.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_event.dart';
// import 'package:hotel_booking/features/home/presentation/providers/hotel_bloc/hotel_state.dart';
// import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';

// class HotelsListView extends StatelessWidget {
//   const HotelsListView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => GetIt.I<HotelBloc>()..add(LoadHotelsEvent()),
//         child: BlocBuilder<HotelBloc, HotelState>(builder: (context, state) {
//           if (state is HotelLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is HotelLoadedState) {
//             return SizedBox(
//               height: 280,
//               child: Material(
//                 color: HotelBookingColors.pagebackgroundcolor,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: state.hotels.length,
//                     itemBuilder: (context, index) {
//                       HotelEntity hotel = state.hotels[index];
//                       return InkWell(
//                         onTap: () {
//                           context
//                               .read<SelectedHotelBloc>()
//                               .add(SelectHotelEvent(hotel));
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const HotelDetailPage(),
//                             ),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Container(
//                             width: 200,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   fit: BoxFit.contain,
//                                   image: NetworkImage(
//                                     hotel.images[0],
//                                   )),
//                               color: HotelBookingColors.pagebackgroundcolor,
//                               borderRadius: BorderRadius.circular(20),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   spreadRadius: 1,
//                                   blurRadius: 4,
//                                   offset: const Offset(2, 2),
//                                 ),
//                               ],
//                             ),
//                             margin: const EdgeInsets.symmetric(horizontal: 5),
//                             // child: Column(
//                             //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             //   // crossAxisAlignment: CrossAxisAlignment.start,
//                             //   children: [
//                             //     // Center(
//                             //     //   child: Container(
//                             //     //     decoration: BoxDecoration(
//                             //     //       color: Colors.blueGrey,
//                             //     //       borderRadius: BorderRadius.circular(15),
//                             //     //     ),
//                             //     //     clipBehavior: Clip.antiAlias,
//                             //     //     height: 140,
//                             //     //     width: 180,
//                             //     //     child: hotel.images.isNotEmpty
//                             //     //         ? Image.network(
//                             //     //             hotel.images[0],
//                             //     //             fit: BoxFit.cover,
//                             //     //             errorBuilder:
//                             //     //                 (context, error, stackTrace) {
//                             //     //               return const Center(
//                             //     //                 child: Icon(
//                             //     //                   Icons.error_outline,
//                             //     //                   color: Colors.red,
//                             //     //                 ),
//                             //     //               );
//                             //     //             },
//                             //     //             loadingBuilder: (context, child,
//                             //     //                 loadingProgress) {
//                             //     //               if (loadingProgress == null) {
//                             //     //                 return child;
//                             //     //               }
//                             //     //               return const Center(
//                             //     //                 child:
//                             //     //                     CircularProgressIndicator(),
//                             //     //               );
//                             //     //             },
//                             //     //           )
//                             //     //         : const Center(
//                             //     //             child: Icon(
//                             //     //               Icons.image_not_supported,
//                             //     //               color: Colors.grey,
//                             //     //             ),
//                             //     //           ),
//                             //     //   ),
//                             //     // ),
//                             //     Padding(
//                             //       padding: const EdgeInsets.symmetric(
//                             //           horizontal: 8.0),
//                             //       child: Column(
//                             //         crossAxisAlignment:
//                             //             CrossAxisAlignment.start,
//                             //         children: [
//                             //           Text(
//                             //             hotel.hotelName,
//                             //             style: const TextStyle(
//                             //               fontSize: 16,
//                             //               fontWeight: FontWeight.bold,
//                             //               color: Colors.black,
//                             //             ),
//                             //           ),
//                             //           Text(
//                             //             '${hotel.city}, ${hotel.state}',
//                             //             style: const TextStyle(
//                             //               color: Color.fromARGB(
//                             //                   255, 130, 125, 125),
//                             //               fontSize: 12,
//                             //             ),
//                             //           ),
//                             //         ],
//                             //       ),
//                             //     ),
//                             //     Padding(
//                             //       padding: const EdgeInsets.symmetric(
//                             //           horizontal: 8.0),
//                             //       child: Row(
//                             //         mainAxisAlignment:
//                             //             MainAxisAlignment.spaceBetween,
//                             //         children: [
//                             //           Row(
//                             //             children: [
//                             //               Text(
//                             //                 '\u20B9${hotel.propertySetup}',
//                             //                 style: const TextStyle(
//                             //                   color: Color(0xFF1E91B6),
//                             //                   fontWeight: FontWeight.bold,
//                             //                 ),
//                             //               ),
//                             //               const SizedBox(width: 5),
//                             //               Text(
//                             //                 '\u20B9${(int.parse(hotel.propertySetup) + 500).toString()}',
//                             //                 style: const TextStyle(
//                             //                   decoration:
//                             //                       TextDecoration.lineThrough,
//                             //                   color: Colors.black,
//                             //                 ),
//                             //               ),
//                             //             ],
//                             //           ),
//                             //           Container(
//                             //             height: 20,
//                             //             width: 40,
//                             //             decoration: BoxDecoration(
//                             //               color: Colors.indigo,
//                             //               borderRadius:
//                             //                   BorderRadius.circular(5),
//                             //             ),
//                             //             child: const Row(
//                             //               children: [
//                             //                 Icon(
//                             //                   Icons.star,
//                             //                   size: 15,
//                             //                   color: Colors.yellow,
//                             //                 ),
//                             //                 Center(
//                             //                   child: Text(
//                             //                     '3.5',
//                             //                     style: TextStyle(
//                             //                       color: Colors.white,
//                             //                       fontSize: 13,
//                             //                     ),
//                             //                   ),
//                             //                 ),
//                             //               ],
//                             //             ),
//                             //           ),
//                             //         ],
//                             //       ),
//                             //     ),
//                             //   ],
//                             // ),
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//             );
//           } else if (state is HotelErrorState) {
//             return Center(
//               child: Text(
//                 state.message,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           }
//           return const Center(child: Text('No hotels found'));
//         }));
//   }
// }
