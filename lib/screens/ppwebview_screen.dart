import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PpWebViewScreen extends StatefulWidget {
  static const routeName = "/ppwebview";
  @override
  _PpWebViewScreenState createState() => _PpWebViewScreenState();
}

class _PpWebViewScreenState extends State<PpWebViewScreen> {
  //Global variables
  WebViewController _controller;
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/pages/help.html');
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  @override
  Widget build(BuildContext context) {
    //Global variables
    String checkoutUrl = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Paypal WebView",
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        // height: 200,
        child: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          // onWebViewCreated: (WebViewController webViewController) {
          //   _controller = webViewController;
          //   _loadHtmlFromAssets();
          // },
        ),
      ),
    );
  }
}
