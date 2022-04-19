import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'log.g.dart';

typedef LogCallBack = Function(String data, List<String> assetPaths, TextEditingController tec);

@HiveType(typeId: 1)
class Log {

  @HiveField(0)
  late String data;
  @HiveField(1)
  late DateTime logTime;
  @HiveField(2)
  late List<String> tags;
  @HiveField(3)
  late List<String> assetPaths;

  Log(
      {required this.data, required this.logTime, required this.tags, required this.assetPaths});
}