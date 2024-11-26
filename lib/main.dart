import 'package:flutter/material.dart';
import 'package:simple_todo_app/screens/home_screen.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple ToDo App',
      home: HomeScreen(), // running the homescreen class on startup
    );
  }
}