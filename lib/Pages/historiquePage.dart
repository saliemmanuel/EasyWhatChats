import 'package:easywhatchat/Pages/helper/cardHisto.dart';
import 'package:easywhatchat/Pages/helper/models/numeroModels.dart';
import 'package:easywhatchat/db/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Historique extends StatefulWidget {
  @override
  _HistoriqueState createState() => _HistoriqueState();
}
List numeroPresent;  
final List<Numero> listNumero = <Numero>[];
class _HistoriqueState extends State<Historique> {

  readToDoList() async {
   numeroPresent = await getItems();
    numeroPresent.forEach((item) {
      setState(() {
        listNumero.add(Numero.map(item));
      });
    });
  }


  @override
  void initState() {
    super.initState();
     setState(() {
    indexedPage = 1;
    });
    readToDoList();
    
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
        itemCount: numeroPresent == null ? 0 :numeroPresent.length,
        itemBuilder: (c, i) {
          return CardHisto(
            numero: numeroPresent[i]["numero"],
            message:  numeroPresent[i]["message"],
          );
        },
      )),
    );
  }
}
