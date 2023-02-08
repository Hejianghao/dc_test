import 'package:auto_route/auto_route.dart';
import 'package:dc_test/screens/common_widgets/button.dart';
import 'package:dc_test/styles/dc_color.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  final String url;
  const WebviewScreen({required this.url, super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController webViewController;
  @override
  void initState() {
    super.initState();
    webViewController = WebViewController();
    webViewController.setNavigationDelegate(NavigationDelegate(
      onWebResourceError: (error) {
        debugPrint('error');
      },
    ));
    webViewController.loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DCColor.paragraph,
        leading: Button(
          child: const Text(
            'Done',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            AutoRouter.of(context).pop();
          },
        ),
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
