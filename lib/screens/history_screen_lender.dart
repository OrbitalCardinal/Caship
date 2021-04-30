import 'package:Caship/models/transactions.dart';
import 'package:Caship/providers/auth_provider.dart';
import 'package:Caship/providers/transaction_provider.dart';
import 'package:Caship/widgets/pending_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryScreenLender extends StatefulWidget {
  // Global widget variables
  String popUpText = "";
  List<Transaction> transactions = [];
  List<Transaction> filterTransactions = [];
  @override
  _HistoryScreenLenderState createState() => _HistoryScreenLenderState();
}

class _HistoryScreenLenderState extends State<HistoryScreenLender> {
  bool isInit = true;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      widget.popUpText = AppLocalizations.of(context).showAll;
      //Getting user id
      var userId =
          await Provider.of<AuthProvider>(context, listen: false).getUserId();
      //Getting transactions
      List<Transaction> newTransactions =
          await Provider.of<TransactionProvider>(context, listen: false)
              .getLenderTransactions(userId);

      setState(() {
        widget.transactions = newTransactions.where((trans) =>
            trans.status.contains('declined') ||
            trans.status.contains('completed')).toList();
        widget.filterTransactions = widget.transactions;
        // print(widget.filterTransactions.length);
        // Change circular progress indicator
        isInit = false;
      });
    }

    super.didChangeDependencies();
  }

  filterList(int selectedValue) {
    setState(() {
      if(selectedValue == 0) {
        widget.filterTransactions = widget.transactions;
      }
      else if(selectedValue == 1) {
        widget.filterTransactions = widget.transactions.where((element) => element.status.contains('completed')).toList();
      }
      else if(selectedValue == 2) {
        widget.filterTransactions = widget.transactions.where((element) => element.status.contains('declined')).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Global build Variables
    Color accentColor = Theme.of(context).accentColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).history,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]),
          ),
          PopupMenuButton(
            onSelected: (int selectedValue) {
              //Change text
              setState(() {
                if (selectedValue == 0) {
                  widget.popUpText = AppLocalizations.of(context).showAll;
                } else if (selectedValue == 1) {
                  widget.popUpText = AppLocalizations.of(context).completed;
                } else if (selectedValue == 2) {
                  widget.popUpText = AppLocalizations.of(context).declined;
                }
                filterList(selectedValue);
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.popUpText,
                  style: TextStyle(fontSize: 16, color: accentColor),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: accentColor,
                )
              ],
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(AppLocalizations.of(context).showAll),
                value: 0,
              ),
              PopupMenuItem(
                child: Text(AppLocalizations.of(context).completed),
                value: 1,
              ),
              PopupMenuItem(
                child: Text(AppLocalizations.of(context).declined),
                value: 2,
              ),
            ],
          ),
          widget.filterTransactions.length == 0 ? 
          Expanded(child: Center(child: Text(AppLocalizations.of(context).noLendings),))
          :  
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                String name = widget.filterTransactions[index].requesterName;
                DateTime requestDate =
                    widget.filterTransactions[index].requestDate;
                DateTime finishDate =
                    widget.filterTransactions[index].finishDate;
                double amount = widget.filterTransactions[index].amount;
                bool isMyRequest = false;
                String status = widget.filterTransactions[index].status;
                Transaction widgetTransaction =
                    widget.filterTransactions[index];

                return PendingCard(
                    name: name,
                    requestDate: requestDate,
                    finishDate: finishDate,
                    amount: amount,
                    isMyRequest: isMyRequest,
                    status: status,
                    transaction: widgetTransaction);
              },
              itemCount: widget.filterTransactions.length,
            ),
          )
        ],
      ),
    );
  }
}
