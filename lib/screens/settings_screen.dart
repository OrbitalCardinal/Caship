import 'package:Caship/main.dart';
import 'package:flutter/material.dart';
import '../screens/slides_screen.dart';
import '../screens/terms_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _radioValue = 0;
  var langDic = [
    'Español',
    'English'
  ];

  void changeRadioValue(int newValue) {
    setState(() {
      _radioValue = newValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).settingsAppBarTitle),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).account,
                style: TextStyle(fontSize: 16),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.input),
                title: Text(AppLocalizations.of(context).logOut),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SlidesScreen.routeName);
                },
              ),
              Text(
                AppLocalizations.of(context).about,
                style: TextStyle(fontSize: 16),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text(AppLocalizations.of(context).termsAndConditions),
                onTap: () {
                  Navigator.of(context).pushNamed(TermsScreen.routeName);
                },
              ),
              Text(
                AppLocalizations.of(context).language,
                style: TextStyle(fontSize: 16),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text(AppLocalizations.of(context).changeLanguage),
                subtitle: Text(langDic[_radioValue]),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => LanguageSelectorDialog(_radioValue, changeRadioValue));
                },
              ),
            ],
          ),
        ));
  }
}

class LanguageSelectorDialog extends StatefulWidget {
  int _radioValue;
  final Function changeOutsideValue;

  LanguageSelectorDialog(this._radioValue, this.changeOutsideValue);

  @override
  _LanguageSelectorDialogState createState() => _LanguageSelectorDialogState();
}

class _LanguageSelectorDialogState extends State<LanguageSelectorDialog> {


  changeRadioValue(int value) {
    setState(() {
      widget._radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Seleccione el idioma"),
      children: [
        ListTile(
          leading: Radio(
            value: 0,
            groupValue: widget._radioValue,
            onChanged: changeRadioValue,
          ),
          title: Text("Español"),
        ),
        ListTile(
          leading: Radio(
            value: 1,
            groupValue: widget._radioValue,
            onChanged: changeRadioValue,
          ),
          title: Text("English"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    if (widget._radioValue == 0) {
                      MyApp.setLocale(context, Locale('es', ''));
                    } else if (widget._radioValue == 1) {
                      MyApp.setLocale(context, Locale('en', ''));
                    }
                    widget.changeOutsideValue(widget._radioValue);
                    Navigator.of(context).pop();
                  },
                  child: Text("Aceptar"))
            ],
          ),
        )
      ],
    );
  }
}
