import 'package:hive_flutter/adapters.dart';
import 'package:simple_todo_app/models/todo_model.dart';

class ToDoService {
  static const String todoBoxName = 'todos';

  static Future<void> openBox() async {
    await Hive.openBox<ToDoModel>(todoBoxName);
  }

  static Box<ToDoModel> getBox() {
    if (!Hive.isBoxOpen('todos')) {
      throw HiveError('Box not found. Did you forget to open it?');
    }
    return Hive.box<ToDoModel>('todos');
  }
}
