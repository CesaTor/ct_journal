import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/widgets/log_field.dart';
import 'package:flutter/material.dart';

class HomeList extends StatefulWidget {

  final List<Log> logList;
  const HomeList({Key? key, required this.logList}) : super(key: key);

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {

  List<Widget> bodyBuilder() {
    List<Widget> data = [];

    int year = 1900;
    int month = 01;
    int day = 01;

    for (var element in widget.logList) {
      if(
      element.logTime.year != year ||
          element.logTime.month != month ||
          element.logTime.day != day
      ) {
        year = element.logTime.year;
        month = element.logTime.month;
        day = element.logTime.day;
        data.add(
            Center(
              child:
              Text(
                ((day > 9) ? "$day" : "0$day") + "-" +
                    ((month > 9) ? "$month" : "0$month") + "-" +
                    "$year"
                ,style: const TextStyle(fontSize: 18),
              ),
            )
        );
      }
      data.add(LogField(logData: element));
    }

    return data.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
      reverse: true,
      children: bodyBuilder(),
    );
  }
}

