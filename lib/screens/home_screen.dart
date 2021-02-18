import 'package:flutter/material.dart';
import './request_screen.dart';
import './history_screen.dart';
import './notification_screen.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 1;
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
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.settings, color: Colors.grey[700]), onPressed: (){},),
        actions: [
          IconButton(icon: Icon(Icons.person_outline,size: 30, color: Colors.grey[700],), onPressed: (){},)
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('caship', style: TextStyle(color: Colors.grey[700], fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),),
      ),
      body: pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), title: Text('Historial')),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), title: Text('Solicitar')),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), title: Text('Notificaciones'))
        ],
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
