import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mocha/displayProductList.dart';
import 'package:mocha/CounterMenu.dart';
import 'package:mocha/stat.dart';
import 'package:mocha/userConfirmation.dart';
import 'package:toast/toast.dart';
import 'ActiveAccount.dart';

Size displaySize(BuildContext context) {
  print('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

Color backgroundcolor = Color(0xFFececec);

Color appbarcolor = Color(0xFF0a0a0a);
Color buttoncolor = Color(0xFF0a0a0a);
int row;
String pass;
String psw;

String mdp() {
  // if (Hive.box('password').isNotEmpty) {
  //   psw = Hive.box('password').getAt(0).pwd;
  // } else {
  //   psw = 'admin';
  // }
  psw = "admin";
  return psw;
}

class Home extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  //String statKey;
  @override
  Widget build(BuildContext context) {
    int gridViewlayout() {
      if (displaySize(context).width < 400) {
        row = 2;
      } else {
        row = 4;
      }
      return row;
    }

    mdp();

    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        title: Text(
          'Mocha',
          style: TextStyle(fontSize: 30, color: backgroundcolor),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF455A64),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: GridView.count(
          crossAxisCount: gridViewlayout(),
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          height: 200,
                          width: 200,
                          padding: EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      obscureText: true,
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
                                          return 'SVP INSEREZ UN MDP VALIDE';
                                        }
                                        if (value != psw) {
                                          return 'SVP INSEREZ UN MDP VALIDE';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 30),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(buttoncolor)),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      productList()),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0, bottom: 13),
                                            child: Text(
                                              '   vers produits   ',
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
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.emoji_food_beverage_outlined,
                      size: 60,
                    ),
                    Text(
                      'Produits',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Recursive'),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CounterMenu()),
                );
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.table_view,
                      size: 60,
                    ),
                    Text(
                      'Commandes',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Recursive'),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          height: 200,
                          width: 200,
                          padding: EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      obscureText: true,
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
                                          return 'SVP INSEREZ UN MDP VALIDE';
                                        }
                                        if (value != psw) {
                                          return 'SVP INSEREZ UN MDP VALIDE';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 30),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(buttoncolor)),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Stat()),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0, bottom: 13),
                                            child: Text(
                                              '   vers statistiques   ',
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
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.list_rounded,
                      size: 60,
                    ),
                    Text(
                      'statistiques',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Recursive'),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          height: 200,
                          width: 200,
                          padding: EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      obscureText: true,
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
                                          return 'SVP INSEREZ UN MDP VALIDE';
                                        }
                                        if (value != psw) {
                                          return 'SVP INSEREZ UN MDP VALIDE';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 30),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(buttoncolor)),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ActiveAccount()),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0, bottom: 13),
                                            child: Text(
                                              '   vers mon compte   ',
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ActiveAccount()),
                // );
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 60,
                    ),
                    Text(
                      'Mon Compte',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Recursive'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
