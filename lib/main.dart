import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simple_todo_app/models/todo_model.dart';
import 'package:simple_todo_app/screens/loading_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(ToDoModelAdapter()); // Register the generated adapter
  await Hive.openBox<ToDoModel>('todos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple ToDo App',
      home: LoadingScreen(), // running the homescreen class on startup
    );
  }
}