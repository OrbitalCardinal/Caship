import 'package:flutter/material.dart';
import '../screens/personalData_screen.dart';
import '../screens/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Redirect extends StatelessWidget {
  final bool login;

  Redirect(this.login);


  

  @override
  Widget build(BuildContext context) {
    var prompt = AppLocalizations.of(context).dontHaveAccount;
    var redirect = " " + AppLocalizations.of(context).login;
    var redirectScreen = LoginScreen.routeName;

    if(!login) {
      prompt = AppLocalizations.of(context).dontHaveAccount;
      redirect = " " + AppLocalizations.of(context).signup;
      redirectScreen = PersonalDataScreen.routeName;
    }

    Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              thickness: 2,
            ),
          ),
          Text(
            prompt,
            style: TextStyle(color: Colors.grey[600]),
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(redirectScreen);
              },
              child: Text(
                redirect,
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
