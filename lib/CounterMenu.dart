import 'package:flutter/material.dart';
import 'package:mocha/counterMorning.dart';

//void main() => runApp(MaterialApp(home: Home(),));

class counterMenu extends StatelessWidget {
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
            child: OutlineButton.icon(
              splashColor:Color(0xFF45A29E),
              highlightedBorderColor:  Color(0xFF45A29E),
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              label: Text("Matin" , style: TextStyle(fontSize: 28, color: Color(0xFF66FCF1) ),),
              borderSide: BorderSide(
                color: Color(0xFF66FCF1),
              ),
              icon:Icon(Icons.wb_sunny,color: Color(0xFF66FCF1)) ,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CounterMorning()),
                );

              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30 , 0),
            child: OutlineButton.icon(
              splashColor:Color(0xFF45A29E),
              highlightedBorderColor: Color(0xFF0B0C10),
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              label: Text("Soir" , style: TextStyle(fontSize: 28, color: Color(0xFF66FCF1) ),),
              borderSide: BorderSide(color: Color(0xFF66FCF1),),
              onPressed: () {
              },
              icon:Icon(Icons.nights_stay,color: Color(0xFF66FCF1),) ,
            ),
          ),

        ],
      ),
    );
  }
}
