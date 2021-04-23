import 'package:Caship/models/contact.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class ContactProvider with ChangeNotifier {
  List<dynamic> _favorites;

  List<dynamic> get favorites {
    return _favorites;
  }
  Future<List<MyContact>> retrieveContacts()  async {
    List<MyContact> formatted_contacts = [];
    final permission = await Permission.contacts.status;
    bool isPermitted = false;
    // Get all contacts on device
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      final newPermission = await Permission.contacts.request();
    } else {
      Iterable<Contact> contacts =
          await ContactsService.getContacts();
      contacts.forEach((contact) {
        var phone = '---';
        try {
          phone = contact.phones.first.value
              .replaceAll(' ', '')
              .replaceAll('+', '');
          var trim_len = phone.length - 10;
          phone = phone.substring(trim_len);
          phone = '52' + phone;
          // print(phone);
        } catch (error) {
          phone = '---';
        }
        
        formatted_contacts
            .add(MyContact(displayName: contact.displayName, phone: phone,registered: false,initials: contact.initials()));
      });
      
    }

    // Checking in db
    // for(var i=0; i<formatted_contacts.length; i++) {
    //   String url = 'https://caship-2c966-default-rtdb.firebaseio.com/users.json?&orderBy="phone"&equalTo="$formatted_contacts[i].phone"';
    //   var phoneCheckResponse = await http.get(url);
    // }
  return formatted_contacts;
  }

  Future<Map<String,dynamic>> checkRegister(String phone) async {
    String url = 'https://caship-2c966-default-rtdb.firebaseio.com/users.json?&orderBy="phone"&equalTo="$phone"';
      var phoneCheckResponse = await http.get(url);
      Map<String, dynamic> decodedPhoneResponse = json.decode(phoneCheckResponse.body) as Map<String, dynamic>;
      if(decodedPhoneResponse.isEmpty) {
        return {};
      }
      return decodedPhoneResponse;
  }

  Future<List<dynamic>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
      if(!prefs.containsKey('userData')) {
        return [];
      }
      final extractedUserData = json.decode(prefs.getString('userData'));
      final userId = extractedUserData['userId'];

     String url = 'https://caship-2c966-default-rtdb.firebaseio.com/users.json?&orderBy="userId"&equalTo="$userId"';
     var retrieveResponse = await http.get(url);
     Map<String,dynamic> decodedRetrieve = json.decode(retrieveResponse.body);
     print(decodedRetrieve);
     List<dynamic> favorites = decodedRetrieve[decodedRetrieve.keys.first]['favorites'];
     return favorites;
    //  var response = await http.patch(url, body: json.encode({
    //    "favorites": []
    //  }));
    //  print(decodedResponse);
  }

  setFavorites(String phone) async {
    final prefs = await SharedPreferences.getInstance();
      if(!prefs.containsKey('userData')) {
        return false;
      }
      final extractedUserData = json.decode(prefs.getString('userData'));
      final userId = extractedUserData['userId'];

      String retrieveUrl = 'https://caship-2c966-default-rtdb.firebaseio.com/users.json?&orderBy="userId"&equalTo="$userId"';
     var retrieveResponse = await http.get(retrieveUrl);
     Map<String,dynamic> decodedRetrieve = json.decode(retrieveResponse.body);
     List<dynamic> newFavorites = [];
     List<dynamic> previousFavorites = decodedRetrieve[decodedRetrieve.keys.first]['favorites'];
     print(decodedRetrieve);
     if(previousFavorites == null) {
       newFavorites.add(phone);
     } else {
       if(previousFavorites.contains(phone)) {
         previousFavorites.remove(phone);
         newFavorites = previousFavorites;
       } else {
        newFavorites = [...previousFavorites];
        newFavorites.add(phone);
       }
     }

     String url = 'https://caship-2c966-default-rtdb.firebaseio.com/users/${decodedRetrieve.keys.first}.json';
     var patchResponse = await http.patch(url, body: json.encode({
       "favorites": newFavorites
     }));
     Map<String,dynamic> decodedPatch = json.decode(patchResponse.body);
     _favorites = newFavorites;
     notifyListeners();
     print(decodedPatch);
    //  print(decodedRetrieve);
    //  List<dynamic> favorites = decodedRetrieve[decodedRetrieve.keys.first]['favorites'];
    //  print(favorites);
    //  var response = await http.patch(url, body: json.encode({
    //    "favorites": []
    //  }));
    //  print(decodedResponse);
  }
}


