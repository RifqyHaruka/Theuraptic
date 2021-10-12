import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haldac/model/appointment_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewe extends StatefulWidget {
  final String? url;

  WebViewe(this.url);

  @override
  _WebVieweState createState() => _WebVieweState();
}

class _WebVieweState extends State<WebViewe> {
  @override
  void initState() {
    WebView.platform = WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      )),
    );
  }
}
