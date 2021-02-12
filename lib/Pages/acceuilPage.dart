import 'package:easywhatchat/Pages/apropos.dart';
import 'package:easywhatchat/Pages/chatsPage.dart';
import 'package:easywhatchat/Pages/historiquePage.dart';
import 'package:easywhatchat/db/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AcceuilPage extends StatefulWidget {
  @override
  _AcceuilPageState createState() => _AcceuilPageState();
}
var indexedPage = 0;
class _AcceuilPageState extends State<AcceuilPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Easy WhatChats"),
            elevation: 0.7,
            actions: <Widget>[
              PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    value: "profil",
                    textStyle: TextStyle(color: Colors.black),
                    child: Text("Profil"),
                    height: 30.0,
                    enabled: true,
                  ),
                  indexedPage == 1
                      ? null
                      : PopupMenuItem(
                          value: "historique",
                          textStyle: TextStyle(color: Colors.black),
                          child: Text("Effacer Historique"),
                          height: 30.0,
                          enabled: true,
                        ),
                  PopupMenuItem(
                    value: "apropos",
                    textStyle: TextStyle(color: Colors.black),
                    child: Text("À-Propos"),
                    height: 30.0,
                    enabled: true,
                  ),
                  PopupMenuItem(
                    value: "exit",
                    textStyle: TextStyle(color: Colors.black),
                    child: Text("Quitter"),
                    height: 30.0,
                    enabled: true,
                  ),
                ],
                onSelected: (value) {
                  if (value == "apropos") {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => Apropos()));
                  }
                  if (value == "historique") {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text("Supprimer tous l'historique ?"),
                            content: Text("Cette action est irréversible"),
                            actions: [
                              FlatButton(
                                child: Text("Annuler"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              FlatButton(
                                child: Text("Supprimer"),
                                onPressed: () {
                                  deleteItem();
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  }
                  if (value == "exit") {
                    SystemNavigator.pop();
                  }
                },
                tooltip: "À-Propos",
              ),
            ],
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 4.5,
              tabs: <Widget>[
                Tab(
                  text: "Chats",
                ),
                Tab(
                  text: "Historique",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ChatsPage(),
              Historique(),
            ],
          ),
        ));
  }
}
