import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> init() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LogAdapter());
  box = await Hive.openBox('DiaryBox');
}

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CT Journal',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'CT Journal - Home'),
    );
  }
}

