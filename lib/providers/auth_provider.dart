import 'package:Caship/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  String _userType;

  bool get isAuth {
    return _token != null;
  }

  String get userType {
    return _userType;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if(_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null) {
      return _token;
    } 
  }


  Future<void> signup(String email, String password, String userType, Map<String, dynamic> data) async {
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
    
    notifyListeners();
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
            "isLender": isLender,
            "names": data["names"],
            "lastnames": data["lastnames"],
            "country": data["country"],
            "birthdate": data["birthdate"].toIso8601String(),
            "phone": data["phone"],
            "imgUrl": "https://eitrawmaterials.eu/wp-content/uploads/2016/09/empty-avatar.jpg"
          }
        ));
        print(userTypeResponse.statusCode);
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
    _token = json.decode(response.body)["idToken"];
    _userId = uuid;
    // print(_userId);
    _expiryDate = DateTime.now().add(Duration(seconds: int.parse(json.decode(response.body)["expiresIn"])));
    _userType = userType;
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
          final prefs = await SharedPreferences.getInstance();
          final userData = json.encode({'token': _token, 'userId': _userId, 'expiryDate': _expiryDate.toIso8601String(), 'userType': userType});
          prefs.setString('userData', userData);
          // autologout();
          notifyListeners();
          Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName,(route) => false, arguments: userType);
        } else {
          throw HttpException("Tipo de usuario erroneo");
        }
    }
  }

  void logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    // prefs.clear();
    notifyListeners();
  }

    Future<bool> tryAutoLogin() async {
      final prefs = await SharedPreferences.getInstance();
      if(!prefs.containsKey('userData')) {
        return false;
      }
      final extractedUserData = json.decode(prefs.getString('userData'));
      final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
      if(expiryDate.isBefore(DateTime.now())) {
        return false;
      }
      _token = extractedUserData['token'];
      // print(_token);
      _userId = extractedUserData['userId'];
      print(_userId);
      _expiryDate = expiryDate;
      notifyListeners();
      return true;
    }

    Future<String> getUserId() async {
      final prefs = await SharedPreferences.getInstance();
      if(!prefs.containsKey('userData')) {
        return "";
      }
      final extractedUserData = json.decode(prefs.getString('userData'));
      final userId = extractedUserData['userId'];
      return userId;
    }



  // void autologout() {
  //   if(_authTimer != null) {
  //     _authTimer.cancel();
  //   }
  //   final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: 3),logout);
  //   notifyListeners();
  // }
}
