import 'package:flutter/cupertino.dart';

class Transaction {
  String id;
  String requesterId;
  String lenderId;
  double amount;
  DateTime requestDate;
  DateTime finishDate;
  String details;
  String status;
  String requesterName;
  String lenderName;
  int timeTerm;

  Transaction({
    @required this.id,
    @required this.requesterId,
    @required this.lenderId,
    @required this.amount, 
    @required this.requestDate,
    @required this.finishDate,
    @required this.details,
    @required this.status,
    @required this.requesterName,
    @required this.lenderName,
    @required this.timeTerm
  });
}

