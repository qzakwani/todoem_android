import '../features/settings/pages/router.dart';
import '../features/todo/pages/router.dart';
import '../features/auth/pages/router.dart';
import 'package:flutter/material.dart';
import '../main.dart';


Route? appRouter(RouteSettings settings) {
  var route = settings.name?.split('/') ?? [''];
  switch (route[0]) {
    case '':
      return MaterialPageRoute(
          builder: (_) => const Root(), settings: settings);
    case 'auth':
      return authRouter(settings, route);
    case 'todo':
      return todoRouter(settings, route);
    case 'settings':
      return settingsRouter(settings, route);
    default:
    //!Must not change this default
      return null;
  }
}



