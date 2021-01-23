import 'package:easywhatchat/Pages/helper/cardHisto.dart';
import 'package:easywhatchat/Pages/helper/models/numeroModels.dart';
import 'package:easywhatchat/db/db.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      indexedPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    TextEditingController controllerNumber = new TextEditingController();
    GlobalKey<ScaffoldState> _globalKey = GlobalKey();
    launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      key: _globalKey,
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
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Numéro"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            
                              border: InputBorder.none,
                              hintText: "Entrez le numéro ici..."),
                          controller: controllerNumber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Message"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Entrez le message ici..."),
                          controller: controller,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MaterialButton(
        color: Colors.green,
        onPressed: () async {
          if (controllerNumber.text.isEmpty || controller.text.isEmpty) {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text("Numéro et Message"),
                    content: Text("Entrez un numéro et un message svp !!!"),
                    actions: [
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  );
                });
          } else {
            if (controllerNumber.text.length < 9) {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text("Numéro trop court"),
                      content: Text("Le numéro saisie est trop court"),
                      actions: [
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    );
                  });
            } else {
              Numero nouveauNumero =
                  Numero(0, "${controllerNumber.text}", "${controller.text}");
              saveItem(nouveauNumero);
              launchURL(
                  "https://api.whatsapp.com/send/?phone=237${controllerNumber.text}&text=${controller.text}");
              controllerNumber.clear();
              controller.clear();
            }
          }
        },
        child: Text("Commencer à discuter",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
