import 'package:flutter/material.dart';

import '../cubit/theme_cubit.dart';
import 'ob.g.dart';
import 'ow.g.dart';

class Styles {
  static Color orangeWeb([double o = 1]) => Color.fromRGBO(252, 163, 17, o);
  static Color oxfordBlue([double o = 1]) => Color.fromRGBO(20, 33, 61, o);
  static Color get green => const Color.fromRGBO(75, 181, 67, 1);
  static Color get red => const Color.fromRGBO(202, 11, 0, 1);
  static Color get lightGray => const Color.fromRGBO(212, 212, 212, 1);

  static ThemeData getTheme(TodoemTheme theme, bool isElegant) {
    switch (theme) {
      case TodoemTheme.lightOxfordBlue:
        return ThemeData(useMaterial3: isElegant, colorScheme: lightOxfordBlue);
      case TodoemTheme.darkOxfordBlue:
        return ThemeData(useMaterial3: isElegant, colorScheme: darkOxfordBlue);
      case TodoemTheme.lightOrangeWeb:
        return ThemeData(useMaterial3: isElegant, colorScheme: lightOrangeWeb);
      case TodoemTheme.darkOrangeWeb:
        return ThemeData(useMaterial3: isElegant, colorScheme: darkOrangeWeb);
      default:
        return ThemeData(useMaterial3: isElegant, colorScheme: lightOxfordBlue);
    }
  }
}
