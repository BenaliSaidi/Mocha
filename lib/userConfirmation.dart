import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mocha/model/endtime.dart';
import 'package:mocha/stat.dart';
import 'package:toast/toast.dart';
import 'package:mocha/home.dart';

class UserConfirmation extends StatefulWidget {
  @override
  _UserConfirmationState createState() => _UserConfirmationState();
}

class _UserConfirmationState extends State<UserConfirmation> {
  final _formKey = GlobalKey<FormState>();

  var confirmation = 'erflogC18';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2833),
      appBar: AppBar(
        title: Text(
          'Mocha',
          style: TextStyle(fontSize: 30, color: Color(0xFF66FCF1)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0B0C10),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 60.0, 40.0, 00.0),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      labelText: 'Inserez Votre mot de passe SVP',
                      labelStyle:
                          TextStyle(color: Color(0xFF66FCF1), fontSize: 13),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(width: 2, color: Color(0xFF66FCF1)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'SVP INSEREZ UN MDP VALIDE';
                      }
                      if (value != 'erflogC18') {
                        return 'SVP INSEREZ UN MDP VALIDE';
                      }
                      return null;
                    },

                    // onSaved: (value) => _ActivateKey = value,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(height: 50),
                  RaisedButton(
                    color: Color(0xFF66FCF1),
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Stat()),
                        );
                      }
                    },
                    child: Text('Vers Statistiques',
                        style: TextStyle(fontSize: 20)),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
