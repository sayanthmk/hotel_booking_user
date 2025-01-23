import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_booking/bloc_section.dart';
import 'package:hotel_booking/core/constants/gemini_ai_api_key.dart';
import 'package:hotel_booking/core/constants/stripe_keys.dart';
import 'package:hotel_booking/core/dependency_injection/injection_container.dart'
    as di;
import 'package:hotel_booking/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  Gemini.init(apiKey: geminiApiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocSection();
  }
}
