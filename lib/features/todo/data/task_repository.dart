import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
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

class TaskRepository {
  final SharedPreferences sp;

  TaskRepository(this.sp);

  Future<bool> createTask(Task task) async {
    final List<String> stringTaskList = sp.getStringList('tasks') ?? [];
    return await sp
        .setStringList('tasks', [...stringTaskList, _toString(task)]);
  }

  Future<bool> deleteTask(Task task) async {
    final List<String>? stringTaskList = sp.getStringList('tasks');
    if (stringTaskList == null) return false;
    stringTaskList.removeAt(
        stringTaskList.indexWhere((element) => element.contains(task.id)));
    return await sp.setStringList('tasks', stringTaskList);
  }

  Future<bool> updateTask(Task task) async {
    final List<String>? stringTaskList = sp.getStringList('tasks');
    if (stringTaskList == null) return false;
    final int i =
        stringTaskList.indexWhere((element) => element.contains(task.id));
    stringTaskList[i] = _toString(task);
    return await sp.setStringList('tasks', stringTaskList);
  }

  Future<List<Task>?> readTaskList() async {
    List<Task> tasks = [];
    try {
      var stringTaskList = sp.getStringList('tasks');
      if (stringTaskList == null) return null;
      for (var stringTask in stringTaskList) {
        tasks.add(Task.fromCache(stringTask));
      }
      return tasks;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteAllTasks() async {
    return await sp.setStringList('tasks', []);
  }
}
