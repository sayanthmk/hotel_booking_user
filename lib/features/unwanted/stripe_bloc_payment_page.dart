// // payment_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking/features/stripe/presentation/providers/bloc/stripepayment_bloc.dart';

// class PaymentScreen extends StatelessWidget {
//   const PaymentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => StripePaymentBloc(),
//       child: const PaymentScreenContent(),
//     );
//   }
// }

// class PaymentScreenContent extends StatelessWidget {
//   const PaymentScreenContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text('Payment'),
//         elevation: 0,
//         backgroundColor: Colors.white,
//       ),
//       body: BlocConsumer<StripePaymentBloc, StripePaymentState>(
//         listener: (context, state) {
//           if (state is StripePaymentSuccess) {
//             _showSuccessDialog(context);
//           } else if (state is StripePaymentFailure) {
//             _showErrorSnackBar(context, state.error);
//           }
//         },
//         builder: (context, state) {
//           if (state is StripePaymentLoading) {
//             return const PaymentLoadingView();
//           }

//           if (state is StripePaymentInitial) {
//             return PaymentFormView(state: state);
//           }

//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }

//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(
//                 Icons.check_circle_outline,
//                 color: Colors.green,
//                 size: 60,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Payment Successful!',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Your transaction has been completed.',
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showErrorSnackBar(BuildContext context, String error) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.error_outline, color: Colors.white),
//             const SizedBox(width: 8),
//             Expanded(child: Text('Payment failed: $error')),
//           ],
//         ),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
// }

// class PaymentLoadingView extends StatelessWidget {
//   const PaymentLoadingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const CircularProgressIndicator(),
//           const SizedBox(height: 16),
//           Text(
//             'Processing Payment...',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PaymentFormView extends StatelessWidget {
//   final StripePaymentInitial state;

//   const PaymentFormView({
//     super.key,
//     required this.state,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isValid = state.amount.isNotEmpty && state.errorMessage == null;
//     final double amount = double.tryParse(state.amount) ?? 0;

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildPaymentCard(context),
//             const SizedBox(height: 24),
//             _buildAmountInput(context),
//             if (state.errorMessage != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 8),
//                 child: Text(
//                   state.errorMessage!,
//                   style: const TextStyle(
//                     color: Colors.red,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 24),
//             _buildPaymentSummary(context, amount),
//             const SizedBox(height: 24),
//             _buildPaymentButton(context, isValid, amount),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaymentCard(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF1a1f71), Color(0xFF2d357d)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Credit Card Payment',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Icon(Icons.payment, color: Colors.white, size: 30),
//             ],
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Secured by Stripe',
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAmountInput(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Enter Amount',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             decoration: InputDecoration(
//               prefixText: '\$ ',
//               hintText: '0.00',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(
//                   color: Colors.grey.shade300,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(
//                   color: Theme.of(context).primaryColor,
//                   width: 2,
//                 ),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 16,
//               ),
//             ),
//             style: const TextStyle(fontSize: 18),
//             keyboardType: const TextInputType.numberWithOptions(decimal: true),
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
//             ],
//             onChanged: (value) {
//               context.read<StripePaymentBloc>().add(
//                     UpdateAmount(amount: value),
//                   );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentSummary(BuildContext context, double amount) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Payment Summary',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text('Amount:'),
//               Text(
//                 '\$${amount.toStringAsFixed(2)}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Total:',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '\$${amount.toStringAsFixed(2)}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1a1f71),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentButton(
//     BuildContext context,
//     bool isValid,
//     double amount,
//   ) {
//     return ElevatedButton(
//       onPressed: isValid && amount > 0
//           ? () {
//               context.read<StripePaymentBloc>().add(
//                     MakePayment(amount: amount),
//                   );
//             }
//           : null,
//       style: ElevatedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         backgroundColor: const Color(0xFF1a1f71),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.lock_outline, size: 20),
//           const SizedBox(width: 8),
//           Text(
//             'Pay \$${amount.toStringAsFixed(2)}',
//             style: const TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }
