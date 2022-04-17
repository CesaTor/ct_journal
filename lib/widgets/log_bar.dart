import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:flutter/material.dart';

class LogBar extends StatefulWidget {

  final LogCallBack addClickAction;
  const LogBar({Key? key, required this.addClickAction}) : super(key: key);

  @override
  State<LogBar> createState() => _LogBarState();
}

class _LogBarState extends State<LogBar> {

  final TextEditingController logController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        color: CTLogBarBG,
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: TextFormField(
                controller: logController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(paddingSpace),
                  hintText: 'Start logging here or type \'?\' to search.',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.question_mark_sharp),
                      iconSize: 12,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.tag),
                      iconSize: 12,
                      onPressed: () {},
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 12,
                  onPressed: () {
                    String data = logController.text;
                    if(data.isNotEmpty) {
                      widget.addClickAction(data, logController);
                    }
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}