import 'package:Caship/widgets/square_avatar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AprovalTransactionScreen extends StatefulWidget {
  static const routeName = "/AprovalTransaction";

  @override
  _AprovalTransactionScreenState createState() =>
      _AprovalTransactionScreenState();
}

class _AprovalTransactionScreenState extends State<AprovalTransactionScreen> {
  TextEditingController amountController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
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
                RequestButtons(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Monto:",
                  style: TextStyle(
                      color: accentColor,
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
                        "Selecciona el plazo del pago:",
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
                        days: "14 días",
                        weeksMonths: "(2 semanas)",
                        checked: check1,
                      ),
                      TimeTermCheckbox(
                        checkFunction: activateCheck2,
                        days: "28 días",
                        weeksMonths: "(4 semanas)",
                        checked: check2,
                      ),
                      TimeTermCheckbox(
                        checkFunction: activateCheck3,
                        days: "42 días",
                        weeksMonths: "(6 semanas)",
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
                            "La fecha limite de pago es:",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${DateFormat('dd/MM/yy').format(DateTime.now().add(new Duration(days: selectedDays)))}",
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
                        "Despues de esta fecha se cobrará el 10% del monto del préstamo por pago atrasado.",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Solicitado por: ",
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
                        "Detalles: ",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        "Mensaje del solicitante",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Mensaje del solicitante",
                            border: OutlineInputBorder()),
                        maxLines: null,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Aviso: ",
                        style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        "Caship solo gestiona el préstamo y es una conexión a los servicios de pago, No es responsable del pago faltante.",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RequestButtons(),
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
          // onChanged: (_) => checkFunction(),
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
                    text: "10% retraso",
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () {},
              child: Text(
                "Rechazar",
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
              onPressed: () {},
              child: Text(
                "Aceptar",
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
