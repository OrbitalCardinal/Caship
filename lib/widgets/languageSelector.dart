import 'package:flutter/material.dart';

import '../main.dart';

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
                      MyApp.setLocale(context, Locale('es', ''), 0);
                    } else if (widget._radioValue == 1) {
                      MyApp.setLocale(context, Locale('en', ''), 1);
                    }
                    widget.changeOutsideValue(widget._radioValue);
                    // MyApp.readLanguagePreferences();
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