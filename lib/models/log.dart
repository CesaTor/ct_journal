import 'package:hive/hive.dart';

// command to generate type adapters
// flutter packages pub run build_runner build
part 'log.g.dart';

typedef LogCallBack = void Function({required String data, required String type});

@HiveType(typeId: 1)
class Log {
  @HiveField(0)
  DateTime creationDate;
  @HiveField(1)
  String data;
  @HiveField(2)
  String type;

  Log({required this.creationDate, required this.data, required this.type});
}