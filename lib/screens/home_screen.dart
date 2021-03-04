import 'package:flutter/material.dart';
import './request_screen.dart';
import './history_screen.dart';
import './notification_screen.dart';
import '../screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 1;
  PageController _pageController; 

  @override
  void initState() {
    _pageController =  PageController(initialPage: _selectedPageIndex);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HistoryScreen(),
      RequestScreen(),
      NotificationScreen()
    ];

    void _selectTab(int index) {
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
            onPressed: () {},
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
      body: PageView(children: pages,controller: _pageController,onPageChanged: _selectTab,),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), title: Text('Historial')),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), title: Text('Solicitar')),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none), title: Text('Pendientes'))
        ],
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
