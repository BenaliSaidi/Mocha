import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:mocha/model/statList.dart';
import 'package:hive_flutter/hive_flutter.dart';


// ignore: must_be_immutable
class Stat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Mocha',
              style: TextStyle(
                  fontSize: 30 , color: Color(0xFF66FCF1)
              ),),
            centerTitle: true,
            backgroundColor: Color(0xFF15171e),
            bottom: TabBar(
              indicatorColor: Color(0xFF66FCF1) ,
              tabs: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text('Matinée',style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold ,color: Color(0xFF66FCF1)),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text('Soirée',style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold ,color: Color(0xFF66FCF1)),),
                ),
              ],
            ),
          ),
          body: Container(
            color:Color(0xFF1F2833) ,
            child:TabBarView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: ListTile(
                          tileColor: Color(0xFF15171e),
                          title:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center ,
                                  width : 90,
                                  child: Text('Recette', style: TextStyle(fontSize: 18 ,color:Color(0xFF45A29E),fontWeight: FontWeight.bold )),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center ,
                                  width : 70,
                                  child: Text('Gain' , style: TextStyle(fontSize: 18 ,color:Color(0xFF45A29E),fontWeight: FontWeight.bold ),),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.center ,
                                  width : 70,
                                  child: Text('Date' , style: TextStyle(fontSize: 18 ,color:Color(0xFF45A29E),fontWeight: FontWeight.bold ),),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.delete,color: Color(0x00000000) ,),
                                  onPressed: () {
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: _listStatViewMorning()),

                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: ListTile(
                          tileColor: Color(0xFF15171e),
                          title:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center ,
                                  width : 90,
                                  child: Text('Recette', style: TextStyle(fontSize: 18 ,color:Color(0xFF45A29E),fontWeight: FontWeight.bold )),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center ,
                                  width : 70,
                                  child: Text('Gain' , style: TextStyle(fontSize: 18 ,color:Color(0xFF45A29E),fontWeight: FontWeight.bold ),),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.center ,
                                  width : 70,
                                  child: Text('Date' , style: TextStyle(fontSize: 18 ,color:Color(0xFF45A29E),fontWeight: FontWeight.bold ),),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.delete,color: Color(0x00000000) ,),
                                  onPressed: () {
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: _listStatViewEvening()),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  // ignore: missing_return
  Widget _listStatViewMorning(){
    return ValueListenableBuilder(
      valueListenable: Hive.box('statMorning').listenable(),
      builder: (context, box, widget) {
        return
          ListView.builder(
            itemCount: Hive.box('statMorning').length,
            itemBuilder: (context, index) {
              final stat = Hive.box('statMorning').getAt(index) as NewList;
              return
                ListTile(
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                    Expanded(
                      flex: 2,
                        child: Container(
                          alignment: Alignment.center ,
                          width: 90,
                          child:Text(stat.recette.toString(),style: TextStyle(fontSize:15 , color: Colors.grey),textAlign:TextAlign.center ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center ,
                          width: 70,
                          child:Text(stat.gain.toString() ,style: TextStyle(fontSize: 15 , color: Colors.grey),textAlign:TextAlign.left),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center ,
                          width: 70,
                          child:Text(stat.dateNow ,style: TextStyle(fontSize: 15 , color: Colors.grey),textAlign:TextAlign.left),
                        ),
                      ),

                      Container(
                        child: IconButton(
                          icon: Icon(Icons.delete,color: Color(0xFF45A29E) ,),
                          onPressed: () {
                            Hive.box('statMorning').deleteAt(index);
                          },
                        ),
                      )
                    ],
                  ),
                );
            },
          );

      },
    );
  }
  Widget _listStatViewEvening(){
    return ValueListenableBuilder(
      valueListenable: Hive.box('statEvening').listenable(),
      builder: (context, box, widget) {
        return
          ListView.builder(
            itemCount: Hive.box('statEvening').length,
            itemBuilder: (context, index) {
              final stat = Hive.box('statEvening').getAt(index) as NewList;
              return
                ListTile(
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center ,
                          width: 90,
                          child:Text(stat.recette.toString(),style: TextStyle(fontSize:15 , color: Colors.grey),textAlign:TextAlign.center ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center ,
                          width: 70,
                          child:Text(stat.gain.toString() ,style: TextStyle(fontSize: 15 , color: Colors.grey),textAlign:TextAlign.left),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center ,
                          width: 70,
                          child:Text(stat.dateNow ,style: TextStyle(fontSize: 15 , color: Colors.grey),textAlign:TextAlign.left),
                        ),
                      ),

                      Container(
                        child: IconButton(
                          icon: Icon(Icons.delete,color: Color(0xFF45A29E) ,),
                          onPressed: () {
                            Hive.box('statEvening').deleteAt(index);
                          },
                        ),
                      )
                    ],
                  ),
                );
            },
          );

      },
    );
  }
}
