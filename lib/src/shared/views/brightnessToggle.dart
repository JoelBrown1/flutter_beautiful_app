import 'package:flutter/material.dart';

import '../providers/theme.dart';

class BrightnessToggle extends StatelessWidget {
  const BrightnessToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      onPressed: () {
        final themeProvider = ThemeProvider.of(context);
        final settings = themeProvider.settings.value;
        final newSettings = ThemeSettings(
          sourceColor: settings.sourceColor,
          themeMode: isDark ? ThemeMode.light : ThemeMode.dark,
        );
        ThemeSettingChange(settings: newSettings).dispatch(context);
      },
      icon: Theme.of(context).brightness == Brightness.light
          ? const Icon(Icons.brightness_3)
          : const Icon(Icons.brightness_7),
    );
  }
}
