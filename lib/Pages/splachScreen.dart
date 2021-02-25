import 'package:easywhatchat/Pages/homePage.dart';
import 'package:easywhatchat/Pages/introPage.dart';
import 'package:easywhatchat/db/db.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreeen extends StatefulWidget {
  @override
  _SplashScreeenState createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    super.initState();
    initDatabase();
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var onBoardingDone = prefs.getString('done');
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) =>
              onBoardingDone == null ? OnBordingScreen() : AcceuilPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "image/i1.PNG",
                  height: 200,
                  width: 200,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Easy WhatChats",
                  style: TextStyle(
                      fontSize: 37.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text("Par Sali Emmanuel",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
