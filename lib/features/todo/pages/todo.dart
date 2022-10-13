import 'package:flutter/material.dart';
import 'package:todoem/features/todo/models/task_model.dart';
import 'package:todoem/features/todo/widgets/task_card.dart';

class Todo extends StatelessWidget {
  Todo({super.key});

  final tasks = [task1, task2, task1, task2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person),
        title: const Text('Tasks'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return TaskCard(task: tasks[index]);
          },
        ),
      )),
    );
  }
}

var task1 = Task(
    id: 'ubb',
    task: 'Call her',
    completed: false,
    createdAt: DateTime.now(),
    repeat: false);

var task2 = Task(
    id: 'seed',
    task: 'Kill myself',
    completed: false,
    createdAt: DateTime.now(),
    repeat: true,
    repeatTime: RepeatTime.daily,
    due: DateTime(2022, 10, 14),
    description: 'Do it when I can hopefully soon.');
