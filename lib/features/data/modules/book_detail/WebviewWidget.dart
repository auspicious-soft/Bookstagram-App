import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String title;
  final String url;

  const WebView({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            // Optional: Show a loading indicator when the page starts loading
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            // Check if the URL indicates a success or failure
            if (_isPaymentSuccessUrl(url)) {
              // Payment successful, navigate back with result
              Navigator.pop(context, {'status': 'success', 'url': url});
            } else if (_isPaymentFailureUrl(url)) {
              // Payment failed, navigate back with result
              Navigator.pop(context, {'status': 'failed', 'url': url});
            }
          },
          onWebResourceError: (WebResourceError error) {
            // Handle WebView errors (e.g., network issues)
            print('WebView error: ${error.description}');
            Navigator.pop(context, {
              'status': 'error',
              'message': error.description,
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  // Helper function to check if the URL is a success URL
  bool _isPaymentSuccessUrl(String url) {
    // Replace these with the actual success URL patterns from your payment gateway
    return url.contains('success') ||
        url.contains('payment_status=success') ||
        url.contains('your-app.com/success');
  }

  // Helper function to check if the URL is a failure URL
  bool _isPaymentFailureUrl(String url) {
    // Replace these with the actual failure URL patterns from your payment gateway
    return url.contains('failure') ||
        url.contains('payment_status=failed') ||
        url.contains('your-app.com/failure') ||
        url.contains('error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: WebViewWidget(controller: _controller),
    );
  }
}
