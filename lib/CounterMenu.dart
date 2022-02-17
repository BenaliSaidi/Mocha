import 'package:flutter/material.dart';
import 'package:mocha/TablesEvening.dart';
import 'TablesMorning.dart';

Color backgroundcolor = Color(0xFFececec);
Color appbarcolor = Color(0xFF0a0a0a);
Color buttoncolor = Color(0xFF0a0a0a);

class CounterMenu extends StatelessWidget {
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
        backgroundColor: Color(0xFF455A64),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: OutlineButton.icon(
              splashColor: Color(0xFF455A64),
              highlightedBorderColor: Color(0xFF455A64),
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              label: Text(
                " Matin",
                style: TextStyle(fontSize: 28, color: buttoncolor),
              ),
              borderSide: BorderSide(
                color: Color(0xFF455A64),
              ),
              icon: Icon(Icons.wb_sunny, color: buttoncolor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TablesMorning()),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: OutlineButton.icon(
              splashColor: Color(0xFF455A64),
              highlightedBorderColor: buttoncolor,
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              label: Text(
                "Soir",
                style: TextStyle(fontSize: 28, color: buttoncolor),
              ),
              borderSide: BorderSide(
                color: Color(0xFF455A64),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TablesEvening()),
                );
              },
              icon: Icon(
                Icons.nights_stay,
                color: buttoncolor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
