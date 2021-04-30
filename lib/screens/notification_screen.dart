import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/pending_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/transaction_provider.dart';
import '../providers/auth_provider.dart';
import '../models/transactions.dart';
import '../providers/user_provider.dart';

class NotificationScreen extends StatefulWidget {
  String userId = "";
  String popText = "";
  List<Transaction> transactions = [];
  List<Transaction> filteredTransactions = [];
  List<String> lenderNames = [];
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isInit = true;
  int filter = 0;

  @override
  void didChangeDependencies() async {
    var getuserId =
        await Provider.of<AuthProvider>(context, listen: false).getUserId();
    print(getuserId);
    if (isInit) {
      try {
        List<Transaction> newTransactions =
            await Provider.of<TransactionProvider>(context, listen: false)
                .getRequesterTransactions(getuserId);
        setState(() {
          isInit = false;
          widget.transactions = newTransactions.where((element) => !element.status.contains("declined")).toList();
          widget.filteredTransactions = widget.transactions;
          widget.userId = getuserId;
        });
      } catch (error) {
        print(error);
      }
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //Global variables
    Color accentColor = Theme.of(context).accentColor;

    void getPopText() {
      setState(() {
        if (filter == 0) {
          widget.popText = AppLocalizations.of(context).showAll;
        } else if (filter == 1) {
          widget.popText = AppLocalizations.of(context).actives;
        } else if (filter == 2) {
          widget.popText = AppLocalizations.of(context).pending;
        } else {
          widget.popText = "wtf";
        }
      });
    }

    getPopText();

    void filterList() {
      if (filter == 0) {
        setState(() {
          widget.filteredTransactions = widget.transactions;
        });
      } else if (filter == 1) {
        List<Transaction> newList = [];
        widget.transactions.forEach((element) {
          if (element.status.contains("active")) {
            newList.add(element);
          }
        });
        setState(() {
          widget.filteredTransactions = newList;
        });
      } else if (filter == 2) {
        List<Transaction> newList = [];
        widget.transactions.forEach((element) {
          if (element.status.contains("pending")) {
            newList.add(element);
          }
        });
        setState(() {
          widget.filteredTransactions = newList;
        });
      } else {
        setState(() {
          widget.filteredTransactions = widget.transactions;
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).requests,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]),
          ),
          PopupMenuButton(
            onSelected: (int selectedValue) {
              setState(() {
                filter = selectedValue;
                getPopText();
                filterList();
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.popText,
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
                child: Text(AppLocalizations.of(context).actives),
                value: 1,
              ),
              PopupMenuItem(
                child: Text(AppLocalizations.of(context).pending),
                value: 2,
              )
            ],
          ),
          Expanded(
            child: isInit
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemBuilder: (ctx, index) {
                      return PendingCard(
                        amount: widget.filteredTransactions[index].amount,
                        finishDate: widget.filteredTransactions[index].finishDate,
                        requestDate: widget.transactions[index].requestDate,
                        isMyRequest: true,
                        name: widget.filteredTransactions[index].lenderName,
                        isPending: widget.filteredTransactions[index].status
                                .contains('pending')
                            ? true
                            : false,
                        transaction: widget.filteredTransactions[index],
                      );
                    },
                    itemCount: widget.filteredTransactions.length,
                  ),
          )
        ],
      ),
    );
  }
}
