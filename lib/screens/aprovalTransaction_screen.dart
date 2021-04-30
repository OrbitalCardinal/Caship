import 'package:Caship/models/transactions.dart';
import 'package:Caship/providers/transaction_provider.dart';
import 'package:Caship/providers/user_provider.dart';
import 'package:Caship/widgets/square_avatar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class AprovalTransactionScreen extends StatefulWidget {
  static const routeName = "/AprovalTransaction";

  @override
  _AprovalTransactionScreenState createState() =>
      _AprovalTransactionScreenState();
}

class _AprovalTransactionScreenState extends State<AprovalTransactionScreen> {

  TextEditingController amountController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  double userAmount = 0;
  int selectedDays = 0;
  bool check1 = true;
  bool check2 = false;
  bool check3 = false;



  activateCheck1() {
    setState(() {
      check1 = true;
      check2 = false;
      check3 = false;
      selectedDays = 14;
    });
  }

  activateCheck2() {
    setState(() {
      check1 = false;
      check2 = true;
      check3 = false;
      selectedDays = 28;
    });
  }

  activateCheck3() {
    setState(() {
      check1 = false;
      check2 = false;
      check3 = true;
      selectedDays = 42;
    });
  }

  changeAmount(double newAmount) {
    setState(() {
      userAmount = newAmount;
    });
  }

  Future<Map<String,dynamic>> getRequesterInfo(String requesterId) async {
    return await Provider.of<UserProvider>(context, listen: false).getGlobalUserInfo(requesterId);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    Transaction transaction = args["transaction"];
    Map<String, dynamic> requesterInfo = args["requesterInfo"];
    double amount = transaction.amount;
    detailsController.text = transaction.details;
    DateTime limitDate;
    if(transaction.timeTerm == 1) {
      limitDate = DateTime.now().add(Duration(days: 14));
    }
    else if(transaction.timeTerm == 2) {
      limitDate = DateTime.now().add(Duration(days: 28));
    } else if(transaction.timeTerm == 3) {
      limitDate = DateTime.now().add(Duration(days: 42));
    } else {
      limitDate = DateTime.now();
    }
    Color primaryColor = Theme.of(context).primaryColor;
    Color accentColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'caship',
          style: TextStyle(
              color: Colors.grey[700],
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Scrollbar(
              child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            width: double.infinity,
            child: Column(
              children: [
                RequestButtons(transactionId: transaction.id, limitDate: limitDate),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context).amount,
                  style: TextStyle(
                      color: accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                AmountInfo(
                  userAmount: transaction.amount,
                  changeAmount: changeAmount,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context).limitTime,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('yy/mm/dd').format(limitDate),
                            style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        AppLocalizations.of(context).limiteTimeLegend,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        AppLocalizations.of(context).requestFrom + ":",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      ListTile(
                        leading: SquareAvatar(
                            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8YXZhdGFyfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                        title: Text(
                          transaction.requesterName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        subtitle: Text('${requesterInfo["country"]}\n' + requesterInfo['phone']),
                        isThreeLine: true,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        AppLocalizations.of(context).details,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        AppLocalizations.of(context).messageAddedRequester,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        enabled: false,
                        controller: detailsController,
                        decoration: InputDecoration(
                            hintText: transaction.details,
                            helperText:transaction.details,
                            border: OutlineInputBorder()),
                        maxLines: null,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        AppLocalizations.of(context).disclaimer + ":",
                        style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        AppLocalizations.of(context).disclaimerLegend,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RequestButtons(transactionId: transaction.id, limitDate: limitDate,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimeTermCheckbox extends StatelessWidget {
  final String days;
  final String weeksMonths;
  final Function checkFunction;
  final bool checked;

  TimeTermCheckbox(
      {this.checkFunction, this.days, this.weeksMonths, this.checked});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color accentColor = Theme.of(context).accentColor;
    return Column(
      children: [
        CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          title: RichText(
            text: TextSpan(
                text: "$days. ",
                style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                children: [
                  TextSpan(
                      text: ("$weeksMonths"),
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.normal,
                          fontSize: 15)),
                ]),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: checked,
          onChanged: (_) => checkFunction(),
          activeColor: accentColor,
        ),
      ],
    );
  }
}

class AmountInfo extends StatelessWidget {
  final double userAmount;
  final Function changeAmount;

  AmountInfo({this.userAmount, this.changeAmount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(5),
            child: RichText(
              text: TextSpan(
                text: "\$ ",
                style: TextStyle(color: Colors.grey, fontSize: 30),
                children: [
                  TextSpan(
                    text: userAmount.toString(),
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: " mxn",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
        RichText(
          text: TextSpan(
              text: "+ ${userAmount * 0.1} ",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: [
                TextSpan(
                    text: "10% " + AppLocalizations.of(context).delay,
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.normal,
                        fontSize: 15))
              ]),
        )
      ],
    );
  }
}

class RequestButtons extends StatelessWidget {
  final String transactionId;
  final DateTime limitDate;
  RequestButtons({@required this.transactionId, @required this.limitDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () async {
                try {
                  await Provider.of<TransactionProvider>(context, listen: false).declineTransaction(transactionId, limitDate.toIso8601String());
                  Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                } catch(error) {
                  print(error);
                }
              },
              child: Text(
                AppLocalizations.of(context).decline,
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () async {
                try {
                  await Provider.of<TransactionProvider>(context, listen: false).acceptTransaction(transactionId, limitDate.toIso8601String());
                  Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                } catch(error) {
                  print(error);
                }
              },
              child: Text(
                AppLocalizations.of(context).accept,
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
