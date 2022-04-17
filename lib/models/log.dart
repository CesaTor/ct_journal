import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'log.g.dart';

typedef LogCallBack = Function(String str, TextEditingController tec);

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

  // Log.fromJson(Map<String, dynamic> json)
  //     : data = json['data'],
  //       logTime = json['logTime'],
  //       tags = json['tags'],
  //       assetPaths = json['assetPaths'];
  //
  // Map<String, dynamic> toJson() =>
  //     {
  //       'data': data,
  //       'logTime': logTime,
  //       'tags': tags,
  //       'assetPaths': assetPaths
  //     };

}

//   static Log fromJson(String strData) {
//     Map<String, dynamic> dd = jsonDecode(strData);
//
//     String data = "";
//     DateTime logTime = DateTime(0);
//     List<String> tags = ["null"];
//     List<String> assetPaths = ["null"];
//
//     dd.forEach((key, value) {
//       if(key == "data") {
//         data = value;
//       }
//       if(key == "logTime") {
//         logTime = DateTime(value);
//       }
//       // TODO later
//       if(key == "tags") {
//         tags = [];
//       }
//       if(key == "assetPaths"){
//         assetPaths = [];
//       }
//     });
//
//     Log tmp = Log(data: data, assetPaths: assetPaths, logTime: logTime, tags: tags);
//
//     if(data.isEmpty || logTime == DateTime(0) || (tags.length == 1 && tags.first == "null") || (assetPaths.length == 1 && assetPaths.first == "null")) {
//       print("ERROR!!! fromJson not working correctly or incorrect file");
//     }
//
//     return tmp;
//   }
//
//   String toJson() {
//     String tmp = "{";
//
//     tmp += "data: '" + data + "',";
//     tmp += "logTime: '" + logTime.toIso8601String() + "',";
//     tmp += "tags: [";
//     for(int i=0; i<tags.length; i++) {
//       if(i == 0) {
//         tmp += "'${tags[i]}'";
//       } else {
//         tmp += "',${tags[i]}'";
//       }
//     }
//     tmp += "],";
//     tmp += "assetPaths: [";
//     for(int i=0; i<assetPaths.length; i++) {
//       if(i == 0) {
//         tmp += "'${assetPaths[i]}'";
//       } else {
//         tmp += "',${assetPaths[i]}'";
//       }
//     }
//     tmp += "]";
//
//     tmp += "}";
//
//     return tmp;
//   }
// }