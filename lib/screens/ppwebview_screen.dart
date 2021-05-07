import 'dart:convert';
import 'dart:io';
import 'package:Caship/providers/paypal_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../screens/home_screen.dart';
import 'package:http/http.dart' as http;

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
    Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
    String checkoutUrl = args["checkoutUrl"];
    String executeUrl = args["executeUrl"];
    String transactionId = args["transactionId"];
    bool isPay = args["transaction"].contains("pay");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).payLending,
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        leading: isPay ? IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          },
        ) : IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.blue,
          onPressed: () {
            // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          },
        ),
      ),
      body: Container(
        // height: 200,
        child: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
            _controller.clearCache();
          },
          onPageFinished: (url) {
            // print(url.split("&")[2].split("=")[1]);
           if(url.contains("https://orbitalcardinal.github.io/Caship/completed_es.html")) {
              if(isPay) {
                Provider.of<TransactionProvider>(context, listen: false).completeTransaction(transactionId);             
                Provider.of<PaypalProvider>(context,listen:false).executePayment(url.split("&")[2].split("=")[1]);
              } else {
                Provider.of<PaypalProvider>(context,listen:false).executePayment(url.split("&")[2].split("=")[1]);
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              }
              final cookieManager = CookieManager();
              cookieManager.clearCookies();
           }
          },
        ),
      ),
    );
  }
}
