import 'package:flutter/material.dart';

abstract class TypeHandler {
  String getType();
  late List<TypeController> controllers;
  late TypeViewer viewer;
}

abstract class TypeController {
  IconData getButtonIconData();
  Future<String> getData();
  Widget? getInputWidget();
}

abstract class TypeViewer {
  Widget build(BuildContext context, String data);
}