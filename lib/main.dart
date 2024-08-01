import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'todo.dart';

void main() async {

  await Hive.initFlutter();

  var dataBox = await Hive.openBox("tododatabase");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoList(),
      );    
  }
}


