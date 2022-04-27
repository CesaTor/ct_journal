import 'dart:io';

import 'package:ct_journal/constants.dart';
import 'package:ct_journal/models/log.dart';
import 'package:ct_journal/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> init() async {
  // Init HiveDb
  await Hive.initFlutter();
  Hive.registerAdapter(LogAdapter());
  box = await Hive.openBox('cd');

  // Create asset folders TODO separate
  final directory = await getApplicationDocumentsDirectory();
  if(!await Directory(directory.path+"/assets").exists()){
    await Directory(directory.path+"/assets").create(recursive: true);
  }
  assetPath = directory.path+"/assets";
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

