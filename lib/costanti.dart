import 'package:ct_journal/models/log.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// const Color CTLogBarBG = Color.fromARGB(255, 47, 47, 47);
const Color CTLogBarBG = Colors.black;
const double CTLogBarIconSize = 20;

const double CTLogBarSearchPadding = 15;

late Box<Log> box;
