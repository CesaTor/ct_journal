import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/widgets/ct_log_list.dart';
import 'package:ct_journal/widgets/ct_home_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Log> _logList = [];

  _HomePageState() {
    // Getting logs from HiveDb's box
    for(Log log in box.values) {
      _logList.add(log);
    }
  }

  // Adding logs to local data and save
  void addLog(Log log) {
    setState(() {
      _logList.add(log);
      box.add(log);
    });
  }
  // TODO - removeLog - editLog

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CTLogBarBG, // TODO - learn how to do theming correctly
        body:
        Column(
          children: [
            Expanded(
                child:
                LogList(logList: _logList),
            ), // List of all Logs // TODO - test with big data and in case, find a way to reduce lag (es. get 10 logs x time)
            CTHomeBar(addClickAction: (tec, {text = "", audioPath = "", imagePath = ""}) {
              addLog(
                  Log(text: text, creationDate: DateTime.now(), audioPath: audioPath, imagePath: imagePath)
              );
              tec.clear();
            }), // Why is it not a BottomNavBar? -> keyboard pops up -> it gets hidden under
          ],
        )
    );
  }
}
