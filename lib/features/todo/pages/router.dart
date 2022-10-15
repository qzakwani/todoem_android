import './add_task.dart';
import 'package:flutter/material.dart';
import './todo.dart';

Route? todoRouter(RouteSettings settings, List<String> route) {
  var r = route.length > 1 ? route[1] : '';
  switch (r) {
    case '':
      return MaterialPageRoute(
          builder: (_) =>  Todo(), settings: settings);
    case 'add_task':
      return MaterialPageRoute(
          builder: (_) => const AddTask(), settings: settings);
    default:
      return null;
  }
}

