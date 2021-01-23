import 'package:flutter/material.dart';

class Apropos extends StatefulWidget {
  @override
  _AproposState createState() => _AproposState();
}

class _AproposState extends State<Apropos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("À-propos"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffEDEBE6),
          image: DecorationImage(
            image: AssetImage("image/bg.png"),
                fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.info,
                          color: Colors.black87,
                        ),
                        title: Text("FS - Université Maroua"),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.black87,
                        ),
                        title: Text("Auteur"),
                        subtitle: Text("Sali Emmanuel"),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.contacts,
                          color: Colors.black87,
                        ),
                        title: Text("Contacts "),
                        subtitle: Text(
                            "Téléphone : +237 698066896\nFacebook : Sali Emmanuel Johnson\nInstagram : @_dotDev\nTelegram @NullByte\nGit : https://github.com/saliemmanuel "),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Easy WhatChats  v1.0.0 Copyright 2021 "),
                  leading: Icon(
                    Icons.info,
                    color: Colors.black87,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
