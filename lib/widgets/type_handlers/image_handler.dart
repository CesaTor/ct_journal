import 'dart:io';

import 'package:ct_journal/constants.dart';
import 'package:ct_journal/widgets/type_handlers/type_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHandler implements TypeHandler {

  @override
  TypeViewer viewer = ImageViewer();

  @override
  String getType() {
    return "image";
  }

  @override
  List<TypeController> controllers = [
    ImageController(isGallery: true),
    ImageController()
  ];

}

class ImageViewer implements TypeViewer {
  @override
  Widget build(BuildContext context, String data) {
    return
      SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: MediaQuery.of(context).size.width - 40,
          child: Image.file(File(data))
      );
  }
}

class ImageController implements TypeController {
  late String _imgAF;
  late bool isGallery;

  initAssetFolder() async{
    // Create image assets folder
    if(!await Directory(assetPath + "/images").exists()){
      await Directory(assetPath+"/images").create(recursive: true);
    }
    _imgAF = assetPath+"/images/";
  }

  ImageController({this.isGallery = false}) {
    initAssetFolder();
  }

  @override
  IconData getButtonIconData() {
    return isGallery ? Icons.collections : Icons.camera_alt;
  }

  @override
  Future<String> getData() async{
    final ImagePicker _picker = ImagePicker();
    String _imgPath = "";
    final XFile? image = await _picker.pickImage(source: isGallery ? ImageSource.gallery : ImageSource.camera);

    if(image != null) {
      _imgPath = _imgAF + image.name;
      await image.saveTo(_imgPath);
    }

    if(_imgPath.isEmpty) {
      throw Exception("ImageHandler.getData() - ERROR - empty image path found!");
    }
    return _imgPath;
  }

  @override
  Widget? getInputWidget() {
    return null;
  }
}