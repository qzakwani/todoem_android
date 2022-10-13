// ignore_for_file: unnecessary_this

import 'package:equatable/equatable.dart';

enum RepeatTime { daily, weekly, monthly }

class Task extends Equatable {
  final String id;
  final String task;
  final bool completed;
  final DateTime createdAt;
  final DateTime? due;
  final bool repeat;
  final RepeatTime? repeatTime;
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

  @override
  List<Object?> get props => [id];
}

extension GetValue on RepeatTime {
  String get time => this.toString().split('.').last;
}
