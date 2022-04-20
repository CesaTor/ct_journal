import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/widgets/audio_recorder.dart';
import 'package:ct_journal/widgets/log_bar_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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
    return
      Column(
        children: [
          TextFormField(
            cursorColor: Colors.yellow,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            minLines: null,
            maxLines: null,  // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
            controller: logController,
            decoration: const InputDecoration(
              // focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.red, width: 2.0),),
              // border: OutlineInputBorder( borderSide: BorderSide(color: Colors.grey, width: 0.0),),
              contentPadding: EdgeInsets.all(CTLogBarSearchPadding),
              hintText: 'Start writing here!',
              border: InputBorder.none,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TODO - search
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(width: 10,),
                    LogBarIcon(icon: Icons.search),
                    LogBarIcon(icon: Icons.tag),
                  ],
                ),
              ),
              // Audio Recorder
              Expanded(
                child: AudioRecorder(onStop: (path) {
                  if (kDebugMode) {
                    print("Audio produced at: $path");
                  }
                  widget.addClickAction("", ["", path], logController);
                }),
              ),
              // Camera assets and text
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // add Image from Camera
                      LogBarIcon(icon: Icons.camera_alt, onClick: () async {
                        final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                        String path = "";
                        if(image != null) {
                          final directory = await getApplicationDocumentsDirectory();
                          path = directory.path + "/" + image.name;
                          await image.saveTo(path);
                          widget.addClickAction("", [path], logController);
                        }
                        if (kDebugMode) {
                          print("Image: $path");
                        }

                      }),
                      // add Image from Gallery
                      LogBarIcon(icon: Icons.collections, onClick: () async {
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        String path = "";
                        if(image != null) {
                          final directory = await getApplicationDocumentsDirectory();
                          path = directory.path + "/" + image.name;
                          await image.saveTo(path);
                          widget.addClickAction("", [path], logController);
                        }
                        if (kDebugMode) {
                          print("Image: $path");
                        }
                      }),
                      // add text from TextField
                      LogBarIcon(icon: Icons.add, onClick: () {
                        String data = logController.text;
                        if(data.isNotEmpty) {
                          widget.addClickAction(data, [], logController);
                        }
                      }),
                      const SizedBox(width: 10,)
                    ],
                  )
              )
            ],
          ),
        ],
      );
  }
}
