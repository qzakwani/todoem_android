import 'package:flutter/material.dart';

import 'add_task.dart';
import 'completed_tasks.dart';
import 'todo.dart';

Route? todoRouter(RouteSettings settings, List<String> route) {
  var r = route.length > 1 ? route[1] : '';
  switch (r) {
    case '':
      return MaterialPageRoute(
          builder: (_) => const Todo(), settings: settings);
    case 'add_task':
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddTask(),
        transitionsBuilder: _transLeft,
      );
    case 'completed_tasks':
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CompletedTasks(),
        transitionsBuilder: _transUp,
      );
    default:
      return null;
  }
}

SlideTransition _transUp(context, animation, secondaryAnimation, child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  const curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}

SlideTransition _transLeft(context, animation, secondaryAnimation, child) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}
