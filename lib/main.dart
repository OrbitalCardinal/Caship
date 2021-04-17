import 'package:Caship/screens/slides_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import './screens/personalData_screen.dart';
import './screens/signup_screen.dart';
import './screens/terms_screen.dart';
import './providers/terms_provider.dart';
import './providers/auth_provider.dart';
import './providers/user_provider.dart';
import 'screens/home_screen.dart';
import './screens/settings_screen.dart';
import './screens/requestTransaction_screen.dart';
import './screens/aprovalTransaction_screen.dart';
import './screens/profile_screen.dart';
import './screens/userType_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Languages
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(
      BuildContext context, Locale newLocale, int languageGlobal) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setState(() {
      state.myLocale = newLocale;
      state.languageGlobal = languageGlobal;
    });
  }

  static int getPreferedLanguage(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    return state.languageGlobal;
  }

  static saveLanguagePreference(int intLanguage) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'intLanguage';
    final value = intLanguage;
    prefs.setInt(key, value);
    print('save: $intLanguage');
  }
}

class _MyAppState extends State<MyApp> {
  readLanguagePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'intLanguage';
    final int value = prefs.getInt(key);
    setState(() {
      languageGlobal = value;
      if (languageGlobal == 0) {
        myLocale = Locale('es', '');
      } else {
        myLocale = Locale('en', '');
      }
    });
    print("read: $value");
  }

  Locale myLocale = null;
  int languageGlobal;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    readLanguagePreferences();
  }

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
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: null,
          update: (context, auth, previousUserInfo) =>
              UserProvider(auth.token, auth.userId),
        )
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authData, _) => MaterialApp(
          locale: myLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Colors.lightGreen,
              accentColor: Colors.purple,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: TextTheme(
                  headline6: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                  headline4: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35))),
          // home: SlidesScreen(),
          home: authData.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator(),) : SlidesScreen(),
                ),
          routes: {
            SlidesScreen.routeName: (ctx) => SlidesScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            PersonalDataScreen.routeName: (ctx) => PersonalDataScreen(),
            SignUpScreen.routeName: (ctx) => SignUpScreen(),
            TermsScreen.routeName: (ctx) => TermsScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            SettingsScreen.routeName: (ctx) => SettingsScreen(),
            RequestTransactionScreen.routeName: (ctx) =>
                RequestTransactionScreen(),
            AprovalTransactionScreen.routeName: (ctx) =>
                AprovalTransactionScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            UserTypeScreen.routeName: (ctx) => UserTypeScreen()
          },
        ),
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
