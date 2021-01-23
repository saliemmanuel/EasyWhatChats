import 'package:easywhatchat/Pages/acceuilPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBordingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return OnBordingPage();
  }
}

class OnBordingPage extends StatefulWidget {
  @override
  _OnBordingPageState createState() => _OnBordingPageState();
}

class _OnBordingPageState extends State<OnBordingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void finIntro(context) async {
    SharedPreferences perf = await SharedPreferences.getInstance();
    String onBordingDone = 'done';
    perf.setString('done', onBordingDone);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => AcceuilPage()), (route) => false);
  }

  Widget buildImage(String ass) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Align(
        child: Image.asset(
          'image/$ass.PNG',
          height: 200.0,
          width: 200.0,
        ),
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      body: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title: 'Bienvenue sur Easy WhatChats ',
            body:
                'Vous êtes fatigué 😣😣 d\'enregistrer à chaque fois des nouveaux contacts sur votre smartphone 📱 avant de discuter sur WhatsApp ?',
            image: buildImage('i2'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: 'Avec Easy WhatChats',
            body:
                'Pas de panique discutez avec n\'importe quel contact sans avoir à l\'enregistré ! 😃😃 ',
            image: buildImage('i3'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: 'Easy WhatChats',
            body: 'Vous rend la vie Easy 😁😁 tous ça en un seul clic !!!',
            image: buildImage('i4'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => finIntro(context),
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text("Skip"),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done'),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeColor: Colors.black,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
