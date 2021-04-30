import 'package:Caship/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './request_screen.dart';
import './history_screen.dart';
import './notification_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import './notificationScreen_lender.dart';
import '../screens/history_screen_lender.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  String userType = '';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;
  PageController _pageController; 
  bool isInit = true;

  @override
  void initState() {
    _pageController =  PageController(initialPage: _selectedPageIndex);
    setState(() {
      _selectedPageIndex = widget.userType.contains('Requester') ? 1 : 0;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if(isInit) {
      final prefs = await SharedPreferences.getInstance();
        if(!prefs.containsKey('userData')) {
          print("WTF");
        }
        final extractedUserData = json.decode(prefs.getString('userData'));
        widget.userType = extractedUserData['userType'];
        print(widget.userType);
      // TODO: implement didChangeDependencies
    }
    setState(() {
      isInit = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = widget.userType.contains('Requester') ? [
      HistoryScreen(),
      RequestScreen(),
      NotificationScreen()
    ] : [
      HistoryScreenLender(),
      NotificationScreenLender()
    ];

    void _selectTab(int index) {
      // print(index);
      setState(() {
        _selectedPageIndex = index;
        _pageController.animateToPage(_selectedPageIndex, duration: const Duration(milliseconds: 400), curve: Curves.ease);

      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings, color: Colors.grey[700]),
          onPressed: () {
            Navigator.of(context).pushNamed(SettingsScreen.routeName);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_outline,
              size: 30,
              color: Colors.grey[700],
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            },
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'caship',
          style: TextStyle(
              color: Colors.grey[700],
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: isInit ? Center(child: CircularProgressIndicator(),) : PageView(children: pages,controller: _pageController,),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        items: widget.userType.contains('Requester')  ? [
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), title: Text(AppLocalizations.of(context).history)),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), title: Text(AppLocalizations.of(context).request)),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none), title: Text(AppLocalizations.of(context).requests))
        ] : [
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), title: Text(AppLocalizations.of(context).history)),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none), title: Text(AppLocalizations.of(context).pending))
        ],
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
