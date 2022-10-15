import 'dart:convert';

import 'package:todoem/features/todo/models/task_model.dart';

String _toString(Task task) {
  return const JsonEncoder().convert({
    'id': task.id,
    'task': task.task,
    'completed': task.completed,
    'createdAt': task.createdAt,
    'repeat': task.repeat,
    'repeatTime': task.repeatTime,
    'due': task.due,
    'description': task.description
  });
}
