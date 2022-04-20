import 'dart:io';
import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/utils.dart';
import 'package:ct_journal/widgets/audio_player.dart';
import 'package:flutter/material.dart';

class LogField extends StatelessWidget {
  final Log logData;

  const LogField({Key? key, required this.logData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int hour = logData.logTime.hour;
    int minute = logData.logTime.minute;
    int second = logData.logTime.second;

    Widget buildAudioW() {
      return AudioPlayerW(filePath: logData.assetPaths[1]);
    }

    Widget buildImgW() {
      return
        SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.width - 40,
            child: Image.file(File(logData.assetPaths.first))
        );
    }

    Widget buildTextW() {
      return SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child:
        Text(
          logData.data,
          textAlign: TextAlign.left,
          maxLines: null,
          overflow: TextOverflow.clip,
          softWrap: true,
        ),
      );
    }



    return Container(
      padding: const EdgeInsets.only(left: CTLogBarSearchPadding, right: CTLogBarSearchPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // buildTimeW(),
          Row(
            children: [
              logData.data.isNotEmpty
                  ? buildTextW()
                  : logData.assetPaths.isNotEmpty
                  ? logData.assetPaths.first != ""
                  ? buildImgW()
                  : logData.assetPaths[1] != ""
                  ? buildAudioW()
                  : const Text("")
                  : const Text("")
            ],
          ),
          // const Divider(color: Colors.red,thickness: 2)
        ],
      ),
    );
  }
}
