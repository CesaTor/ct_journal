import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

// Number to padded String
String n2ps(int n) => n.toString().padLeft(2, "0");

// DateTIme 2 Year String
String dt2ys(DateTime dt) {
  DateTime tmp = DateTime.now();
  if(tmp.day == dt.day && tmp.month == dt.month && tmp.year == dt.year){
    return "Today";
  }
  return DateFormat.yMMMMd().format(dt).toString();
  // return "${n2s(dt.day)}-${n2s(dt.month)}-${dt.year}";
}

// DateTIme 2 Time String
String dt2ts(DateTime dt) {
  return "${n2ps(dt.hour)}:${n2ps(dt.minute)}:${n2ps(dt.second)}";
}

// Duration 2 label
String d2l(Duration duration) {
  String h = "";
  String min = n2ps(duration.inMinutes.remainder(60));
  String sec = n2ps(duration.inSeconds.remainder(60));

  if(duration.inHours > 0) {
    h = n2ps(duration.inHours) + ":";
  }
  return "$h$min:$sec";
}

// TODO implement + backup assets
Future<void> backupHiveBox<T>(String boxName, String backupPath) async {
  final box = await Hive.openBox<T>(boxName);
  final boxPath = box.path;
  await box.close();

  try {
    File(boxPath!).copy(backupPath);
  } finally {
    await Hive.openBox<T>(boxName);
  }
}

Future<void> restoreHiveBox<T>(String boxName, String backupPath) async {
  final box = await Hive.openBox<T>(boxName);
  final boxPath = box.path;
  await box.close();

  try {
    File(backupPath).copy(boxPath!);
  } finally {
    await Hive.openBox<T>(boxName);
  }
}
