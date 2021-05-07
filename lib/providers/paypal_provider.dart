import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaypalProvider with ChangeNotifier {
  String executeUrl = "";

  Future<void> deleteWebProfile(String id) async {
    String access_token =
        await rootBundle.loadString('assets/files/paypal_token.txt');
    String webProfileUrl =
        "https://api-m.sandbox.paypal.com/v1/payment-experience/web-profiles/$id";
    try {
      final response = http.delete(
        webProfileUrl,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $access_token"
        },
      );
    } catch (error) {
      print("Error on deleting");
    }
  }

  Future<String> createWebProfile() async {
    String access_token =
        await rootBundle.loadString('assets/files/paypal_token.txt');
    String webProfileUrl =
        "https://api-m.sandbox.paypal.com/v1/payment-experience/web-profiles/";
    var bodymsg = json.encode({
      "name": "Caship",
      "presentation": {"logo_image": "https://www.paypal.com"},
      "input_fields": {"no_shipping": 1, "address_override": 1},
      "flow_config": {
        "landing_page_type": "billing",
        "bank_txn_pending_url": "https://www.paypal.com"
      }
    });
    final response = await http.post(webProfileUrl,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $access_token"
        },
        body: bodymsg);
    var decodedResponse = json.decode(response.body);
    print(decodedResponse);
    return decodedResponse["id"];
  }

  Future<void> executePayment(String payerId) async {
    String access_token =
        await rootBundle.loadString('assets/files/paypal_token.txt');
    final response = await http.post(executeUrl, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $access_token"
    },
    body: json.encode({
      "payer_id": "$payerId"
    }));

    //Decoded response
    var decodedResponse = json.decode(response.body);
    print(decodedResponse);
  }

  Future<Map<String, dynamic>> createPayment(double amount, bool isPay) async {
    String access_token =
        await rootBundle.loadString('assets/files/paypal_token.txt');
    String webprofile_id =
        await rootBundle.loadString('assets/files/webprofile_id.txt');
    // String webprofile_id = await createWebProfile();
    String returnText = await rootBundle.loadString('assets/pages/help.html');
    var returnUrl = Uri.dataFromString(returnText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
    String email = isPay ? "sb-xt6zf6144738@business.example.com" : "sb-3nuta6149795@personal.example.com";

    var bodymsg = json.encode({
      "intent": "authorize",
      "experience_profile_id": "$webprofile_id",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "currency": "MXN",
            "total": "$amount",
            // "details": {"subtotal": "$amount"}
          },
          "payee": {"email": "$email"},
          "description": "This is the payment transaction description.",
          "item_list": {
            "items": [
              {
                "name": "Prestamo Caship",
                "quantity": "1",
                "price": "$amount",
                "sku": "1",
                "currency": "MXN"
              }
            ],
            // "shipping_address": {
            //   "recipient_name": "Betsy customer",
            //   "line1": "111 First Street",
            //   "city": "Saratoga",
            //   "country_code": "US",
            //   "postal_code": "95070",
            //   "phone": "0116519999164",
            //   "state": "CA"
            // }
          }
        }
      ],
      "redirect_urls": {
        "return_url":
            "https://orbitalcardinal.github.io/Caship/completed_es.html",
        "cancel_url": "https://orbitalcardinal.github.io/Caship/cancel_es.html"
      }
    });
    print(webprofile_id);
    String payment_url = "https://api-m.sandbox.paypal.com/v1/payments/payment";
    final response = await http.post(payment_url,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $access_token"
        },
        body: bodymsg);

    //Decoded response
    var decodedResponse = json.decode(response.body);
    executeUrl = decodedResponse["links"][2]["href"];
    notifyListeners();
    print(decodedResponse);
    return {
      "checkoutUrl": decodedResponse["links"][1]["href"],
      "executeUrl": decodedResponse["links"][2]["href"],
      "webprofile_id": webprofile_id
    };
  }
}
