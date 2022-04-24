import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/widgets/ct_audio_recorder.dart';
import 'package:ct_journal/widgets/ct_home_bar_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CTHomeBar extends StatefulWidget {

  final LogCallBack addClickAction;
  const CTHomeBar({Key? key, required this.addClickAction}) : super(key: key);

  @override
  State<CTHomeBar> createState() => _CTHomeBarState();
}

class _CTHomeBarState extends State<CTHomeBar> {

  final TextEditingController _logController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          _buildHBInput(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: _buildHBUtilityBtns()
              ),
              // Audio Recorder
              Expanded(
                child: CTAudioRecorder(onStop: (path) {
                  if (kDebugMode) {
                    print("Audio produced at: $path");
                  }
                  widget.addClickAction(_logController, audioPath: path);
                }),
              ),
              // Camera assets and text
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildCameraInputBtn(),
                      _buildGalleryInputBtn(),
                      _buildAddBtn(),
                      const SizedBox(width: 10,)
                    ],
                  )
              )
            ],
          ),
        ],
      );
  }

  // add text from TextField
  CTHomeBarIcon _buildAddBtn() {
    return CTHomeBarIcon(icon: Icons.add, onClick: () {
      String text = _logController.text;
      if(text.isNotEmpty) {
        widget.addClickAction(_logController, text: text);
      }
    });
  }

  Widget _buildHBInput() {
    return Container(
        constraints: const BoxConstraints(maxHeight: 100),
        child: SingleChildScrollView(
          child:
          TextFormField(
            autofocus: true,
            keyboardAppearance: Brightness.dark,
            cursorColor: Colors.yellow,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            minLines: null,
            maxLines: null,  // If null, there is no limit to the number of lines
            controller: _logController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(CTLogBarSearchPadding),
              hintText: 'Start writing here!',
              border: InputBorder.none,
            ),
          ),
        )
    );
  }

  // TODO - search
  Widget _buildHBUtilityBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        SizedBox(width: 10,),
        CTHomeBarIcon(icon: Icons.search),
        CTHomeBarIcon(icon: Icons.tag),
      ],
    );
  }

  // add Image from Camera
  CTHomeBarIcon _buildCameraInputBtn() {
    return
      CTHomeBarIcon(icon: Icons.camera_alt, onClick: () async {
        final XFile? image = await _picker.pickImage(source: ImageSource.camera);
        String path = "";
        if(image != null) {
          final directory = await getApplicationDocumentsDirectory();
          path = directory.path + "/images/" + image.name;
          await image.saveTo(path);
          widget.addClickAction(_logController, imagePath: path);
        }
        if (kDebugMode) {
          print("Image: $path");
        }
      });
  }

  // add Image from Gallery
  CTHomeBarIcon _buildGalleryInputBtn() {
    return
      CTHomeBarIcon(icon: Icons.collections, onClick: () async {
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        String path = "";
        if(image != null) {
          final directory = await getApplicationDocumentsDirectory();
          path = directory.path + "/images/" + image.name;
          await image.saveTo(path);
          widget.addClickAction(_logController, imagePath: path);
        }
        if (kDebugMode) {
          print("Image: $path");
        }
      });
  }
}
