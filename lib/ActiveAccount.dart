import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mocha/model/endtime.dart';
import 'package:mocha/model/pwd.dart';
import 'package:toast/toast.dart';
import 'package:mocha/home.dart';

class ActiveAccount extends StatefulWidget {
  @override
  _ActiveAccountState createState() => _ActiveAccountState();
}

class _ActiveAccountState extends State<ActiveAccount> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyOne = GlobalKey<FormState>();
  DateTime endTime;
  bool _isEnable = false;
  var activationKey = 'leidenschaftic';
  String activatedperiod;
  String pass;

  void UpdatePwd(PassWord pwd) {
    final psw = Hive.box('password');
    psw.clear();
    psw.add(pwd);
  }

  void addNewPeriod(Period period) {
    Hive.box('period').delete('time');
    Hive.box('period').put('time', period);
  }

  displayEndTime() {
    var expdate = Hive.box('period').get('time').endtime;
    var formatter = new DateFormat('yyyy-MM-dd');
    var formatted = formatter.format(expdate);
    print(formatted);
    return formatted;
  }

  displayDifference() {
    var expdate = Hive.box('period').get('time').endtime;
    var diff = (expdate).difference(DateTime.now());
    print(diff.inDays);
    return diff.inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2833),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        height: 200,
                        width: 180,
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text('changez votre mot de passe'),
                            SizedBox(
                              height: 30,
                            ),
                            Form(
                              key: _formKeyOne,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      //fontSize: 20,
                                      color: buttoncolor,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white10,
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          color: buttoncolor, fontSize: 13),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            width: 2, color: buttoncolor),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    onSaved: (value) => pass = value,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'SVP entrez un nom valide';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  buttoncolor)),
                                      onPressed: () {
                                        if (_formKeyOne.currentState
                                            .validate()) {
                                          _formKeyOne.currentState.save();

                                          final newpwd = PassWord(pass);
                                          UpdatePwd(newpwd);
                                          _formKeyOne.currentState.reset();
                                          Toast.show(
                                              "mot de apsse sauvegardé avec succès",
                                              context,
                                              duration: 1,
                                              gravity: Toast.BOTTOM,
                                              textColor: Color(0xFF66FCF1));
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 13.0, bottom: 13),
                                          child: Text(
                                            '     Sauvegarder     ',
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          )
        ],
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
                    onChanged: (value) {
                      if (value == activationKey) {
                        setState(() {
                          _isEnable = true;
                        });
                      } else {
                        setState(() {
                          _isEnable = false;
                        });
                      }
                    },
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      labelText: 'Clé d\'activation',
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
                        return 'SVP entrez une clé valide';
                      }
                      return null;
                    },

                    // onSaved: (value) => _ActivateKey = value,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    enabled: _isEnable,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      labelText: 'Date d\'expiration',
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
                        return 'SVP entrez une clé valide';
                      }
                      return null;
                    },
                    onSaved: (value) => activatedperiod = value,
                  ),
                  SizedBox(height: 50),
                  RaisedButton(
                    color: Color(0xFF66FCF1),
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        final timeend = DateTime.now()
                            .add(Duration(days: int.parse(activatedperiod)));
                        final newperiod = Period(timeend);
                        addNewPeriod(newperiod);
                        _formKey.currentState.reset();
                        Toast.show("abonnement renouvelé avec succès", context,
                            duration: 2,
                            gravity: Toast.CENTER,
                            textColor: Color(0xFF66FCF1));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      }
                      setState(() {
                        displayEndTime();
                      });
                    },
                    child: Text('Active le compte',
                        style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Date d\'expiration : ' + displayEndTime().toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'jours restants ' + displayDifference().toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
