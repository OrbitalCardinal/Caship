import 'package:Caship/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password, String userType) async {
    bool isLender = false;
    if(userType.contains("Lender")) {
      isLender = !isLender;
    }
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

    String uuid = json.decode(response.body)["localId"];

    if (response.statusCode >= 400) {
      throw HttpException('Hubo un problema al intentar registrarse');
    } else {
      final emailResponse = await http.post(verifyUrl,
          body: json.encode({
            'requestType': "VERIFY_EMAIL",
            'idToken': json.decode(response.body)['idToken'],
          }));
      if(emailResponse.statusCode >= 400) {
        throw HttpException('Hubo un problema al intentar enviar el correo de verficación');
      } else {
        String dbURL = "https://caship-2c966-default-rtdb.firebaseio.com/users.json";
        final userTypeResponse = await http.post(dbURL, body: json.encode(
          {
            "userId": uuid,
            "isLender": isLender
          }
        ));
      }
    }
  }

  Future<void> login(String email, String password, String userType, BuildContext context) async {
    bool isLender = false;
    if(userType.contains("Lender")) {
      isLender = !isLender;
    }
    // print(userType);
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
    String uuid = decodedResponse["localId"];

    if (response.statusCode >= 400) {
      final String message = decodedResponse['error']['message'];
      throw HttpException(message);
    } else {
        final retrieveData = await http.get("https://caship-2c966-default-rtdb.firebaseio.com/users.json");
        final retDecoded = jsonDecode(retrieveData.body);
        List<Map> listUsers = [];
        retDecoded.forEach((k,v) => listUsers.add(v));

        var userRet = listUsers.where((element) => element["userId"].contains(uuid)).toList()[0];
        // print(isLender);
        // print(userRet["isLender"]);
        if(userRet["isLender"] == isLender) {
          const userUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyB1oRCm_Ga8RCZezRd38pMJBBMaOU3EB-I';
          final userResponse = await http.post(userUrl, body: json.encode({
            'idToken': decodedResponse['idToken']
          }));
          var decodedUserResponse = json.decode(userResponse.body);
          print(decodedUserResponse);
          if(!decodedUserResponse['users'][0]['emailVerified']) {
            throw HttpException('Cuenta no verificada');
          } 
      
          Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName,(route) => false);

        } else {
          throw HttpException("Tipo de usuario erroneo");
        }
    }
  }
}
