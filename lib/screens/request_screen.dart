import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../models/contact.dart';
import '../widgets/contact_tile.dart';
import '../providers/contact_provider.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  // Global
  bool isInit = true;
  List<MyContact> formatted_contacts = [];
  List<MyContact> filtered_contacts = [];
  List<dynamic> favorites = [];
  List<Widget> contactTiles = [];
  bool favoritesMessage = false;
  int filter = 1;
  String actual_letter = "-";

  @override
  void didChangeDependencies() async {
    if (isInit) {
      formatted_contacts =
          await Provider.of<ContactProvider>(context, listen: false)
              .retrieveContacts();
      filtered_contacts = [...formatted_contacts];

      favorites = await Provider.of<ContactProvider>(context, listen: false).favorites;
      if (favorites == null) {
        favorites = [];
      }
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Color accentColor = Theme.of(context).accentColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (word) {
              setState(() {
                if (!word.isEmpty) {
                  filtered_contacts = formatted_contacts
                      .where((contact) => contact.displayName
                          .toLowerCase()
                          .contains(word.toLowerCase()))
                      .toList();
                } else {
                  filtered_contacts = [...formatted_contacts];
                }
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              labelText: AppLocalizations.of(context).searchBarHint,
              labelStyle: TextStyle(color: Colors.grey[700]),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[200])),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[200])),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide()),
            ),
          ),
          SizedBox(height: 15),
          Text(
            AppLocalizations.of(context).myContacts,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]),
          ),
          PopupMenuButton(
            onSelected: (int selectedValue) async{
              favorites = await Provider.of<ContactProvider>(context, listen: false).favorites;
              if(favorites == null) {
                favorites = [];
              }
              setState(()  {
                if (selectedValue == 0) {
                  filtered_contacts = formatted_contacts
                      .where((contact) => favorites.contains(contact.phone))
                      .toList();
                  if (favorites.length == 0) {
                    favoritesMessage = true;
                  }
                } else {
                  setState(() {
                    filtered_contacts = formatted_contacts;
                    favoritesMessage = false;
                  });
                }
                filter = selectedValue;
              });
            },
            child: Row(
              children: [
                Text(
                  filter == 0
                      ? AppLocalizations.of(context).favorites
                      : AppLocalizations.of(context).showAll,
                  style: TextStyle(color: accentColor, fontSize: 16),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: accentColor,
                ),
              ],
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(AppLocalizations.of(context).favorites),
                value: 0,
              ),
              PopupMenuItem(
                child: Text(AppLocalizations.of(context).showAll),
                value: 1,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          isInit
              ? Expanded(
                  child: Center(
                  child: CircularProgressIndicator(),
                ))
              : Expanded(
                  child: Scrollbar(
                    child: favoritesMessage
                        ? Center(
                            child: Text(AppLocalizations.of(context).noFav),
                          )
                        : ListView.builder(
                            itemCount: filtered_contacts.length,
                            itemBuilder: (ctx, index) {
                              var contact = filtered_contacts[index];
                              // Getting contact info
                              var contactName = contact.displayName;
                              var contactPhone = contact.phone;
                              var isFavorite = false;
                              if (favorites != null) {
                                if (favorites.contains(contactPhone)) {
                                  isFavorite = true;
                                }
                              }
                              var contactCountry = 'Mexico';
                              var newLetter = contactName.substring(0, 1);

                              if (!newLetter.contains(actual_letter)) {
                                actual_letter = newLetter;
                                return (Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        actual_letter,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        children: [
                                          ContactTile(
                                            name: contactName,
                                            phone: contactPhone,
                                            country: contactCountry,
                                            active: true,
                                            initials: contact.initials,
                                            isFavorite: isFavorite,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                              } else {
                                return (Column(
                                  children: [
                                    ContactTile(
                                      name: contactName,
                                      phone: contactPhone,
                                      country: contactCountry,
                                      active: true,
                                      initials: contact.initials,
                                      isFavorite: isFavorite,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ));
                              }
                            }),
                  ),
                )
        ],
      ),
    );
  }
}
