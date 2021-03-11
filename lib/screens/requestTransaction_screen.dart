import 'package:Caship/widgets/square_avatar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestTransactionScreen extends StatefulWidget {
  static const routeName = "/RequestTransaction";

  @override
  _RequestTransactionScreenState createState() =>
      _RequestTransactionScreenState();
}

class _RequestTransactionScreenState extends State<RequestTransactionScreen> {
  TextEditingController amountController = TextEditingController();
  double userAmount = 0;
  int selectedDays = 0;
  bool check1 = false;
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

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    // Color accentColor = Theme.of(context).accentColor;
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
                RequestButton(primaryColor),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context).amount,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                AmountInfo(
                  userAmount: userAmount,
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
                      Text(
                        AppLocalizations.of(context).selectPayTerm + ":",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: Colors.grey[600],
                      ),
                      TimeTermCheckbox(
                        checkFunction: activateCheck1,
                        days: AppLocalizations.of(context).days14,
                        weeksMonths:  AppLocalizations.of(context).weeks2,
                        checked: check1,
                      ),
                      TimeTermCheckbox(
                        checkFunction: activateCheck2,
                        days: AppLocalizations.of(context).days28,
                        weeksMonths: AppLocalizations.of(context).weeks4,
                        checked: check2,
                      ),
                      TimeTermCheckbox(
                        checkFunction: activateCheck3,
                        days: AppLocalizations.of(context).days42,
                        weeksMonths: AppLocalizations.of(context).weeks6,
                        checked: check3,
                      ),
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
                            "${DateFormat('dd/MM/yy').format(DateTime.now().add(new Duration(days: selectedDays)))}",
                            style: TextStyle(
                                color: primaryColor,
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
                        AppLocalizations.of(context).requestTo,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      ListTile(
                        leading: SquareAvatar(
                            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8YXZhdGFyfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                        title: Text(
                          "Edson Raul Cepeda Marquez",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        subtitle: Text("Mexico\n" + "+52 8122942626"),
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
                        AppLocalizations.of(context).detailsLegend,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).addMessageHere,
                            border: OutlineInputBorder()),
                        maxLines: null,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        AppLocalizations.of(context).warning + ":",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        AppLocalizations.of(context).warningLegend,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RequestButton(primaryColor),
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
    return Column(
      children: [
        CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          title: RichText(
            text: TextSpan(
                text: "$days. ",
                style: TextStyle(
                    color: primaryColor,
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
          activeColor: primaryColor,
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
          onTap: () {
            TextEditingController amountController = TextEditingController();
            showDialog(
                context: context,
                builder:  (_) => AlertDialog(
                  content: TextField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                  ),
                  title: Text("Ingrese el monto:"),
                  actions: [
                  TextButton(
                      child: Text('Aceptar'),
                      onPressed: () {
                        if(amountController.text.isNotEmpty) {
                          changeAmount(double.parse(amountController.text));
                        }
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
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

class RequestButton extends StatelessWidget {
  final Color color;

  RequestButton(this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FlatButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context).request,
              style: TextStyle(color: Colors.white),
            ),
            color: color,
          ),
        ),
      ],
    );
  }
}
