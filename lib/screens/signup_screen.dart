import 'dart:ui';
import 'package:Caship/providers/auth_provider.dart';
import '../screens/slides_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../screens/terms_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscure1 = true;
  bool obscure2 = true;

  bool agree = false;

  final formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  Map<String, dynamic> _formData = Map<String, dynamic>();

  bool _changeAgree(_) {
    setState(() {
      agree = !agree;
    });
    return agree;
  }

  Future<void> _submit(BuildContext context) async {
    if (!agree) {
      showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Terminos y condiciones'),
            content: Text(
                'Debe aceptar los terminos y condiciones para registrarse'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'))
            ],
          ));
    } else {
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        showDialog(
        context: context,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
          ),
        ),
        barrierDismissible: false);
        try {
          await Provider.of<AuthProvider>(context, listen: false)
              .signup(_formData['email'], _formData['password']);
        } catch (error) {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              child: AlertDialog(
                title: Text('Error de solicitud HTTP'),
                content: Text('Ocurrió un error al tratar de registrarse'),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Okay'))
                ],
              ));
          return;
        }
        showDialog(
            context: context,
            child: AlertDialog(
              content: Text('Se envió un correo de verificación'),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Okay'),
                ),
              ],
            )).then((_) {
          Navigator.of(context).pushReplacementNamed(SlidesScreen.routeName);
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> personalData =
        ModalRoute.of(context).settings.arguments;
    Color accentColor = Theme.of(context).accentColor;
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Paso 2 de 2',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Crea una cuenta',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                    ),
                    Text(
                      'Registrate con tu correo \nelectrónico para usar Caship',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    )
                  ],
                ),
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
                        _formData['email'] = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Correo eletrónico',
                        fillColor: Colors.grey[100],
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Debe ingresar una contraseña';
                        }
                        if (!value.contains(RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$'))) {
                          return 'Su contraseña no cumple con los requisitos';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _formData['password'] = value;
                      },
                      obscureText: obscure1,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure1 = !obscure1;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: obscure1 ? Colors.grey : accentColor,
                          ),
                        ),
                        labelText: 'Contraseña',
                        fillColor: Colors.grey[100],
                        filled: true,
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Debe confirmar la contraseña';
                        }
                        if (!value.contains(_passwordController.text)) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                      obscureText: obscure2,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure2 = !obscure2;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: obscure2 ? Colors.grey : accentColor,
                          ),
                        ),
                        labelText: 'Confirmar contraseña',
                        fillColor: Colors.grey[100],
                        filled: true,
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: primaryColor,
                            ),
                            Text(
                              ' Un mínimo de seis caracteres.',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: primaryColor,
                            ),
                            Text(' Una letra mayuscula.',
                                style: TextStyle(color: Colors.grey))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: primaryColor,
                            ),
                            Text(' Un número.',
                                style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    ListTile(
                      leading: Checkbox(value: agree, onChanged: _changeAgree),
                      title: RichText(
                        overflow: TextOverflow.fade,
                        text: TextSpan(
                            text: 'Estoy de acuerdo con los ',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                            children: [
                              TextSpan(
                                text: 'terminos y condiciones.',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .pushNamed(TermsScreen.routeName);
                                  },
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () async {
                          _submit(context);
                        },
                        child: Text(
                          'Registrarse',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Redirect(true),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
