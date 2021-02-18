import 'package:flutter/material.dart';
import './slides_screen.dart';

class RequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(SlidesScreen.routeName, (route) => false);
        }, child: Text('Cerrar sesión')),
      ),
    );
  }
}
