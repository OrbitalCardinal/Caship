import 'package:Caship/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/redirect.dart';
import 'home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = Map<String, dynamic>();
  bool obscure = true;
  Map<String, String> messageErrors = {
    'INVALID_PASSWORD': 'La contraseña es incorrecta',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Hubo demasiados intentos de inicio de sesión, vuelva a intentarlo más ',
    'NOT_VERIFIED': 'El correo no ha sido verificado',
    'EMAIL_NOT_FOUND': 'No existe una cuenta asociada a este correo',
    'USER_TYPE_WRONG': "Tipo de cuenta erroneo"
  };

  @override
  Widget build(BuildContext context) {
    Map<String, String> args = ModalRoute.of(context).settings.arguments as Map<String, String>;
    String userType;
    String userTypeArg = args["userType"];
    setState(() {
      if (args["userType"].contains("Lender")) {
        userType = AppLocalizations.of(context).lender;
      } else {
        userType = AppLocalizations.of(context).requester;
      }
    });
    Color primaryColor = Theme.of(context).primaryColor;
    Color accentColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            // color: Colors.black,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).welcome,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      Text(
                        userType,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        AppLocalizations.of(context).loginToStart,
                        style: TextStyle(color: Colors.grey[600], fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Image(
                  image: AssetImage('assets/imgs/login.png'),
                  width: 150,
                ),
                SizedBox(height: 15),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
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
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).email,
                            fillColor: Colors.grey[100],
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 10),
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
                              fillColor: Colors.grey[100],
                              filled: true,
                              prefixIcon: Icon(Icons.lock)),
                        ),
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
                                      .login(_formData['email'],
                                          _formData['password'],
                                          userTypeArg, context);
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
