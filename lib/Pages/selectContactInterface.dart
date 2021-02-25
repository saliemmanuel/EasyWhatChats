import 'package:easywhatchat/Pages/helper/cardContactInconnue.dart';
import 'package:easywhatchat/Pages/models/callLogModels.dart';
import 'package:easywhatchat/db/db.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectContactInterface extends StatefulWidget {
   TextEditingController controllerNumber;
  SelectContactInterface({this.controllerNumber});
  
  @override
  _SelectContactInterfaceState createState() => _SelectContactInterfaceState();
}

class _SelectContactInterfaceState extends State<SelectContactInterface> {
  final List<CallLogModels> _listCallLog = <CallLogModels>[];
  Icon arrowIcon = Icon(Icons.keyboard_arrow_down_outlined);
  List _logs;
  CallLogModels _callLogModels;
  _insertCallLogdb() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    for (CallLogEntry callN in entries) {
      if (callN.name == null) {
        _callLogModels = CallLogModels(0, callN.number, "");
        saveCallLogs(_callLogModels);
      } 
    }
  }

  _readCallLogsList() async {
    _logs = await getCallLogs();
    _logs.forEach((item) {
      setState(() {
        _listCallLog.add(CallLogModels.map(item));
      });
    });
  }

  @override
  initState() {
    super.initState();
    _insertCallLogdb();
  }

  _expandedListCallLogs() {
    if (arrowIcon.icon == Icons.keyboard_arrow_down_outlined) {
      _readCallLogsList();
      setState(() {
        arrowIcon = Icon(Icons.keyboard_arrow_up_outlined);
      });
    } else {
      setState(() {
        arrowIcon = Icon(Icons.keyboard_arrow_down_outlined);
      });
      _listCallLog.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("Numéros des appels manqués"),
                    trailing: IconButton(
                        icon: arrowIcon,
                        onPressed: () => _expandedListCallLogs()),
                    onTap: () => _expandedListCallLogs(),
                  ),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: _listCallLog == null ? 0 : _listCallLog.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          child: CardContactInconnu(
                            numero: _listCallLog[index].toString(),
                            haveOrNot: true,
                            linkPP: "",
                          ),
                          onTap: ()=>setState(()=> widget.controllerNumber.text = _listCallLog[index].toString()),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60.0,
        ),
      ],
    );
  }
}
