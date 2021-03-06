import 'package:ct_journal/constants.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/models/handler_factory.dart';
import 'package:ct_journal/utils.dart';
import 'package:ct_journal/widgets/ct_log.dart';
import 'package:flutter/material.dart';

class CTLogList extends StatefulWidget {

  final List<Log> logList;
  final HandlerFactory handlerFactory;
  const CTLogList({Key? key, required this.logList, required this.handlerFactory}) : super(key: key);

  @override
  State<CTLogList> createState() => _CTLogListState();
}

class _CTLogListState extends State<CTLogList> {

  List<Widget> bodyBuilder() {
    List<Widget> widgets = [];

    DateTime tmpDt = DateTime(1900);
    int currY = 1900;
    int currM = 00;
    int currD = 01;

    for (var element in widget.logList) {
      // Date and Time
      List<Widget> toRight = [];

      // If logTime is not default
      if(
          element.creationDate.year != currY ||
          element.creationDate.month != currM ||
          element.creationDate.day != currD
      ) {
        currY = element.creationDate.year;
        currM = element.creationDate.month;
        currD = element.creationDate.day;

        // If it's a different day, show the date
        toRight.add(const Divider(color: Colors.yellow, thickness: 1),);
        toRight.add(
            buildYearW(element.creationDate)
        );
        toRight.add(const Divider(color: Colors.yellow, thickness: 1),);
      }
      // Post the time only if it differs from 10 minutes
      if(element.creationDate.difference(tmpDt).inMinutes >= 10) {
        toRight.add(
            buildTimeW(element.creationDate)
        );
      }
      tmpDt = element.creationDate;
      if(toRight.isNotEmpty){
        widgets.add(
          right(toRight)
        );
      }

      widgets.add(CTLog(logData: element, hf: widget.handlerFactory));
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
        Text(dt2ys(dt), style: const TextStyle(fontSize: 18) ),
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

