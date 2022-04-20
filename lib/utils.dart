import 'package:intl/intl.dart';

String n2s(int n) {
  return (n > 9) ? "$n" : "0$n";
}

String dt2ys(DateTime dt) {
  DateTime tmp = DateTime.now();
  if(tmp.day == dt.day && tmp.month == dt.month && tmp.year == dt.year){
    return "Today";
  }
  return DateFormat.yMMMMd().format(dt).toString();
  // return "${n2s(dt.day)}-${n2s(dt.month)}-${dt.year}";
}

String dt2ts(DateTime dt) {
  return "${n2s(dt.hour)}:${n2s(dt.minute)}:${n2s(dt.second)}";
}
