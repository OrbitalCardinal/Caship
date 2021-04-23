import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';  
class MyContact {
  String displayName;
  String phone;
  bool registered;
  String url;
  String initials;
  MyContact({this.displayName, this.phone, this.registered,this.initials, this.url});
}