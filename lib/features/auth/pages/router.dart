import 'package:flutter/material.dart';
import './auth.dart';

Route? authRouter(RouteSettings settings, List<String> route) {
  var r = route.length > 1 ? route[1] : '';
  switch (r) {
    case '':
      return MaterialPageRoute(
          builder: (_) => const Auth(), settings: settings);
    default:
      return null;
  }
}
