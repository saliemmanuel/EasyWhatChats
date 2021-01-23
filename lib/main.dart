import 'package:easywhatchat/Pages/splachScreen.dart';
import 'package:flutter/material.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
  home: SplashScreeen(),
  theme: ThemeData(
    primaryColor: Color(0xff075E54),

  ),
  debugShowCheckedModeBanner: false,
));}