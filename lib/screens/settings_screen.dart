import 'package:flutter/material.dart';
import '../screens/slides_screen.dart';
import '../screens/terms_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configuración"),backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cuenta", style: TextStyle(fontSize: 16),),
            Divider(color: Colors.grey, thickness: 1,),
            ListTile(leading: Icon(Icons.input), title: Text("Cerrar sesión"),onTap: () {
              Navigator.of(context).pushReplacementNamed(SlidesScreen.routeName);
            },),
            Text("Acerca de", style: TextStyle(fontSize: 16),),
            Divider(color: Colors.grey, thickness: 1,),
            ListTile(leading: Icon(Icons.help), title: Text("Terminos y condiciones"), onTap: () {
              Navigator.of(context).pushNamed(TermsScreen.routeName);
            },),
          ],
        ),
      )
    );
  }
}