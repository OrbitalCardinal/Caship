import 'package:Caship/main.dart';
import 'package:Caship/providers/auth_provider.dart';
import 'package:Caship/widgets/languageSelector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/slides_screen.dart';
import '../screens/terms_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();

}

class _SettingsScreenState extends State<SettingsScreen> {
  int _radioValue; 
  var langDic = [
    'Español',
    'English'
  ];
  
  void changeRadioValue(int newValue) {
    setState(() {
      _radioValue = newValue;
    });
    MyApp.saveLanguagePreference(newValue);
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
     _radioValue = MyApp.getPreferedLanguage(context);
      
    });
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
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.of(context).pushReplacementNamed('/');
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
