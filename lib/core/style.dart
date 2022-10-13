import 'package:flutter/material.dart';

class Styles {
  static ThemeData lightMode = ThemeData.from(
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary:  Color(0xFF14213d),
      secondary:  Color(0xFF14213d),
      onSecondary:  Color(0xFFfca311),
      error:  Color(0xFFca0b00),
      onError: Colors.white,
      background: Colors.white,
      onBackground:  Color(0xFF14213d),
      surface:  Color(0x1afca311),
      onSurface:  Color(0xFF14213d),
      outline: Color(0xFFfca311)
      ),
      // textTheme: const TextTheme()
      useMaterial3: true
  );
}
