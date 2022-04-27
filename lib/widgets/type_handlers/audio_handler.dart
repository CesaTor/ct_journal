import 'dart:io';

import 'package:ct_journal/constants.dart';
import 'package:ct_journal/widgets/ct_audio_player.dart';
import 'package:ct_journal/widgets/ct_audio_recorder.dart';
import 'package:ct_journal/widgets/type_handlers/type_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AudioHandler implements TypeHandler {

  @override
  TypeViewer viewer = AudioViewer();

  @override
  String getType() {
    return "audio";
  }

  @override
  List<TypeController> controllers = [
    AudioController(),
  ];

}

class AudioViewer implements TypeViewer {
  @override
  Widget build(BuildContext context, String data) {
    return CTAudioPlayer(filePath: data);
  }
}

class AudioController implements TypeController {

  late String _path;

  @override
  IconData getButtonIconData() {
    return Icons.mic;
  }

  @override
  Future<String> getData() async{
    if(_path.isNotEmpty) {
      return _path;
    }
    throw Exception("Audiocontroller.getData() - ERROR - Empty path");
  }

  @override
  Widget? getInputWidget() {
    return CTAudioRecorder(onStop: (path) {
      _path = path;
    });
  }
}