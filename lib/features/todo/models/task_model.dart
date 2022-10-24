// ignore_for_file: unnecessary_this, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

abstract class BaseTask extends Equatable {
  @override
  List<Object?> get props => [];
}

@HiveType(typeId: 0)
class Task extends HiveObject implements BaseTask {
  @HiveField(0)
  String task;

  @HiveField(1)
  bool completed;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  DateTime? due;

  @HiveField(4)
  bool? repeat;

  @HiveField(5)
  String? repeatTime;

  @HiveField(6)
  String? description;

  Task({
    required this.task,
    required this.completed,
    required this.createdAt,
    this.due,
    this.repeat,
    this.repeatTime,
    this.description,
  });

  factory Task.newTask(
      {required String task,
      DateTime? due,
      bool? repeat,
      String? repeatTime,
      String? desc}) {
    var createdAt = DateTime.now();
    var completed = false;
    var rt = repeat != null ? repeatTime : null;
    return Task(
        task: task,
        completed: completed,
        createdAt: createdAt,
        due: due,
        repeat: repeat,
        repeatTime: rt,
        description: desc);
  }

  Future<void> changeStatus() {
    this.completed = !this.completed;
    return this.save();
  }

  @override
  List<Object?> get props => [key];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    return '$key : $task';
  }
}
