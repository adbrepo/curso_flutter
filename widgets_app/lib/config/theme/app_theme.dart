import 'package:flutter/material.dart';

final List<Color> colorList = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
  Colors.pink,
  Colors.teal,
  Colors.cyan,
  Colors.indigo,
  Colors.lime,
  Colors.amber,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
  Colors.white,
  Colors.transparent,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.selectedColor = 0, this.isDarkMode = false})
      : assert(selectedColor >= 0, 'selectedColor must be greater than 0'),
        assert(selectedColor < colorList.length,
            'selectedColor must be less than colorList.length');

  ThemeData getTheme() {
    return ThemeData(
        colorSchemeSeed: colorList[selectedColor],
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
        ));
  }

  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) {
    return AppTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
