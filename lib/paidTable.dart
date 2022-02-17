import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Color backgroundcolor = Color(0xFFececec);

Color appbarcolor = Color(0xFF0a0a0a);
Color buttoncolor = Color(0xFF0a0a0a);

class TablePaid extends StatelessWidget {
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
      body: Container(
        child: ListView.builder(
            itemCount: Hive.box('history').length,
            itemBuilder: (context, index) {
              final hist = Hive.box('history').getAt(index);
              return Column(
                children: [
                  Container(
                    height: 50,
                    color: Colors.blueGrey[500],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Table ' + hist.table.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          'Total : ' + hist.total.toString() + ' DA',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          hist.date.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: hist.valNames.length,
                        itemBuilder: (context, indexOne) {
                          var prices = hist.valPrices.values.toList();
                          var names = hist.valNames.values.toList();
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(names[indexOne].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Comfortaa',
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center),
                                  Text(prices[indexOne].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Comfortaa',
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  height: 2,
                                  width: double.maxFinite,
                                  color: Color(0xFF15171e))
                            ],
                          );
                        }),
                  )
                ],
              );
            }),
      ),
    );
  }
}
