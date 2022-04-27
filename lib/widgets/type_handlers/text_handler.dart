import 'package:ct_journal/constants.dart';
import 'package:ct_journal/widgets/type_handlers/type_handler.dart';
import 'package:flutter/material.dart';

class TextHandler implements TypeHandler {

  @override
  TypeViewer viewer = TextViewer();

  @override
  String getType() {
    return "text";
  }

  @override
  List<TypeController> controllers = [TextController()];

}

class TextViewer implements TypeViewer {
  @override
  Widget build(BuildContext context, String data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child:
      Text(
        data,
        textAlign: TextAlign.left,
        maxLines: null,
        overflow: TextOverflow.clip,
        softWrap: true,
      ),
    );
  }
}

class TextController implements TypeController {

  final TextEditingController _ted = TextEditingController();

  @override
  IconData getButtonIconData() {
    return Icons.add;
  }

  @override
  Future<String> getData() async{
    String text = _ted.text;
    if(text.isNotEmpty) {
      _ted.clear();
      return text;
    }
    throw Exception("TextHandler - controller read empty text");
  }

  @override
  Widget getInputWidget() {
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
            controller: _ted,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(CTLogBarSearchPadding),
              hintText: 'Start writing here!',
              border: InputBorder.none,
            ),
          ),
        )
    );
  }

}