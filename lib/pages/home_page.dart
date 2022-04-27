import 'package:ct_journal/constants.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/models/handler_factory.dart';
import 'package:ct_journal/widgets/ct_log_list.dart';
import 'package:ct_journal/widgets/ct_home_bar.dart';
import 'package:ct_journal/widgets/type_handlers/audio_handler.dart';
import 'package:ct_journal/widgets/type_handlers/image_handler.dart';
import 'package:ct_journal/widgets/type_handlers/text_handler.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Log> _logList = [];
  late final HandlerFactory handlerFactory;

  _HomePageState() {
    // Getting logs from HiveDb's box
    for(Log log in box.values) {
      _logList.add(log);
    }
    // Init Factory
    handlerFactory = HandlerFactory(handlers: [
      ImageHandler(),
      TextHandler(),
      // AudioHandler(),
    ]);

  }

  // Adding logs to local data and save
  void addLog(Log log) {
    setState(() {
      _logList.add(log);
      box.add(log);
    });
  }

  void logCallBack({
    required String data,
    required String type}) {

    addLog(
        Log(data: data, creationDate: DateTime.now(), type: type)
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CTLogBarBG, // TODO - learn how to do theming correctly
        body:
        Column(
          children: [
            Expanded(
                child:
                CTLogList(logList: _logList, handlerFactory: handlerFactory),
            ), // List of all Logs // TODO - test with big data and in case, find a way to reduce lag (es. get 10 logs x time)
            CTHomeBar(addClickAction: logCallBack, handlerFactory: handlerFactory,), // Why is it not a BottomNavBar? -> keyboard pops up -> it gets hidden under
          ],
        )
    );
  }
}
