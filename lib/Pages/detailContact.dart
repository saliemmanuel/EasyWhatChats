import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class DetailPage extends StatelessWidget {
  final number;
  final message;
  final dialCode;

  const DetailPage({Key key, this.number, this.message, this.dialCode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Easy WhatChats"),
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffEDEBE6),
          image: DecorationImage(
            image: AssetImage("image/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Container(
                color: Color(0xff075E54),
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                child: Icon(
                  LineIcons.user,
                  size: 250.5,
                  color: Colors.white,
                )),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Card(
                    elevation: 3.0,
                    child: ListTile(
                      leading: Icon(
                        LineIcons.phone,
                        color: Color(0xff25D366),
                        size: 30.0,
                      ),
                      trailing: Icon(
                        Icons.message_sharp,
                        color: Color(0xff25D366),
                      ),
                      title: Text(number),
                      subtitle: Text("Numéro principal"),
                    ),
                  ),
                  Card(
                    elevation: 3.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 12.0),
                          child: Text(
                            "Message",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff075E54),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: Text(message),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 3.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 12.0),
                          child: Text(
                            "Code Pays",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff075E54),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: Text(dialCode),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
