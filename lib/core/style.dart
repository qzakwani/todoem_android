import 'package:flutter/material.dart' hide Theme;
import '../core/cubit/theme_cubit.dart';

class Styles {
  static Color orangeWeb([double o = 1]) => Color.fromRGBO(252, 163, 17, o);
  static Color oxfordBlue([double o = 1]) => Color.fromRGBO(20, 33, 61, o);
  static Color get green => const Color.fromRGBO(75, 181, 67, 1);
  static Color get red => const Color.fromRGBO(202, 11, 0, 1);
  static Color get lightGray => const Color.fromRGBO(212, 212, 212, 1);

  final ThemeData _todoemLight = ThemeData.from(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: orangeWeb(),
      onPrimary: oxfordBlue(),
      secondary: oxfordBlue(0.7),
      onSecondary: orangeWeb(0.5),
      error: red,
      onError: Colors.white,
      background: lightGray,
      onBackground: oxfordBlue(),
      surface: Colors.grey.shade300,
      onSurface: oxfordBlue(),
    ),
  );

  ThemeData? getTheme(TodoemTheme theme) {
    switch (theme) {
      case TodoemTheme.light:
        return _todoemLight;
      default:
        return null;
    }
  }
}
