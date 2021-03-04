import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TermsProvider with ChangeNotifier {
  String terms = '';

  String get termsandconditions {
    return terms;
  }

  Future<void> loadTerms() async {
    terms = await rootBundle.loadString('assets/files/TermsAndConditions.txt');
    notifyListeners();
  }
}