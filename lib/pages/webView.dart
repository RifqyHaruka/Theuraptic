import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:haldac/model/appointment_model.dart';
import 'package:haldac/pages/history.dart';

import 'package:haldac/theme.dart';

class WebViewe extends StatefulWidget {
  final String? url;

  WebViewe(this.url);

  @override
  _WebVieweState createState() => _WebVieweState();
}

class _WebVieweState extends State<WebViewe> {
  @override
  void initState() {
    super.initState();
  }

  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    Widget signInButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HistoryPage()),
              (route) => false);
        },
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          width: MediaQuery.of(context).size.width - 60,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: buttonHijau),
          child: Center(
            child: Text(
              'Lihat History Transaksi',
              style: whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 600,
                child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: Uri.parse(widget.url.toString())),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                ),
              ),
              signInButton()
            ],
          ),
        ),
        //     WebView(
        //   initialUrl: widget.url,
        //   javascriptMode: JavascriptMode.unrestricted,
        // )),
      ),
    );
  }
}
