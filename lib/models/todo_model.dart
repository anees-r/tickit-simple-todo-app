class ToDoModel {
  String? id;
  String? todoText;
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