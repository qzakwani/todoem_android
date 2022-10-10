import 'package:flutter/material.dart';
import '../main.dart';


Route? appRouter(RouteSettings settings) {
  var route = settings.name?.split('/') ?? [''];
  switch (route[0]) {
    case '':
      return MaterialPageRoute(
          builder: (_) => const Root(), settings: settings);
    default:
    //!Must not change this default
      return null;
  }
}
