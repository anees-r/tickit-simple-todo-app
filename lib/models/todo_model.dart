import 'package:hive/hive.dart';

part "todo_model.g.dart";

@HiveType(typeId: 0) // Unique ID for this model
class ToDoModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? todoText;

  @HiveField(2)
  bool isDone;

  ToDoModel({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDoModel> todoList(){
    return[
    ];
  }
}