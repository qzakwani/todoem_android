import 'package:flutter/material.dart';
import './settings.dart';

Route? settingsRouter(RouteSettings settings, List<String> route) {
  var r = route.length > 1 ? route[1] : '';
  switch (r) {
    case '':
      return MaterialPageRoute(
          builder: (_) => const Settings(), settings: settings);
    default:
      return null;
  }
}
