import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'log.g.dart';

typedef LogCallBack = Function(
    TextEditingController tec,
    {String text,
    String audioPath,
    String imagePath});

@HiveType(typeId: 1)
class Log {

  @HiveField(0)
  String text;
  @HiveField(1)
  DateTime creationDate;
  @HiveField(2)
  String audioPath;
  @HiveField(3)
  String imagePath;


  Log({required this.creationDate, this.text = "", this.audioPath = "", this.imagePath = ""});
}

