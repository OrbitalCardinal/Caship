import 'package:flutter/material.dart';
import '../widgets/square_avatar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryScreen extends StatelessWidget {
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
                AppLocalizations.of(context).history,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              PopupMenuButton(
                  onSelected: (int selectedValue) {
                    print(selectedValue);
                  },
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (_) => [
                        PopupMenuItem(
                          child: Text(AppLocalizations.of(context).adquisitions),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text(AppLocalizations.of(context).transactions),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text(AppLocalizations.of(context).showAll),
                          value: 2,
                        ),
                      ])
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
                    leading: SquareAvatar(
                        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8YXZhdGFyfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context).from,
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        Text("Edson Raul Cepeda Marquez")
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check,
                                size: 15,
                              ),
                              Text(" " + AppLocalizations.of(context).acceptDate),
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
                              Text(" " + AppLocalizations.of(context).finishDate),
                              Text( 
                                "10/10/10",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.alarm,
                                size: 15,
                              ),
                              Text(" " + AppLocalizations.of(context).noDelay)
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "\$ 50.00",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(" mxn")
                            ],
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
