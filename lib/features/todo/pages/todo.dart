import 'package:flutter/material.dart';
import 'package:todoem/features/todo/models/task_model.dart';
import 'package:todoem/features/todo/widgets/task_card.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children:  [
          taskCard(task1),
          taskCard(task2),
          taskCard(task1),
          taskCard(task2),
        ],
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
    repeatTime: RepeatTime.day,
    due: DateTime(2022,10,14),
    description: 'Do it when I can hopefully soon.'
    );
