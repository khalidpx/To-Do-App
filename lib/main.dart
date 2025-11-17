// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_doapp/pages/home_page.dart';
import 'package:to_doapp/pages/recentdel.dart';

void main() async{    
  //init hive
  await Hive.initFlutter();

  // open box
  var box = await Hive.openBox('myBox');
  var box1 = await Hive.openBox('recentDeleted');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),


    );
  }
}