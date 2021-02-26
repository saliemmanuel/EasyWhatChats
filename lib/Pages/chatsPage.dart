import 'package:easywhatchat/Pages/homePage.dart';
import 'package:easywhatchat/Pages/models/numeroModels.dart';
import 'package:easywhatchat/Pages/selectContactInterface.dart';
import 'package:easywhatchat/db/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:country_code_picker/country_code_picker.dart';

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
    TextEditingController controllerMessage = new TextEditingController();
    TextEditingController controllerNumber = new TextEditingController();
    GlobalKey<ScaffoldState> _globalKey = GlobalKey();
    String numberCode = "+237";
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
        child: CupertinoScrollbar(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView(
              shrinkWrap: false,
              children: [
                custCard(
                    numberCodeWidget: CountryCodePicker(
                      initialSelection: 'CM',
                      favorite: ["FR","CI", "CM", "CA"],
                      padding: const EdgeInsets.only(right: 20.0),
                      onChanged: (value) {
                        numberCode = value.dialCode;
                      },
                    ),
                    label: "Numéro",
                    hintText: "Entrez le numéro ici...",
                    controller: controllerNumber,
                    isNumber: true),
                custCard(
                    numberCodeWidget: null,
                    label: "Message",
                    hintText: "Entrez le message ici...",
                    controller: controllerMessage,
                    isNumber: false),
                SizedBox(
                  height: 10.0,
                ),
                SelectContactInterface(controllerNumber: controllerNumber),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: MaterialButton(
        color: Colors.green,
        onPressed: () async{
          if (controllerNumber.text.isEmpty || controllerMessage.text.isEmpty) {
            alertDialog(
                titleAlert: "Erreur",
                contentAlert: "Entrez un numéro et un message svp !!!");
          } else {
            if (controllerNumber.text.length < 9) {
              alertDialog(
                  titleAlert: "Numéro trop court",
                  contentAlert: "Le numéro saisie est trop court");
            } else {
              Numero nouveauNumero = Numero(
                  0, "$numberCode","${controllerNumber.text}", "${controllerMessage.text}");
              saveItem(nouveauNumero);
              launchURL("https://api.whatsapp.com/send/?phone=$numberCode${controllerNumber.text}&text=${controllerMessage.text}");
              controllerNumber.clear();
              controllerMessage.clear();
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

  Future alertDialog({String titleAlert, String contentAlert}) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(titleAlert),
            content: Text(contentAlert),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget custCard(
      {Widget numberCodeWidget,
      String label,
      String hintText,
      TextEditingController controller,
      bool isNumber}) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(label),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey)),
              child: TextField(
                keyboardType:
                    isNumber ? TextInputType.phone : TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: numberCodeWidget,
                    hintText: hintText),
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
