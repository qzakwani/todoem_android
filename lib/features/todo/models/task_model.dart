// ignore_for_file: unnecessary_this
import 'dart:convert';
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String task;
  final bool completed;
  final DateTime createdAt;
  final DateTime? due;
  final bool repeat;
  final String? repeatTime;
  final String? description;

  const Task(
      {required this.id,
      required this.task,
      required this.completed,
      required this.createdAt,
      this.due,
      required this.repeat,
      this.repeatTime,
      this.description});

  factory Task.fromCache(String cachedTask) {
    Map<String, dynamic> map = const JsonDecoder().convert(cachedTask);
    return Task(
        id: map['id'],
        task: map['task'],
        completed: map['completed'],
        createdAt: map['createdAt'],
        repeat: map['repeat'],
        due: map['due'],
        repeatTime: map['repeatTime'],
        description: map['description']);
  }

  Task.fromDB(Map<String, dynamic> dbTask)
      : id = dbTask['id'],
        task = dbTask['task'],
        completed = dbTask['completed'],
        createdAt = dbTask['createdAt'],
        due = dbTask['due'],
        repeat = dbTask['repeat'],
        repeatTime = dbTask['repeatTime'],
        description = dbTask['description'];

  @override
  List<Object?> get props => [id];
}
