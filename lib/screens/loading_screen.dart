import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simple_todo_app/app_assets.dart';
import 'package:simple_todo_app/models/todo_model.dart';
import 'package:simple_todo_app/screens/home_screen.dart';
import 'package:simple_todo_app/services/theme_data_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // getching user theme preferences
  final ThemeDataService _themeDataService = ThemeDataService();

  // theme identifier
  bool _isDarkMode = false;

  Future<void> _loadThemePreference() async {
    _isDarkMode = await _themeDataService.getThemeMode();
    setState(() {});
  }

  @override
  void initState() {
    _loadThemePreference();
    Future.delayed(const Duration(seconds: 1), () async {
      await Hive.openBox<ToDoModel>('todos');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // defining theme colors
    Color backgroundColor =
      _isDarkMode ? AppAssets.darkBackgroundColor : AppAssets.darkBackgroundColor;
    Color textColor =
      _isDarkMode ? AppAssets.darkTextColor : AppAssets.lightTextColor;
      _loadThemePreference();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          child: SvgPicture.asset(AppAssets.mainLogo,
          color: textColor,
          height: 200,
          width: 200,
          ),
        ),
      )
      );
  }
}