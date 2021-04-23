import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RequesterLoginScreen extends StatefulWidget {
  static const routeName = 'requesterLogin';
  @override
  _RequesterLoginScreenState createState() => _RequesterLoginScreenState();
}

class _RequesterLoginScreenState extends State<RequesterLoginScreen> {
  // Global variables
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = Map<String, dynamic>();
  bool obscure = true;
  FocusNode userFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    Color accentColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: accentColor,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: AppLocalizations.of(context).welcome,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: " " + AppLocalizations.of(context).requester,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal))
                        ]),
                  ),
                  Text(
                    AppLocalizations.of(context).loginToStart,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('assets/imgs/login.png'),
                      width: 150,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: accentColor,
              ),
              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      // User textfield
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Debe ingresar un correo electrónico';
                          }

                          if (!value.contains(
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
                            return 'Correo eletrónico no valido';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _formData['email'] = value;
                          });
                        },
                        focusNode: userFocusNode,
                        onTap: () {
                          if (!userFocusNode.hasFocus) {
                            setState(() {
                              userFocusNode.unfocus();
                              passwordFocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(userFocusNode);
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).email,
                          labelStyle: TextStyle(
                              color: userFocusNode.hasFocus
                                  ? accentColor
                                  : Colors.grey),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.person,
                            color: userFocusNode.hasFocus
                                ? accentColor
                                : Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[200]),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: accentColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      // Password textfield
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Debe ingresar una contraséña';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _formData['password'] = value;
                          });
                        },
                        obscureText: obscure,
                        focusNode: passwordFocusNode,
                        onTap: () {
                          if (!passwordFocusNode.hasFocus) {
                            setState(() {
                              userFocusNode.unfocus();
                              passwordFocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(passwordFocusNode);
                            });
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              color: obscure ? Colors.grey : accentColor,
                            ),
                          ),
                          labelText: AppLocalizations.of(context).password,
                          labelStyle: TextStyle(
                              color: passwordFocusNode.hasFocus
                                  ? accentColor
                                  : Colors.grey),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.person,
                            color: passwordFocusNode.hasFocus
                                ? accentColor
                                : Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[200]),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: accentColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      // Forgot pass text
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AppLocalizations.of(context).forgotPass,
                            style: TextStyle(color: Colors.grey[600]),
                          )
                        ],
                      ),
                      // Submmit Button
                      SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        child: FlatButton(
                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              print(_formData['email']);
                              try {
                                await Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .login(
                                        _formData['email'],
                                        _formData['password'],
                                        "Requester",
                                        context);
                              } catch (error) {
                                // print(error.toString());
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          content: Text(error.toString()),
                                          actions: [
                                            FlatButton(
                                              child: Text('Continuar'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ));
                              }
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context).login,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          color: accentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
