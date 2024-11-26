import 'package:flutter/material.dart';
import 'package:simple_todo_app/app_assets.dart';
import 'package:simple_todo_app/services/theme_data_service.dart';

class ToDoItem extends StatefulWidget {
  const ToDoItem({super.key});

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  // theme identifier
  // calling ThemeDataService to fetch user preference
  final ThemeDataService _themeDataService = ThemeDataService();

  // defining theme colors
  late Color cardColor;
  late Color textColor;
  late Color iconColor;

  // loading and updating theme colors
  Future<void> _loadThemePreference() async {
    bool _isDarkMode = await _themeDataService.getThemeMode();
    setState(() {
      cardColor =
          _isDarkMode ? AppAssets.darkCardColor : AppAssets.lightCardColor;
      textColor =
          _isDarkMode ? AppAssets.darkTextColor : AppAssets.lightTextColor;
      iconColor =
          _isDarkMode ? AppAssets.darkIconColor : AppAssets.lightIconColor;
    });
  }

  @override
  void initState() {
    _loadThemePreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loadThemePreference();
    return Container(
        child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tileColor: cardColor,
      leading: Icon(
        Icons.check_box,
        color: AppAssets.mainIconColor,
      ),
      title: Text(
        "Make Coffee",
        style: TextStyle(fontFamily: "Hoves", fontSize: 16, color: textColor, decoration: TextDecoration.lineThrough),
      ),
    ));
  }
}
