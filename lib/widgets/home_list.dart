import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/utils.dart';
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
    List<Widget> widgets = [];

    // Var Appoggio
    DateTime tmpDt = DateTime(1900);
    int currY = 1900;
    int currM = 00;
    int currD = 01;

    for (var element in widget.logList) {
      // Date and Time
      List<Widget> toRight = [];

      // If logTime is not default
      if(
          element.logTime.year != currY ||
          element.logTime.month != currM ||
          element.logTime.day != currD
      ) {
        currY = element.logTime.year;
        currM = element.logTime.month;
        currD = element.logTime.day;

        // If it's a different day, show the date
        toRight.add(
            buildYearW(element.logTime)
        );
      }
      // Post the time only if it differs from 10 minutes
      if(element.logTime.difference(tmpDt).inMinutes >= 10) {
        toRight.add(
            buildTimeW(element.logTime)
        );
      }
      tmpDt = element.logTime;


      if(toRight.isNotEmpty){
        widgets.add(
          right(toRight)
        );
      }

      widgets.add(LogField(logData: element));
    }

    return widgets.reversed.toList();
  }

  Widget right(List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: children,
    );
  }

  Widget buildYearW(DateTime dt) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(child: Text("")),
        Text(dt2ys(dt)),
      ],
    );
  }

  Widget buildTimeW(DateTime dt) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(child: Text("")),
        Text(dt2ts(dt)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
      reverse: true,
      children: bodyBuilder(),
    );
  }
}

