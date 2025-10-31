import 'package:flutter/material.dart';

final themeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.cyanAccent,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.cyanAccent;
        }
        return Colors.grey;
      },
    ),
    trackColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.cyanAccent.withValues(alpha: 0.5);
        }
        return Colors.grey.withValues(alpha: 0.5);
      },
    ),
  ),
);
