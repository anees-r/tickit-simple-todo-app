import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_todo_app/app_assets.dart';
import 'package:simple_todo_app/services/theme_data_service.dart';
import 'package:simple_todo_app/widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // theme identifier
  bool _isDarkMode = false;
  // calling ThemeDataService to fetch user preference
  final ThemeDataService _themeDataService = ThemeDataService();

  // defining theme colors
  late Color backgroundColor;
  late Color cardColor;
  late Color textColor;
  late Color iconColor;


  Future<void> _loadThemePreference() async {
    _isDarkMode = await _themeDataService.getThemeMode();
    setState(() {});
  }

  // Toggle and save theme preference
  Future<void> _toggleTheme(bool value) async {
    setState(() {
      _isDarkMode = value;
    });
    await _themeDataService.saveThemeMode(_isDarkMode);
  }

  // upadting colors according to theme

   _updateThemeColors(){
    setState(() {
      backgroundColor = _isDarkMode ? AppAssets.darkBackgroundColor: AppAssets.lightBackgroundColor;
      cardColor = _isDarkMode ? AppAssets.darkCardColor: AppAssets.lightCardColor;
      textColor = _isDarkMode ? AppAssets.darkTextColor: AppAssets.lightTextColor;
      iconColor = _isDarkMode ? AppAssets.darkIconColor: AppAssets.lightIconColor;
    });
  }

  bool getThemeVariable(){
    return _isDarkMode;
  }

  @override
  void initState() {
    _loadThemePreference();
    _updateThemeColors();
    super.initState();
  }

  // main widget

  @override
  Widget build(BuildContext context) {
    _updateThemeColors();
    return Scaffold(

      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildSearchBar(),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "All ToDos",
                      style: TextStyle(
                        fontFamily: "Hoves",
                        fontSize: 25,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const ToDoItem(),
                ],             
                )
              ),
          ]
            )
          
        )
      );
  }

  Container _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
        cursorColor: AppAssets.mainIconColor,
        style: TextStyle(
          fontFamily: "Hoves",
          fontSize: 16,
          color: textColor,
        ),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            prefixIcon: SvgPicture.asset(
              AppAssets.searchIcon,
              width: 20,
              height: 20,
              color: textColor,
            ),
            prefixIconConstraints: const BoxConstraints(
              maxHeight: 20,
              maxWidth: 20,
            ),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(
              fontFamily: "Hoves",
              fontSize: 16,
              color: textColor.withOpacity(0.4),
            )),
      ),
    );
  }

  // extracted methods

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0), // Add some padding if needed
            child: SvgPicture.asset(
              AppAssets.logo, // Replace with your SVG path
              width: 40.0, // Set desired width
              height: 40.0,
              color: textColor, // Set desired height
            ),
          ),
          Text(
            "TickIt",
            style: TextStyle(
              fontFamily: "Hoves",
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: textColor,
            ),
          ),
          Transform.scale(
            scale: 1,
            child: Switch(
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _toggleTheme(value);
                });
              },
              activeColor: AppAssets.darkBackgroundColor,
              activeTrackColor: AppAssets.lightBackgroundColor,
              inactiveThumbColor: AppAssets.darkBackgroundColor,
            ),
          )
        ],
      ),
    );
  }
}
