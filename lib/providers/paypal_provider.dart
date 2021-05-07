import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaypalProvider with ChangeNotifier {
  Future<String> createWebExperienceProfile(double amount) async {
    String access_token =
        await rootBundle.loadString('assets/files/paypal_token.txt');
    String webprofile_id =
        await rootBundle.loadString('assets/files/webprofile_id.txt');
    String returnText = await rootBundle.loadString('assets/pages/help.html');
    var returnUrl = Uri.dataFromString(returnText, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString();

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
          "payee": {"email": "merchant@example.com"},
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
        "return_url": "https://example.com",
        "cancel_url": "https://example.com"
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
    return decodedResponse["links"][1]["href"];
  }
}
