import 'package:Caship/providers/user_provider.dart';
import 'package:Caship/screens/aprovalTransaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/transactions.dart';
import '../screens/ppwebview_screen.dart';
import '../providers/paypal_provider.dart';

class PendingCard extends StatelessWidget {
  String name;
  DateTime requestDate;
  DateTime finishDate;
  double amount;
  bool isMyRequest;
  String status;

  Transaction transaction;

  PendingCard({
    @required this.name,
    @required this.requestDate,
    @required this.finishDate,
    @required this.amount,
    @required this.isMyRequest,
    @required this.status,
    @required this.transaction
  });

  @override
  Widget build(BuildContext context) {
    Color tabColor = Colors.red;
    String tabText = AppLocalizations.of(context).pending;
    bool isPending = true;
    // Global variables
    if(status.contains('pending')) {
      tabColor = Colors.red;
      tabText = AppLocalizations.of(context).pending;
      isPending = true;
    } 
    else if(status.contains('active')) {
      tabColor = Colors.green;
      tabText = AppLocalizations.of(context).active;
      isPending = false;
    }
    else if(status.contains('completed')) {
      tabColor = Colors.blue;
     tabText = AppLocalizations.of(context).completed;
      isPending = false;
    } 
    else if(status.contains('declined')) {
      tabColor = Colors.orange;
      tabText = AppLocalizations.of(context).declined;
      isPending = false;
    }
    Color primaryColor = Theme.of(context).primaryColor;
    Color accentColor = Theme.of(context).accentColor;
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 5),
              decoration: BoxDecoration(
                  color: tabColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Text(
                tabText,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            child: Material(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
              child: InkWell(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                onTap: isPending && !isMyRequest ? () async {
                  var requesterInfo =  await Provider.of<UserProvider>(context, listen: false).getGlobalUserInfo(transaction.requesterId);
                  Navigator.of(context).pushNamed(AprovalTransactionScreen.routeName, arguments: {
                    "transaction": transaction,
                    "requesterInfo": requesterInfo
                  });
                } : () async {
                  if(!isPending) {
                    // Get paypal webexperience
                    String checkoutUrl = await Provider.of<PaypalProvider>(context, listen: false).createWebExperienceProfile(amount);
                    Navigator.of(context).pushNamed(PpWebViewScreen.routeName, arguments: checkoutUrl);
                  }
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Center(
                            child: isMyRequest
                                ? Icon(
                                    Icons.arrow_downward,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                : Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                          ),
                          height: 100,
                          decoration: BoxDecoration(
                            color: isMyRequest ? primaryColor : accentColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15)),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 6,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isMyRequest
                                    ? AppLocalizations.of(context).requestTo
                                    : AppLocalizations.of(context).requestFrom,
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.feedback,
                                      size: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "  " +
                                        AppLocalizations.of(context).requestDate,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                  TextSpan(
                                    text: DateFormat('dd/MM/yy')
                                        .format(requestDate),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "  " +
                                        AppLocalizations.of(context).finishDate,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                  TextSpan(
                                    text:
                                        DateFormat('dd/MM/yy').format(finishDate),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -10,
            right: -10,
            child: Container(
              margin: EdgeInsets.only(top: 25),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: isMyRequest ? primaryColor : accentColor,
              ),
              child: Center(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: "\$"),
                    TextSpan(
                        text: amount % 1 == 0
                            ? amount.toInt().toString()
                            : amount.toStringAsFixed(1),
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                  ]),
                ),
              ),
            ),
          ),
          
        ],

        //Stack options
        clipBehavior: Clip.none,
      ),
    );
  }
}
