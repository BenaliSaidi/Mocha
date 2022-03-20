import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Color backgroundcolor = Color(0xFFececec);

class delProducts extends StatelessWidget {
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
        child: Column(
          children: [
            ListTile(
              tileColor: Color(0xFF455A64),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text('Article',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Prix',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Table',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Date',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: Hive.box('deletedProduct').length,
                  itemBuilder: (context, index) {
                    final delpro = Hive.box('deletedProduct').getAt(index);
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 70,
                              child: Text(
                                delpro.name.toString(),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ),
                            Container(
                              child: Text(
                                delpro.price.toString(),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ),
                            Container(
                              child: Text(
                                delpro.table.toString(),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ),
                            Container(
                              child: Text(
                                delpro.date.toString(),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                          thickness: 2,
                        ),
                        // SizedBox(height: 20),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
