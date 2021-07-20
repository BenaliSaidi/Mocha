import 'package:flutter/material.dart';
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

class Home extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String statKey;
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
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: GridView.count(
          crossAxisCount: gridViewlayout(),
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => productList()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserConfirmation()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActiveAccount()),
                );
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
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     Container(
      //       margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      //       child: OutlineButton(
      //         splashColor: Color(0xFFa7a7a7),
      //         highlightedBorderColor: buttoncolor,
      //         padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
      //         child: Text(
      //           "Produits",
      //           style: TextStyle(fontSize: 28, color: buttoncolor),
      //         ),
      //         borderSide: BorderSide(
      //           color: buttoncolor,
      //         ),
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => productList()),
      //           );
      //         },
      //       ),
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     Container(
      //       margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      //       child: OutlineButton(
      //         splashColor: Color(0xFFa7a7a7),
      //         highlightedBorderColor: buttoncolor,
      //         padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
      //         child: Text(
      //           "Commandes",
      //           style: TextStyle(
      //             fontSize: 28,
      //             color: buttoncolor,
      //           ),
      //         ),
      //         borderSide: BorderSide(
      //           color: buttoncolor,
      //         ),
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => CounterMenu()),
      //           );
      //         },
      //       ),
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     Container(
      //       margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      //       child: OutlineButton(
      //           splashColor: Color(0xFFa7a7a7),
      //           highlightedBorderColor: buttoncolor,
      //           padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
      //           child: Text(
      //             "Statistiques",
      //             style: TextStyle(
      //               fontSize: 28,
      //               color: buttoncolor,
      //             ),
      //           ),
      //           borderSide: BorderSide(
      //             color: buttoncolor,
      //           ),
      //           onPressed: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(builder: (context) => UserConfirmation()),
      //             );
      //           }),
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     Container(
      //       margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      //       child: OutlineButton(
      //         splashColor: Color(0xFFa7a7a7),
      //         highlightedBorderColor: buttoncolor,
      //         padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      //         child: Text(
      //           "Abonnement",
      //           style: TextStyle(
      //             fontSize: 28,
      //             color: buttoncolor,
      //           ),
      //         ),
      //         borderSide: BorderSide(
      //           color: buttoncolor,
      //         ),
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => ActiveAccount()),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
