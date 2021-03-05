import 'package:flutter/material.dart';
import '../screens/slides_screen.dart';
import '../screens/terms_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configuración"),backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cuenta", style: TextStyle(fontSize: 16),),
            Divider(color: Colors.grey,),
            ListTile(leading: Icon(Icons.input), title: Text("Cerrar sesión"),onTap: () {
              Navigator.of(context).pushReplacementNamed(SlidesScreen.routeName);
            },),
            Text("Acerca de", style: TextStyle(fontSize: 16),),
            Divider(color: Colors.grey,),
            ListTile(leading: Icon(Icons.help), title: Text("Terminos y condiciones"), onTap: () {
              Navigator.of(context).pushNamed(TermsScreen.routeName);
            },),
            Text("Lenguaje", style: TextStyle(fontSize: 16),),
            Divider(color: Colors.grey,),
            ListTile(leading: Icon(Icons.language), title: Text("Cambiar lenguaje"), subtitle: Text("Español"), onTap: () {
              showDialog(context: context, builder: (_) => LanguageSelectorDialog());
            },),
          ],
        ),
      )
    );
  }
}

class LanguageSelectorDialog extends StatefulWidget {
  const LanguageSelectorDialog({
    Key key,
  }) : super(key: key);

  @override
  _LanguageSelectorDialogState createState() => _LanguageSelectorDialogState();
}

class _LanguageSelectorDialogState extends State<LanguageSelectorDialog> {
  int _radioValue = 0;

  changeRadioValue(int value) {
    setState(() {
      _radioValue = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Seleccione el idioma"),
      children: [
        ListTile(
          leading: Radio(value: 0, groupValue: _radioValue, onChanged: changeRadioValue,),
          title: Text("Español"),
        ),
        ListTile(
          leading: Radio(value: 1, groupValue: _radioValue, onChanged: changeRadioValue,),
          title: Text("English"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text("Aceptar"))
          ],),
        )
      ],
    );
  }
}