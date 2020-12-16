import 'package:flutter/material.dart';
import 'package:mocha/displayProductList.dart';

void main() => runApp(MaterialApp(home: Home(),));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2833),
      appBar: AppBar(
        title: Text(
          'Mocha',
          style: TextStyle(
              fontSize: 30 , color: Color(0xFF66FCF1)
          ),),
        centerTitle: true,
        backgroundColor: Color(0xFF0B0C10),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30 , 0),
            child: OutlineButton(
              splashColor:Color(0xFF45A29E),
              highlightedBorderColor:  Color(0xFF1F2833),
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              child: Text("Produits" , style: TextStyle(fontSize: 28, color: Color(0xFF66FCF1) ),),
              borderSide: BorderSide(
                color: Color(0xFF66FCF1),
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
            margin: EdgeInsets.fromLTRB(30, 0, 30 , 0),
            child: OutlineButton(
              splashColor:Color(0xFF45A29E),
              highlightedBorderColor: Color(0xFF0B0C10),
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              child: Text("Comptoir" , style: TextStyle(fontSize: 28, color: Color(0xFF66FCF1) ),),
              borderSide: BorderSide(
                color: Color(0xFF66FCF1),
              ),
              onPressed: () {
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30 , 0),
            child: OutlineButton(
              splashColor:Color(0xFF45A29E),
              highlightedBorderColor: Color(0xFF0B0C10),
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              child: Text("Statistiques" , style: TextStyle(fontSize: 28, color: Color(0xFF66FCF1) ),),
              borderSide: BorderSide(
                color: Color(0xFF66FCF1),
              ),
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    );
  }
}
