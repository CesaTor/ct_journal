import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:flutter/material.dart';

class LogField extends StatelessWidget {
  final Log logData;

  const LogField({Key? key, required this.logData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // int day = logData.logTime.day;
    // int month = logData.logTime.month;
    // int year = logData.logTime.year;

    int hour = logData.logTime.hour;
    int minutes = logData.logTime.minute;

    return Container(
      padding: const EdgeInsets.all(paddingSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(child: Text("")),
              Text("$hour:" + ((minutes > 9) ? "$minutes" : "0$minutes"))
            ],
          ),
          Row(
            children: [
              Text(logData.data
                  ,textAlign: TextAlign.left)
            ],
          ),
        ],
      ),
    );
  }
}
