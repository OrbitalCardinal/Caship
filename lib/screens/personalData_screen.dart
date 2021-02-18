import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../widgets/redirect.dart';
import '../screens/signup_screen.dart';
import 'package:intl/intl.dart';

class PersonalDataScreen extends StatefulWidget {
  static const routeName = '/personalData';

  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  Country country;
  DateTime selectedDate;

  final formKey = GlobalKey<FormState>();
  Map<String,dynamic> data = Map<String,dynamic>();

  void _countrySelected(value) {
    setState(() {
      country = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Paso 1 de 2',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cuentanos sobre ti',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(
                      'Caship requiere verificar algunos datos personales para registrarte',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Debe ingresar sus nombres';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          data['names'] = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Nombres',
                        fillColor: Colors.grey[100],
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Debe ingresar sus apellidos';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          data['lastnames'] = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Apellidos',
                        fillColor: Colors.grey[100],
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        showCountryPicker(
                            context: context,
                            onSelect: (country) {
                              _countrySelected(country);
                            });
                      },
                      child: TextFormField(
                        onSaved: (value) {
                          setState(() {
                            data['country'] = country.name;
                          });
                        },
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: country == null ? 'País' : country.name,
                          fillColor: Colors.grey[100],
                          filled: true,
                          prefixIcon: Icon(Icons.location_on),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                        onConfirm: (time) {
                          setState(() {
                            selectedDate = time;
                          });
                        },
                            theme: DatePickerTheme(
                                itemStyle: TextStyle(color: primaryColor),
                                doneStyle: TextStyle(color: primaryColor)));
                      },
                      child: TextFormField(
                        onSaved: (value) {
                          setState(() {
                            data['birthdate'] = selectedDate;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: selectedDate == null ? 'Fecha de nacimiento' : DateFormat('dd/MM/yy').format(selectedDate),
                          fillColor: Colors.grey[100],
                          filled: true,
                          enabled: false,
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Debe ingresar un número telefonico';
                        }
                        if(value.length < 10) {
                          return 'Teléfono invalido';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data['phone'] = country.phoneCode + value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Teléfono',
                        fillColor: Colors.grey[100],
                        filled: true,
                        prefix: Text(country == null ? '' :
                          '+${country.phoneCode}  ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () {
                          if(formKey.currentState.validate()) {
                            if(country == null) {
                              showDialog(context: context, child: AlertDialog(
                                title: Text('Campos incompletos'),
                                content: Text('Debe seleccionar su país de residencia'),
                                actions: [
                                  FlatButton(child: Text('Okay'), onPressed: () => Navigator.of(context).pop(),)
                                ],
                              ));
                              return;
                            }
                            if(selectedDate == null) {
                                showDialog(context: context, child: AlertDialog(
                                  title: Text('Campos incompletos'),
                                  content: Text('Debe ingresar su fecha de nacimiento'),
                                  actions: [
                                    FlatButton(child: Text('Okay'), onPressed: () => Navigator.of(context).pop(),)
                                  ],
                                ));
                                return;
                            }
                            if(selectedDate.year > 2002) {
                              showDialog(context: context, child: AlertDialog(
                                  title: Text('Campos incompletos'),
                                  content: Text('No cuenta con edad apta para registrarse en caship'),
                                  actions: [
                                    FlatButton(child: Text('Okay'), onPressed: () => Navigator.of(context).pop(),)
                                  ],
                                ));
                                return;
                            }
                            formKey.currentState.save();
                            Navigator.of(context)
                                .pushNamed(SignUpScreen.routeName, arguments: data);
                          }
                        },
                        child: Text(
                          'Continuar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Redirect(true)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
