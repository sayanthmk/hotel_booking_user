import 'package:flutter/material.dart';
import 'package:hotel_booking/utils/custom_appbar/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  TermsConditionsState createState() => TermsConditionsState();
}

class TermsConditionsState extends State<TermsConditions> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.freeprivacypolicy.com/live/c7a8cca6-3c89-4316-980a-8067abd252be'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BookingAppbar(heading: 'Terms&Conditions'),
      body: WebViewWidget(controller: _controller),
    );
  }
}
