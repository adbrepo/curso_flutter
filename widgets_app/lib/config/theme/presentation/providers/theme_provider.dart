import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

final Provider<List<Color>> colorListProvider = Provider((ref) => colorList);
//final StateProvider<int> selectedColorProvider = StateProvider((ref) => 0);
//final StateProvider<bool> isDarkModeProvider = StateProvider<bool>((ref) => false);

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorTheme(int color) {
    state = state.copyWith(selectedColor: color);
  }
}
