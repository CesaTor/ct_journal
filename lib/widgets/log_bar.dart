import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/widgets/audio_recorder.dart';
import 'package:ct_journal/widgets/voice_recorder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LogBar extends StatefulWidget {

  final LogCallBack addClickAction;
  const LogBar({Key? key, required this.addClickAction}) : super(key: key);

  @override
  State<LogBar> createState() => _LogBarState();
}

class _LogBarState extends State<LogBar> {

  final TextEditingController logController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
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
                  hintText: 'This day is going to be beautiful',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
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
                Row(
                 children: [
                   // VoiceRecorder(),
                   AudioRecorder(onStop: (path) {
                     print("----------------------------------------------\nAudio produced at: $path\n----------------------------------------------------");
                   }),
                   // IconButton(
                   //     icon: const Icon(Icons.camera_alt),
                   //     iconSize: 12,
                   //     onPressed: () async {
                   //       final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                   //     }
                   // ),
                   // IconButton(
                   //     icon: const Icon(Icons.collections),
                   //     iconSize: 12,
                   //     onPressed: () async {
                   //       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                   //     }
                   // ),
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
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
