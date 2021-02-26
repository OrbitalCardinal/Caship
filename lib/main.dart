import 'package:Caship/screens/slides_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import './screens/personalData_screen.dart';
import './screens/signup_screen.dart';
import './screens/terms_screen.dart';
import './providers/terms_provider.dart';
import './providers/auth_provider.dart';
import 'screens/home_screen.dart';
import './screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TermsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.lightGreen,
          accentColor: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: {
          SlidesScreen.routeName: (ctx) => SlidesScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          PersonalDataScreen.routeName: (ctx) => PersonalDataScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          TermsScreen.routeName: (ctx) => TermsScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen()

        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("Hola"),
      ),
    );
  }
}
