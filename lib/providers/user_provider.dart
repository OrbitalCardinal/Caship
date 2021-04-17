import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  String names;
  String lastnames;
  String country;
  String phone;
  String birthdate;
  String imgUrl;

  final String authToken;
  final String userId;

  UserProvider(this.authToken, this.userId);

  Future<Map<String,dynamic>> getUserInfo() async {
    // print(userId);
    final url = 'https://caship-2c966-default-rtdb.firebaseio.com/users.json?auth=$authToken&orderBy="userId"&equalTo="$userId"';
    final response = await http.get(url);
    // print(response.statusCode);
    final decodedResponse = json.decode(response.body) as Map<String,dynamic>;
    // print(decodedResponse[decodedResponse.keys.first]);
    names = decodedResponse[decodedResponse.keys.first]['names'];
    lastnames = decodedResponse[decodedResponse.keys.first]['lastnames'];
    country = decodedResponse[decodedResponse.keys.first]['country'];
    phone = decodedResponse[decodedResponse.keys.first]['phone'];
    birthdate = decodedResponse[decodedResponse.keys.first]['birthdate'];
    imgUrl = decodedResponse[decodedResponse.keys.first]['imgUrl'];
    return {
      "names": names,
      "lastnames": lastnames,
      "country": country,
      "phone": phone,
      "birthdate": birthdate,
      "imgUrl": imgUrl
    };
  }
}