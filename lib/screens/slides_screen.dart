import 'package:Caship/screens/secondSlide_screen.dart';
import 'package:Caship/screens/settings_screen.dart';
import 'package:Caship/screens/thirdSlide_screen.dart';
import 'package:flutter/material.dart';
import './firstSlide_screen.dart';
import 'login_screen.dart';
import '../screens/personalData_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SlidesScreen extends StatefulWidget {
  static const routeName = '/slides_screen';
  @override
  _SlidesScreenState createState() => _SlidesScreenState();
}


class _SlidesScreenState extends State<SlidesScreen> {
  int _radioValue = 0;
  var langDic = [
    'Español',
    'English'
  ];

  void changeRadioValue(int newValue) {
    setState(() {
      _radioValue = newValue;
    });
  }

  List<Widget> slidesList = [
    FirstSlideScreen(),
    SecondSlideScreen(),
    ThirdSlideScreen()
  ];
  var page = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
  Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    page = value;
                  });
                },
                controller: _pageController,
                itemCount: 3,
                itemBuilder: (ctx, position) {
                  return slidesList[position];
                }),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SlidesDot(page == 0 ? primaryColor : Colors.grey),
                    SlidesDot(page == 1 ? primaryColor : Colors.grey),
                    SlidesDot(page == 2 ? primaryColor : Colors.grey),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 4,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(LoginScreen.routeName);
                            },
                            child: Text(
                              AppLocalizations.of(context).login,
                              style: TextStyle(color: Colors.white,fontSize: 16),
                            ),
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          flex: 4,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(PersonalDataScreen.routeName);
                            },
                            child: Text(AppLocalizations.of(context).signup, style: TextStyle(fontSize: 16),),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: primaryColor,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(context: context, builder: (_) =>
                      LanguageSelectorDialog(_radioValue, changeRadioValue)
                    );
                  },
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(Icons.language),
                  Text(" " + AppLocalizations.of(context).changeLanguage)
                ],),)
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class SlidesDot extends StatelessWidget {
  final Color active;
  SlidesDot(this.active);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: 10,
      decoration:
          BoxDecoration(color: active, borderRadius: BorderRadius.circular(10)),
    );
  }
}
