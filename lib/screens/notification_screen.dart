import 'package:flutter/material.dart';
import '../screens/aprovalTransaction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                AppLocalizations.of(context).pending,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              PopupMenuButton(
                  onSelected: (int selectedValue) {
                    print(selectedValue);
                  },
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (_) => [
                        PopupMenuItem(
                          child: Text(AppLocalizations.of(context).requests),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text(AppLocalizations.of(context).aproval),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text(AppLocalizations.of(context).showAll),
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
                    onTap: () {
                      Navigator.of(context).pushNamed(AprovalTransactionScreen.routeName);
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context).from),
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
                            Text(" " + AppLocalizations.of(context).requestDate ),
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
