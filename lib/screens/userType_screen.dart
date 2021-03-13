import 'package:Caship/screens/personalData_screen.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserTypeScreen extends StatefulWidget {
  static const routeName = "/usertype";


  @override
  _UserTypeScreenState createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isRegister = ModalRoute.of(context).settings.arguments as bool;
    String screenTitle = AppLocalizations.of(context).userSelectTitleLogIn;
    String screenLegend = AppLocalizations.of(context).userSelectLegendLogIn;
    if(isRegister) {
      setState(() {
        screenTitle = AppLocalizations.of(context).userSelectTitleSignUp;
        screenLegend = AppLocalizations.of(context).userSelectLegendSignUp;
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    screenTitle,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    screenLegend,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserTypeTile(
                      image: Image.asset(
                        'assets/imgs/lender.png',
                        width: 85,
                      ),
                      onTap: () {
                        if(isRegister) {
                          Navigator.of(context).pushNamed(PersonalDataScreen.routeName, arguments: {
                            "userType": "Lender"
                          });
                        } else {
                          Navigator.of(context).pushNamed(LoginScreen.routeName, arguments: {
                            "userType": "Lender"
                          });
                        }
                      },
                      title: Text(
                        AppLocalizations.of(context).lender,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).lenderLegend,
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(height: 30,),
                    UserTypeTile(
                      image: Image.asset(
                        'assets/imgs/requester.png',
                        width: 85,
                      ),
                      onTap: () {
                       if(isRegister) {
                          Navigator.of(context).pushNamed(PersonalDataScreen.routeName, arguments: {
                            "userType": "Requester"
                          });
                        } else {
                          Navigator.of(context).pushNamed(LoginScreen.routeName, arguments: {
                            "userType": "Requester"
                          });
                        }
                      },
                      title: Text(
                        AppLocalizations.of(context).requester,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).requesterLegend,
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserTypeTile extends StatelessWidget {
  final Image image;
  final Text title;
  final Text subtitle;
  final Function onTap;

  const UserTypeTile(
      {@required this.image,
      @required this.onTap,
      @required this.subtitle,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey[300], offset: Offset(0, 4))],
        ),
        child: Row(
          children: [
            image,
            SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  subtitle,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
