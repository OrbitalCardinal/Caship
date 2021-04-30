import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../models/transactions.dart';
import './user_provider.dart';

class TransactionProvider with ChangeNotifier {

  Future<void> saveTransaction(BuildContext context, String requesterId, String lenderId, double amount, DateTime requestDate, DateTime finishDate, String details, String status, int timeTerm) async {
    //Get users info
    var requesterInfo = await Provider.of<UserProvider>(context, listen: false).getGlobalUserInfo(requesterId);
    var lenderInfo = await Provider.of<UserProvider>(context, listen: false).getGlobalUserInfo(lenderId);

    String transUrl = 'https://caship-2c966-default-rtdb.firebaseio.com/transactions.json';
    var transResponse = await http.post(transUrl, body: json.encode({
      "requesterId": requesterId,
      "lenderId": lenderId,
      "amount": amount,
      "requestDate": requestDate.toIso8601String(),
      "finishDate": finishDate.toIso8601String(),
      "details": details,
      "status": status,
      "lenderName": lenderInfo['names'] + " " + lenderInfo["lastnames"],
      "requesterName": requesterInfo['names'] + ' ' + requesterInfo['lastnames'],
      "timeTerm": timeTerm
    }));
    Map<String, dynamic> decodedTransResponse = json.decode(transResponse.body);
    print(decodedTransResponse);
  }

  Future<List<Transaction>> getRequesterTransactions(String userId) async {
    String getTransUrl = 'https://caship-2c966-default-rtdb.firebaseio.com/transactions.json?&orderBy="requesterId"&equalTo="$userId"';
    var getTransResponse = await http.get(getTransUrl);
    Map<String, dynamic> decodedGetTransResponse = json.decode(getTransResponse.body);
    List<Transaction> transactions = [];
    decodedGetTransResponse.forEach((objectId, body) { 
      transactions.add(Transaction(
        id: objectId,
        requesterId: body['requesterId'],
        lenderId: body['lenderId'],
        amount: body['amount'],
        requestDate: DateTime.parse(body['requestDate']) ,
        finishDate: DateTime.parse(body['finishDate']) ,
        details: body['details'],
        status: body['status'],
        lenderName: body['lenderName'],
        requesterName: body['requesterName'],
        timeTerm: body['timeTerm']
      ));
    });
    return transactions;
  }

  Future<List<Transaction>> getLenderTransactions(String userId) async {
    String getTransUrl = 'https://caship-2c966-default-rtdb.firebaseio.com/transactions.json?&orderBy="lenderId"&equalTo="$userId"';
    var getTransResponse = await http.get(getTransUrl);
    Map<String, dynamic> decodedGetTransResponse = json.decode(getTransResponse.body);
    List<Transaction> transactions = [];
    decodedGetTransResponse.forEach((objectId, body) { 
      transactions.add(Transaction(
        id: objectId,
        requesterId: body['requesterId'],
        lenderId: body['lenderId'],
        amount: body['amount'],
        requestDate: DateTime.parse(body['requestDate']) ,
        finishDate: DateTime.parse(body['finishDate']) ,
        details: body['details'],
        status: body['status'],
        lenderName: body['lenderName'],
        requesterName: body['requesterName'],
        timeTerm: body['timeTerm']
      ));
    });
    return transactions;
  }

  Future<void> acceptTransaction(String transactionId, String finishDate) async {
    String url = 'https://caship-2c966-default-rtdb.firebaseio.com/transactions/$transactionId.json';
    var response = await http.patch(url, body: json.encode({
      "status": "active",
      "finishDate": finishDate
    }));
    Map<String, dynamic> decodedResponse = json.decode(response.body);
    print(decodedResponse);
  }

  Future<void> declineTransaction(String transactionId, String finishDate) async {
    String url = 'https://caship-2c966-default-rtdb.firebaseio.com/transactions/$transactionId.json';
    var response = await http.patch(url, body: json.encode({
      "status": "declined",
      "finishDate": finishDate
    }));
    Map<String, dynamic> decodedResponse = json.decode(response.body);
    print(decodedResponse);
  }
}