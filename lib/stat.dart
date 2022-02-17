import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:mocha/model/statList.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:number_pagination/number_pagination.dart';

List<dynamic> unites = [];
var selectedPageNumber_Eve = 1;
int startKey_Eve;
int endKey_Eve;
int nbrOfpage_Eve;

var selectedPageNumber_Mor = 1;
int startKey_Mor;
int endKey_Mor;
int nbrOfpage_Mor;

void setPageEvening(selectedPage_Eve) {
  int longueur = Hive.box('statEvening').length;
  nbrOfpage_Eve = (longueur ~/ 20) + 1;

  startKey_Eve = (selectedPage_Eve - 1) * 20;
  endKey_Eve = (selectedPage_Eve * 20);
  while (endKey_Eve > longueur) {
    endKey_Eve--;
  }
}

void setPageMorning(selectedPage_Mor) {
  int longueur = Hive.box('statMorning').length;
  nbrOfpage_Mor = (longueur ~/ 20) + 1;

  startKey_Mor = (selectedPage_Mor - 1) * 20;
  endKey_Mor = (selectedPage_Mor * 20);
  while (endKey_Mor > longueur) {
    endKey_Mor--;
  }
}

// ignore: must_be_immutable
class Stat extends StatefulWidget {
  @override
  State<Stat> createState() => _StatState();
}

class _StatState extends State<Stat> {
  @override
  Widget build(BuildContext context) {
    setPageMorning(selectedPageNumber_Mor);
    setPageEvening(selectedPageNumber_Eve);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Mocha',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Color(0xFF455A64),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                    'Matinée',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                    'Soirée',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            color: Colors.grey[300],
            child: TabBarView(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 50,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 90,
                                  child: Text('Recette',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  child: Text(
                                    'Gain',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  child: Text(
                                    'Date',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(0x00000000),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Color(0x00000000),
                                  ),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: _listStatViewMorning()),
                      NumberPagination(
                        onPageChanged: (int pageNumber) {
                          setPageMorning(selectedPageNumber_Mor);
                          setState(() {
                            selectedPageNumber_Mor = pageNumber;
                          });
                        },
                        pageTotal: nbrOfpage_Mor,
                        pageInit:
                            selectedPageNumber_Mor, // picked number when init page
                        colorPrimary: Colors.white,
                        colorSub: Color(0xFF455A64),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 50,
                        child: ListTile(
                          //   tileColor: Color(0xFF15171e),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 90,
                                  child: Text('Recette',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  child: Text(
                                    'Gain',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  child: Text(
                                    'Date',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(0x00000000),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Color(0x00000000),
                                  ),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: _listStatViewEvening()),
                      NumberPagination(
                        onPageChanged: (int pageNumber) {
                          setPageEvening(selectedPageNumber_Eve);
                          setState(() {
                            selectedPageNumber_Eve = pageNumber;
                          });
                        },
                        pageTotal: nbrOfpage_Eve,
                        pageInit:
                            selectedPageNumber_Eve, // picked number when init page
                        colorPrimary: Colors.white,
                        colorSub: Color(0xFF455A64),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _listStatViewEvening() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('statEvening').listenable(),
      builder: (context, box, widget) {
        print(Hive.box('statEvening').length);
        var state = Hive.box('statEvening').values.toList();
        var teslistToDisplay =
            state.getRange(startKey_Eve, endKey_Eve).toList();
        return ListView.builder(
          // shrinkWrap: true,
          itemCount: teslistToDisplay.length,
          itemBuilder: (context, index) {
            final stat = Hive.box('statEvening').getAt(index) as NewList;
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      width: 90,
                      child: Text(teslistToDisplay[index].recette.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      width: 70,
                      child: Text(teslistToDisplay[index].gain.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      //width: 70,
                      child: Text(teslistToDisplay[index].dateNow.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Color(0xFF45A29E),
                        ),
                        onPressed: () {
                          var names =
                              teslistToDisplay[index].histPro.keys.toList();
                          var prices =
                              teslistToDisplay[index].histPro.values.toList();
                          print(prices);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    height: 400,
                                    width: 300,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: stat.histPro.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    child: Text(
                                                        names[index]
                                                            .toString()
                                                            .toLowerCase(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Comfortaa',
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                  Container(
                                                    width: 50,
                                                    child: Text(
                                                        prices[index]
                                                            .toString()
                                                            .toLowerCase(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Comfortaa',
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 3, bottom: 3),
                                                  height: 2,
                                                  width: double.maxFinite,
                                                  color: Color(0xFF15171e))
                                            ],
                                          );
                                        }),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        Hive.box('statEvening').deleteAt(index);
                        setPageEvening(selectedPageNumber_Eve);
                        setState(() {});
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

  Widget _listStatViewMorning() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('statMorning').listenable(),
      builder: (context, box, widget) {
        print(Hive.box('statMorning').length);
        var state = Hive.box('statMorning').values.toList();
        var teslistToDisplay =
            state.getRange(startKey_Mor, endKey_Mor).toList();
        return ListView.builder(
          shrinkWrap: true,
          itemCount: teslistToDisplay.length,
          itemBuilder: (context, index) {
            final stat = Hive.box('statMorning').getAt(index) as NewList;
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      width: 90,
                      child: Text(teslistToDisplay[index].recette.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      width: 70,
                      child: Text(teslistToDisplay[index].gain.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      //width: 70,
                      child: Text(teslistToDisplay[index].dateNow.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Color(0xFF45A29E),
                        ),
                        onPressed: () {
                          var names =
                              teslistToDisplay[index].histPro.keys.toList();
                          var prices =
                              teslistToDisplay[index].histPro.values.toList();
                          print(prices);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    height: 400,
                                    width: 300,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: stat.histPro.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    child: Text(
                                                        names[index]
                                                            .toString()
                                                            .toLowerCase(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Comfortaa',
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                  Container(
                                                    width: 50,
                                                    child: Text(
                                                        prices[index]
                                                            .toString()
                                                            .toLowerCase(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Comfortaa',
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 3, bottom: 3),
                                                  height: 2,
                                                  width: double.maxFinite,
                                                  color: Color(0xFF15171e))
                                            ],
                                          );
                                        }),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        Hive.box('statMorning').deleteAt(index);
                        setPageMorning(selectedPageNumber_Mor);
                        setState(() {});
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
