import 'dart:io';

import 'package:flutter/material.dart';
import 'package:record/record.dart';

class VoiceRecorder extends StatefulWidget {
  const VoiceRecorder({Key? key}) : super(key: key);

  @override
  State<VoiceRecorder> createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder> {
  final record = Record();
  bool recorderState = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.keyboard_voice, color: ((recorderState == true) ? Colors.red : Colors.white)),
        iconSize: 12,
        onPressed: () async {
          // bool result = await record.hasPermission();
          // print("Record plugin info - recorder has permission: $result");
          // String dir = Directory.current.path;
          // print("Record plugin info - directory: $dir");


          // if(result) {
          //   bool isRecording = await record.isRecording();
          //   if(isRecording) {
          //     if(isRecording != recorderState) {
          //       setState(() {
          //         recorderState = isRecording;
          //       });
          //     }
          //     print("Record plugin info - stop recording");
          //     await record.stop();
          //   } else {
          //     DateTime dt = DateTime.now();
          //     print("Record plugin info - start recording file ${dt.toIso8601String()}");
          //     await record.start(
          //       path: '$dir/${dt.toIso8601String()}.m4a', // required
          //       encoder: AudioEncoder.AAC, // by default
          //     );
          //   }
          // } else {
          //   print("Record plugin error - no permission found");
          // }

        }
    );
  }
}
