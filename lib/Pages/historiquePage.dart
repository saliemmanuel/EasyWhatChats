import 'package:easywhatchat/Pages/homePage.dart';
import 'package:easywhatchat/Pages/detailContact.dart';
import 'package:easywhatchat/Pages/models/numeroModels.dart';
import 'package:easywhatchat/db/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';
class Historique extends StatefulWidget {
  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  List numeroPresent;
  TextEditingController controller = new TextEditingController();
  readNumberList() async {
    numeroPresent = await getItems();
    setState((){});
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      indexedPage = 1;
    });
    readNumberList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffEDEBE6),
          image: DecorationImage(
            image: AssetImage("image/bg.png"),
            fit: BoxFit.cover,
          )),
      child: CupertinoScrollbar(
          child: ListView.builder(
        itemCount: numeroPresent == null ? 0 : numeroPresent.length,
        itemBuilder: (c, i) {
          return GestureDetector(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ListTile(
                  leading: InkWell(
                      child: CircleAvatar(
                        child: Icon(
                          LineIcons.user,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.grey,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => DetailPage(
                                  dialCode: numeroPresent[i]["dialcode"],
                                  number: numeroPresent[i]["numero"],
                                  message: numeroPresent[i]["message"],
                                )));
                      }),
                  title: Text(
                        "${numeroPresent[i]["numero"]}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                  subtitle: Text("Mobile"),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.message_sharp,
                      color: Color(0xff25D366),
                    ),
                    onPressed: () {
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
                                    Numero updateNumero = Numero(
                                      0,
                                      "${numeroPresent[i]["dialcode"]}",
                                      "${controller.text}",
                                      "${numeroPresent[i]["numero"]}",
                                    );
                                    update(updateNumero);
                                    launchURL(
                                        "https://api.whatsapp.com/send/?phone=${numeroPresent[i]["dialCode"]}${numeroPresent[i]["numero"]}&text=${controller.text}");
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
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text("Votre message"),
                      content: Text("${numeroPresent[i]["message"]}"),
                      actions: [
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  });
            },
            onLongPressStart: (LongPressStartDetails detail) {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(detail.globalPosition.dx,
                    detail.globalPosition.dy, detail.globalPosition.dx, 0.0),
                items: [
                  PopupMenuItem<String>(
                    value: "numero",
                    textStyle: TextStyle(color: Colors.black),
                    child: Text(
                      '${numeroPresent[i]["numero"]}',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    enabled: false,
                  ),
                  PopupMenuItem<String>(
                    value: "detail",
                    textStyle: TextStyle(color: Colors.black),
                    child: Text("Détail"),
                    enabled: true,
                  ),
                  PopupMenuItem<String>(
                    value: "supprimer",
                    textStyle: TextStyle(color: Colors.black),
                    child: Text("Supprimer"),
                    enabled: true,
                  ),
                  PopupMenuItem<String>(
                    value: "presse-papier",
                    textStyle: TextStyle(color: Colors.black),
                    child: Text("Copier dans le press-papier"),
                    enabled: true,
                  ),
                ],
              ).then((value) {
                switch (value) {
                  case "detail":
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => DetailPage(
                              number: numeroPresent[i]["numero"],
                              message: numeroPresent[i]["message"],
                            )));
                    break;
                  case "supprimer":
                    deleteOneItem('${numeroPresent[i]["numero"]}');
                    readNumberList();
                    Toast.show("Supprimer", context);
                    break;
                  case "presse-papier":
                    Clipboard.setData(
                        new ClipboardData(text: numeroPresent[i]["numero"]));
                        Toast.show("Copier", context);
                    break;
                }
              });

            },
          );
        },
      )),
    );
  }
}
