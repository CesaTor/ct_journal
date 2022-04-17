import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/widgets/home_list.dart';
import 'package:ct_journal/widgets/log_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Log> logList = [];

  _MyHomePageState() {
    for(Log log in box.values) {
      logList.add(log);
    }
  }

  void addData(Log data) {
    setState(() {
      logList.add(data);
      box.add(data);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:
        Column(
          children: [
            Expanded(
                child: HomeList(logList: logList)
            ),
            LogBar(addClickAction: (data, controller) {
              addData(
                  Log(data: data, logTime: DateTime.now(), tags: [], assetPaths: [])
              );
              controller.clear();
            }),
          ],
        )
    );
  }
}
