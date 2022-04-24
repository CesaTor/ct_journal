import 'dart:io';

import 'package:ct_journal/costanti.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> init() async {
  // Init HiveDb
  await Hive.initFlutter();
  Hive.registerAdapter(LogAdapter());
  box = await Hive.openBox('a');

  // Create asset folders
  final directory = await getApplicationDocumentsDirectory();
  if(!await Directory(directory.path+"/images").exists()){
    await Directory(directory.path+"/images").create();
  }
  if(!await Directory(directory.path+"/audio").exists()){
    await Directory(directory.path+"/audio").create();
  }

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
      home: const HomePage(title: 'CT Journal - Home'),
    );
  }
}

