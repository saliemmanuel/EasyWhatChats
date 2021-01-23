import 'dart:ui';

import 'package:easywhatchat/Pages/helper/models/numeroModels.dart';
import 'package:easywhatchat/db/db.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

var indexedPage = 0;

class CardHisto extends StatelessWidget {
  final numero;
  final message;

  CardHisto({this.numero, this.message});
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return InkWell(
          child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey,
              ),
              title: Row(
                children: [
                  Text(
                    "$numero",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.message_rounded,
                  color: Color(0xff25D366),
                ),
                onPressed: () {
                  // deleteOneItem("$numero}");
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text("Nouveau message"),
                          content: Container(
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
                          actions: [
                            FlatButton(
                              child: Text("Annuler"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            FlatButton(
                              child: Text("Envoyer"),
                              onPressed: () {
                                Numero nouveauNumero =
                                    Numero(0, "$numero", "${controller.text}");
                                update(nouveauNumero);
                                launchURL(
                                    "https://api.whatsapp.com/send/?phone=237$numero&text=${controller.text}");
                                controller.clear();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
              ),
            ),
        ),
      ),
      onTap: (){
         showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text("Votre message"),
                      content: Text("$message"),
                      actions: [
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  });
      },
    );
  }
}
