import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_todo_app/app_assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // theme identifier
  bool _isDarkMode = false;

  // upadting colors according to theme
  Color backgroundColor = AppAssets.lightBackgroundColor;
  Color cardColor = AppAssets.lightCardColor;
  Color textColor = AppAssets.lightTextColor;
  Color iconColor = AppAssets.lightIconColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // main widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildSearchBar(),
          ],
        ),
      ),
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
          fontSize: 20,
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
              fontSize: 20,
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
                  _isDarkMode = value;
                });
              },
              activeColor: AppAssets.darkBackgroundColor,
              activeTrackColor: AppAssets.mainIconColor,
              inactiveThumbColor: AppAssets.lightTextColor,
            ),
          )
        ],
      ),
    );
  }
}
