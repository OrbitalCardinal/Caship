import 'package:Caship/widgets/square_avatar.dart';
import 'package:flutter/material.dart';
import '../widgets/square_avatar.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: TextStyle(color: Colors.grey[700]),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [     
            Text(
              "Información de perfil",
              style: Theme.of(context).textTheme.headline6,
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text("Foto de perfil"),
              subtitle: Text("Cambiar foto de perfil"),
              leading: SquareAvatar("https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8YXZhdGFyfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
              trailing: IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              title: Text("Nombre"),
              subtitle: Text("Edson Raul Cepeda Marquez"),
              leading: Icon(Icons.person),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("País"),
              subtitle: Text("México"),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.cake),
              title: Text("Fecha de nacimiento"),
              subtitle: Text("10/10/10"),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Teléfono"),
              subtitle: Text("+52 8122942626"),
            ),
            Divider(color: Colors.grey),
            Text(
              "Información de pago",
              style: Theme.of(context).textTheme.headline6,
            ),
            Divider(color: Colors.grey),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("Asociar Paypal", style: TextStyle(color: Colors.white),),
                    color: Colors.blue,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
