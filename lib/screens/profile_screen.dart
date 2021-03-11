import 'package:Caship/widgets/square_avatar.dart';
import 'package:flutter/material.dart';
import '../widgets/square_avatar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          AppLocalizations.of(context).profileAppBarTitle,
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
              AppLocalizations.of(context).profileInfo,
              style: Theme.of(context).textTheme.headline6,
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text(AppLocalizations.of(context).profilePicture),
              subtitle: Text(AppLocalizations.of(context).changeProfilePicture),
              leading: SquareAvatar("https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8YXZhdGFyfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
              trailing: IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              title: Text(AppLocalizations.of(context).fullName),
              subtitle: Text("Edson Raul Cepeda Marquez"),
              leading: Icon(Icons.person),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(AppLocalizations.of(context).country),
              subtitle: Text("México"),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.cake),
              title: Text(AppLocalizations.of(context).birthDate),
              subtitle: Text("10/10/10"),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(AppLocalizations.of(context).phoneNumber),
              subtitle: Text("+52 8122942626"),
            ),
            Divider(color: Colors.grey),
            Text(
              AppLocalizations.of(context).paymentInfo,
              style: Theme.of(context).textTheme.headline6,
            ),
            Divider(color: Colors.grey),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.of(context).associatePaypal, style: TextStyle(color: Colors.white),),
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
