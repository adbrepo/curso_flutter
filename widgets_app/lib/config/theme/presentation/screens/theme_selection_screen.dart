import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/presentation/providers/theme_provider.dart';

class ThemeSelectionScreen extends ConsumerWidget {
  static const name = 'theme_selection_screen';
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    bool isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Selection'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleDarkMode();
            },
            icon: isDarkMode
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
          ),
        ],
      ),
      body: const _ThemeSelectionView(),
    );
  }
}

class _ThemeSelectionView extends ConsumerWidget {
  const _ThemeSelectionView();

  @override
  Widget build(BuildContext context, ref) {
    final List<Color> colorList = ref.watch(colorListProvider);
    final int selectedColor = ref.watch(themeNotifierProvider).selectedColor;

    return ListView.builder(
        itemCount: colorList.length,
        itemBuilder: (context, index) {
          return RadioListTile(
            title: Text(
              'Color $index',
              style: TextStyle(color: colorList[index]),
            ),
            subtitle: Text('#${colorList[index].value.toRadixString(16)}'),
            activeColor: colorList[index],
            value: index,
            groupValue: selectedColor,
            onChanged: (value) {
              ref
                  .read(themeNotifierProvider.notifier)
                  .changeColorTheme(value ?? 0);
            },
          );
        });
  }
}
