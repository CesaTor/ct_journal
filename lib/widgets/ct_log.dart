import 'dart:io';
import 'dart:math';
import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/widgets/ct_audio_player.dart';
import 'package:flutter/material.dart';

class CTLog extends StatelessWidget {
  final Log logData;

  const CTLog({Key? key, required this.logData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildAudio(String path) {
      return CTAudioPlayer(filePath: path );
    }

    Widget _buildImg(String path) {
      return
        SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.width - 40,
            child: Image.file(File(path))
        );
    }

    Widget _buildText(String text) {
      return SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child:
        Text(
          text,
          textAlign: TextAlign.left,
          maxLines: null,
          overflow: TextOverflow.clip,
          softWrap: true,
        ),
      );
    }

    Widget _buildCorrectWidget() {
      if(logData.text.isNotEmpty){
        return _buildText(logData.text);
      }
      if(logData.audioPath.isNotEmpty) {
        return _buildAudio(logData.audioPath);
      }
      if(logData.imagePath.isNotEmpty) {
        return _buildImg(logData.imagePath);
      }
      return Text("LOG WIDGET ERROR - No right widget found for log: [$logData]");
    }

    return Container(
      padding: const EdgeInsets.only(left: CTLogBarSearchPadding, right: CTLogBarSearchPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCorrectWidget()
          // const Divider(color: Colors.red,thickness: 2)
        ],
      ),
    );
  }
}
