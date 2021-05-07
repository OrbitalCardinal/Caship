import 'package:Caship/widgets/square_avatar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/square_avatar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String names;
  String lastnames;
  String country;
  String phone;
  String birthdate;
  String imgUrl;
  var _isInit = true;
  var _isLoading = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<UserProvider>(context,listen: false).getUserInfo().then((data) {
        setState(() {
          names = data['names'];
          lastnames = data['lastnames'];
          country = data['country'];
          phone = data['phone'];
          birthdate = data['birthdate'];
          imgUrl = data['imgUrl'];
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    
    super.didChangeDependencies();
  }

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
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : Padding(
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
              leading: SquareAvatar(imgUrl),
              trailing: IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              title: Text(AppLocalizations.of(context).firstName),
              subtitle: Text(names),
              leading: Icon(Icons.person),
              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {},),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).lastName),
              subtitle: Text(lastnames),
              leading: Icon(Icons.person),
              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {},),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(AppLocalizations.of(context).country),
              subtitle: Text(country),
              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {},),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.cake),
              title: Text(AppLocalizations.of(context).birthDate),
              subtitle: Text(DateFormat('dd/MM/yy').format(DateTime.parse(birthdate)).toString()),
              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {},),
            ),
            // Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(AppLocalizations.of(context).phoneNumber),
              subtitle: Text("+" + phone.substring(0,2) + " " + phone.substring(2)),
              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {},),
            ),
            // Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
