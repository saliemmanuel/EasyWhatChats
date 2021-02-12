import 'package:easywhatchat/Pages/helper/cardContactInconnue.dart';
import 'package:easywhatchat/Pages/helper/getPermissionHandler.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';

class SelectContactInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List list = [
      {
        "numero": "698066896",
        "linkPP": "http:/link",
        "haveOrNot": true,
      },
         {
        "numero": "698066896",
        "linkPP": "http:/link",
        "haveOrNot": true,
      },
    ];
    GetPermissionHandler _getPermission = GetPermissionHandler();

    return Column(
      children: [
        Card(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Numéro Inconnu"),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60.0,
        ),
        //Teste pour acceder au Call_log
        IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              _getPermission.checkCallLogPermission();
            }),

        //Interface a utiliser une fois fini le test
        ListView.builder(
          primary: false,
          itemCount: list.length == 0 ? 0 : list.length,
          itemBuilder: (_, i) {
            return CardContactInconnu(
              numero: list[i]["numero"],
              linkPP: list[i]["linkPP"],
              haveOrNot: list[i]["haveOrNot"],
            );
          },
        ),
      ],
    );
  }
}
