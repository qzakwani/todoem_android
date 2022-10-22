// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoem/features/todo/widgets/settings.dart';
import '../../../core/layout.dart';
import '../widgets/task_card.dart';
import '../models/task_model.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const SettingsDrawer(),
        appBar: AppBar(
          title: const Text('Tasks'),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(Icons.settings));
            })
          ],
        ),
        body: const Padding(padding: EdgeInsets.all(8.0), child: _TaskList()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: 1,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                foregroundColor: Theme.of(context).colorScheme.onTertiary,
                onPressed: (() {
                  Navigator.of(context).pushNamed('todo/completed_tasks');
                }),
                enableFeedback: true,
                child: const Icon(Icons.done),
              ),
              FloatingActionButton(
                heroTag: 0,
                onPressed: (() {
                  Navigator.of(context).pushNamed('todo/add_task');
                }),
                enableFeedback: true,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskList extends StatefulWidget {
  const _TaskList({super.key});

  @override
  State<_TaskList> createState() => __TaskListState();
}

class __TaskListState extends State<_TaskList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Task>('tasks').listenable(),
        builder: (context, box, child) {
          final tasks = box.values.where((element) => !element.completed);
          return tasks.isNotEmpty
              ? ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => TaskCard(
                      key: ValueKey(tasks.elementAt(index).key),
                      task: tasks.elementAt(index)))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No Tasks Yet'),
                      Layout.gap(10.0),
                      const Icon(Icons.note_alt_rounded)
                    ],
                  ),
                );
        });
  }
}
