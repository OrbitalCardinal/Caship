import 'package:Caship/widgets/square_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/requestTransaction_screen.dart';
import '../providers/contact_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactTile extends StatefulWidget {
  String name;
  String country;
  String phone;
  bool active;
  String initials;
  String url;
  bool isFavorite;

  ContactTile(
      {this.name,
      this.phone,
      this.country,
      this.active,
      this.initials,
      this.url,
      this.isFavorite});

  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Color accentColor = Theme.of(context).accentColor;
    return Container(
      // margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
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
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: !widget.active
              ? () {}
              : () async {
                  var userInfo =
                      await Provider.of<ContactProvider>(context, listen: false)
                          .checkRegister(widget.phone);
                  if (userInfo.isNotEmpty) {
                    if (!userInfo[userInfo.keys.first]['isLender']) {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title:
                                  Text(AppLocalizations.of(context).notALender),
                              content: Text(AppLocalizations.of(context)
                                  .notALenderLegend),
                              actions: [
                                TextButton(
                                  child:
                                      Text(AppLocalizations.of(context).cont),
                                  onPressed: () => Navigator.of(ctx).pop(),
                                ),
                              ],
                            );
                          });
                    } else {
                      Navigator.of(context).pushReplacementNamed(
                          RequestTransactionScreen.routeName,
                          arguments: {
                            "userInfo": userInfo,
                            "isFavorite": widget.isFavorite
                          });
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text(AppLocalizations.of(context)
                                .contactNotRegistered),
                            content: Text(AppLocalizations.of(context)
                                .contactMustRegister),
                            actions: [
                              TextButton(
                                child: Text(AppLocalizations.of(context).cont),
                                onPressed: () => Navigator.of(ctx).pop(),
                              ),
                            ],
                          );
                        });
                  }
                },
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    child: widget.url == null
                        ? CircleAvatar(
                            child: Text(widget.initials),
                            backgroundColor: Theme.of(context).accentColor,
                            foregroundColor: Colors.white,
                          )
                        : SquareAvatar(widget.url),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 15,
                            color: accentColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.phone,
                            style: TextStyle(fontSize: 14, color: accentColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded,
                              size: 15, color: Colors.grey[800]),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.country,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: Container(
                    child: IconButton(
                      onPressed: () {
                        // Provider.of<ContactProvider>(context, listen: false).getFavorites();
                        Provider.of<ContactProvider>(context, listen: false)
                            .setFavorites(widget.phone);
                        setState(() {
                          widget.isFavorite = !widget.isFavorite;
                        });
                      },
                      icon: Icon(
                          widget.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: accentColor),
                    ),
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
