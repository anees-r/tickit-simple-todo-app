import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_todo_app/app_assets.dart';
import 'package:simple_todo_app/models/todo_model.dart';
import 'package:simple_todo_app/services/theme_data_service.dart';

class ToDoItem extends StatefulWidget {
  final ToDoModel todo;
  final void Function(String?) onDelete;
  const ToDoItem({super.key, required this.todo, required this.onDelete});

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  
  // calling ThemeDataService to fetch user preference
  final ThemeDataService _themeDataService = ThemeDataService();
  // theme identifier
  bool _isDarkMode = false;
  

  // changing todo based on tap
  void _handleToDoChange(ToDoModel todo) {
    // DateTime now = DateTime.now();
    // DateTime yesterday = now.subtract(const Duration(days: 1));
    setState(() {
      // if(todo.isDone == false){
      //   todo.id = yesterday.microsecondsSinceEpoch.toString();
      // }
      todo.isDone = !todo.isDone;
    });
  }

  // loading and updating theme colors
  Future<void> _loadThemePreference() async {
    _isDarkMode = await _themeDataService.getThemeMode();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // defining theme colors
    Color cardColor =
      _isDarkMode ? AppAssets.darkCardColor : AppAssets.lightCardColor;
    Color textColor =
      _isDarkMode ? AppAssets.darkTextColor : AppAssets.lightTextColor;
      _loadThemePreference();
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: ListTile(
            onTap: () {
              _handleToDoChange(widget.todo);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            tileColor: cardColor,
            leading: Icon(
              widget.todo.isDone
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: AppAssets.mainIconColor,
            ),
            title: Text(
              widget.todo.todoText!,
              style: TextStyle(
                fontFamily: "Hoves",
                fontSize: 16,
                color: textColor,
                decoration:
                    widget.todo.isDone ? TextDecoration.lineThrough : null,
                decorationColor: textColor,
              ),
            ),
            trailing: Container(
                child: IconButton(
              icon: SvgPicture.asset(
                AppAssets.deleteIcon,
                width: 22,
                height: 22,
                color: textColor.withOpacity(0.5),
              ),
              onPressed: () {
                widget.onDelete(widget.todo.id);
              },
            ))));
  }
}
