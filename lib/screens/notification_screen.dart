import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pendientes",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              PopupMenuButton(
                  onSelected: (int selectedValue) {
                    print(selectedValue);
                  },
                  icon: Icon(Icons.expand_more),
                  itemBuilder: (_) => [
                        PopupMenuItem(
                          child: Text("Solicitudes"),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text("Aprobaciones"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text("Mostrar todo"),
                          value: 2,
                        ),
                      ]),
            ],
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("De:"),
                        Text("Edson Raul Cepeda Marquez"),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.announcement,
                              size: 15,
                            ),
                            Text(" Fecha de solicitud:"),
                            Text(
                              "10/10/10",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 15,
                            ),
                            Text(" Fecha de termino:"),
                            Text(
                              "10/10/10",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            )
                          ],
                        ),
                      ],
                    ),
                    trailing: RichText(
                      text: TextSpan(
                        text: "\$ 50.00",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        children: [
                          TextSpan(
                            text: " mxn",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: 10),
          )
        ],
      ),
    );
  }
}
