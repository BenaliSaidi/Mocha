import 'package:flutter/material.dart';
import 'package:mocha/displayProductList.dart';
import 'package:mocha/CounterMenu.dart';
import 'package:mocha/stat.dart';
import 'package:mocha/userConfirmation.dart';
import 'package:toast/toast.dart';
import 'ActiveAccount.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

Color backgroundcolor = Color(0xFFececec);
Color appbarcolor = Color(0xFF0a0a0a);
Color buttoncolor = Color(0xFF0a0a0a);

class Home extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String statKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        title: Text(
          'Mocha',
          style: TextStyle(fontSize: 30, color: backgroundcolor),
        ),
        centerTitle: true,
        backgroundColor: appbarcolor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: OutlineButton(
              splashColor: Color(0xFFa7a7a7),
              highlightedBorderColor: buttoncolor,
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              child: Text(
                "Produits",
                style: TextStyle(fontSize: 28, color: buttoncolor),
              ),
              borderSide: BorderSide(
                color: buttoncolor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => productList()),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: OutlineButton(
              splashColor: Color(0xFFa7a7a7),
              highlightedBorderColor: buttoncolor,
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              child: Text(
                "Commandes",
                style: TextStyle(
                  fontSize: 28,
                  color: buttoncolor,
                ),
              ),
              borderSide: BorderSide(
                color: buttoncolor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CounterMenu()),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: OutlineButton(
                splashColor: Color(0xFFa7a7a7),
                highlightedBorderColor: buttoncolor,
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                child: Text(
                  "Statistiques",
                  style: TextStyle(
                    fontSize: 28,
                    color: buttoncolor,
                  ),
                ),
                borderSide: BorderSide(
                  color: buttoncolor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserConfirmation()),
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: OutlineButton(
              splashColor: Color(0xFFa7a7a7),
              highlightedBorderColor: buttoncolor,
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Text(
                "Abonnement",
                style: TextStyle(
                  fontSize: 28,
                  color: buttoncolor,
                ),
              ),
              borderSide: BorderSide(
                color: buttoncolor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActiveAccount()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
