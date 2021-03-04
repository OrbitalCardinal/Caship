import 'package:flutter/material.dart';
import '../screens/personalData_screen.dart';
import '../screens/login_screen.dart';

class Redirect extends StatelessWidget {
  final bool login;

  Redirect(this.login);

  var prompt = '¿Ya tienes una cuenta?';
  var redirect = ' Inicia sesión';
  var redirectScreen = LoginScreen.routeName;

  

  @override
  Widget build(BuildContext context) {
    if(!login) {
      prompt = '¿No tienes una cuenta?';
      redirect = ' Registrate';
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
