import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CardContactInconnu extends StatelessWidget {
  final numero;
  final linkPP;
  final haveOrNot;

  const CardContactInconnu({Key key, this.numero, this.linkPP, this.haveOrNot})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 15.0,
              ),
              CircleAvatar(
                child: Icon(
                  LineIcons.user,
                  size: 30.0,
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey,
              ),
              custumListTile(subtitle: "Mobile", title: numero),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: dataInformation(haveOrNot),
          ),
        ],
      ),
    );
  }
}

Widget custumListTile({String title, String subtitle}) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 15.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 15.0),
          child: Text(
            subtitle,
          ),
        )
      ]);
}

Widget dataInformation(bool haveOrNot) {
  return Row(
    children: [
      haveOrNot
          ? Icon(
              LineIcons.whatsapp,
              size: 30.0,
              color: Color(0xff25D366),
            )
          : Icon(
              LineIcons.whatsapp,
              size: 30.0,
              color: Colors.red,
            ),
    ],
  );
}
