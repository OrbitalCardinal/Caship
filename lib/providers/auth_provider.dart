import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB1oRCm_Ga8RCZezRd38pMJBBMaOU3EB-I';
    const verifyUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyB1oRCm_Ga8RCZezRd38pMJBBMaOU3EB-I';

    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );

    // print(json.decode(response.body));

    if (response.statusCode >= 400) {
      throw HttpException('Hubo un problema al intentar registrarse');
    } else {
      final emailResponse = await http.post(verifyUrl,
          body: json.encode({
            'requestType': "VERIFY_EMAIL",
            'idToken': json.decode(response.body)['idToken'],
          }));
    }
  }

  Future<void> login(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyB1oRCm_Ga8RCZezRd38pMJBBMaOU3EB-I';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    var decodedResponse = json.decode(response.body);
    print(decodedResponse);
    if (response.statusCode >= 400) {
      final String message = decodedResponse['error']['message'];
      throw HttpException(message);
    } else {
      const userUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyB1oRCm_Ga8RCZezRd38pMJBBMaOU3EB-I';
      final userResponse = await http.post(userUrl, body: json.encode({
        'idToken': decodedResponse['idToken']
      }));
      var decodedUserResponse = json.decode(userResponse.body);
      print(decodedUserResponse);
      if(!decodedUserResponse['users'][0]['emailVerified']) {
        throw HttpException('NOT_VERIFIED');
      } 
    }
  }
}
