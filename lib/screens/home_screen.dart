import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_todo_app/app_assets.dart';
import 'package:simple_todo_app/models/todo_model.dart';
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

  // Loading todo list from model
  final todosList = ToDoModel.todoList();
  List<ToDoModel> foundTodo = [];

  final _todoController = TextEditingController();

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

  _updateThemeColors() {
    setState(() {
      backgroundColor = _isDarkMode
          ? AppAssets.darkBackgroundColor
          : AppAssets.lightBackgroundColor;
      cardColor =
          _isDarkMode ? AppAssets.darkCardColor : AppAssets.lightCardColor;
      textColor =
          _isDarkMode ? AppAssets.darkTextColor : AppAssets.lightTextColor;
    });
  }

  // deleting todos
  void _handleDelete(String? id){
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  // adding new todo to list
  void _addToDo(String todo){
    setState(() {
    todosList.add(ToDoModel(id: DateTime.now().microsecondsSinceEpoch.toString(), todoText: todo));
    });
    _todoController.clear();
  }

  // searching for todos
  void _runSearch(String keyword){
    List<ToDoModel> searchResults = [];
    if (keyword == ""){
      searchResults = todosList;
    }
    else{
      searchResults = todosList.where((item) => item.todoText!.toLowerCase().contains(keyword.toLowerCase())).toList();
    }
    setState(() {
      foundTodo = searchResults;
    });
  }

  // initialization function
  @override
  void initState() {
    _loadThemePreference();
    _updateThemeColors();
    foundTodo = todosList;
    super.initState();
  }

  // main widget

  @override
  Widget build(BuildContext context) {
    _updateThemeColors();
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: _buildAppBar(),
        body: Stack(children: [
          _buildSearchBar(),
          _buildToDoList(),
          _buildNewToDo()
        ]));
  }

  // extracted methods
  
  // method to build todo list
  Container _buildToDoList() {
    return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(bottom: 98, top: 70),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
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

                    for (ToDoModel todo in foundTodo.reversed)
                    //numbers.sort((a, b) => b.compareTo(a))
                      ToDoItem(
                        todo: todo,
                        onDelete: _handleDelete,
                      ),
                  ],
                ),
              )),
            ]));
  }

  // method to build add todo box and button
  Align _buildNewToDo() {
    return Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 0,
                    left: 20,
                    top: 20,
                  ),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    controller: _todoController,
                    cursorColor: AppAssets.mainIconColor,
                    style: TextStyle(
                      fontFamily: "Hoves",
                      fontSize: 16,
                      color: textColor,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add a new ToDo item",
                        hintStyle: TextStyle(
                          fontFamily: "Hoves",
                          fontSize: 16,
                          color: textColor.withOpacity(0.4),
                        )),
                  ),
                ),
              )),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                margin: const EdgeInsets.only(right: 0),
                color: backgroundColor,
                child: ElevatedButton(
                  onPressed: () {
                    _addToDo(_todoController.text); 
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: textColor,
                      minimumSize: const Size(40, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      padding: const EdgeInsets.all(0)),
                  child: SvgPicture.asset(
                    AppAssets.plusIcon,
                    color: backgroundColor,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        );
  }

  // method to build searchbar
  Container _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: TextField(
          onChanged: (value) => _runSearch(value),
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
      ),
    );
  }

  // method to build appbar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
        leading: Container(
        margin: const EdgeInsets.only(left: 15),
            child: SvgPicture.asset(
              AppAssets.logo,
              color: textColor, 
            ),
          ),
      title: Center(child: Text(
            "TickIt",
            style: TextStyle(
              fontFamily: "Hoves",
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: textColor,
            ),
          ),),
      
      actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: Transform.scale(
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
            ),
          )
      ],
    );
  }
}
