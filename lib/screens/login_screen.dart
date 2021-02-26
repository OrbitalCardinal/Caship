import 'package:Caship/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/redirect.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = Map<String, dynamic>();
  bool obscure = true;
  Map<String,String> messageErrors =  {
    'INVALID_PASSWORD': 'La contraseña es incorrecta',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Hubo demasiados intentos de inicio de sesión, vuelva a intentarlo más ',
    'NOT_VERIFIED': 'El correo no ha sido verificado',
    'EMAIL_NOT_FOUND': 'No existe una cuenta asociada a este correo'
  };

  @override
  Widget build(BuildContext context) {
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
                        "Bienvenido",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      Text(
                        "inicia sesión para empezar",
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
                            labelText: "Correo electrónico",
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
                              labelText: "Contraseña",
                              fillColor: Colors.grey[100],
                              filled: true,
                              prefixIcon: Icon(Icons.lock)),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "¿Olvidaste tu contraseña?",
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
                                  await Provider.of<AuthProvider>(context, listen: false)
                                      .login(_formData['email'],
                                          _formData['password'])
                                      .then((_) {
                                        Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                                  });
                                } catch (error) {
                                  print(error.toString());
                                  showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        content: Text(messageErrors[error.toString()] == null ? 'Hubo un error' : messageErrors[error.toString()]),
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
                              "Iniciar sesión",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: 10),
                        Redirect(false)
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
