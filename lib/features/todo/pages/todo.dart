// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoem/features/todo/widgets/settings.dart';
import '../../../core/layout.dart';
import '../widgets/task_card.dart';
import '../models/task_model.dart';

Future<void> _updateRepeatedTasks() async {
  var now = DateTime.now();
  Duration? period;
  var tasks = Hive.box<Task>('tasks').values.where((element) =>
      element.completed && element.repeat != null && element.repeat!);
  for (var task in tasks) {
    switch (task.repeatTime) {
      case 'daily':
        period = const Duration(days: 1);
        break;
      case 'weekly':
        period = const Duration(days: 7);
        break;
      case 'monthly':
        period = const Duration(days: 30);
        break;
      default:
        period = null;
    }
    if (period == null) {
      continue;
    }
    var newCreated = task.createdAt.add(period);
    if (newCreated.isBefore(now)) {
      var due = newCreated.add(period);
      var control = 0;
      while (due.isBefore(now)) {
        due = due.add(period);
        newCreated = newCreated.add(period);
        control++;
        if (control > 30) {
          break;
        }
        now = DateTime.now();
      }
      task.createdAt = newCreated;
      task.due = due;
      task.changeStatus();
    }
  }
}

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

class __TaskListState extends State<_TaskList> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _updateRepeatedTasks();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _updateRepeatedTasks();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Task>('tasks').listenable(),
        builder: (context, box, child) {
          final tasks = box.values.where((element) => !element.completed);
          return tasks.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: RefreshIndicator(
                    onRefresh: _updateRepeatedTasks,
                    child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) => TaskCard(
                            key: ValueKey(tasks.elementAt(index).key),
                            task: tasks.elementAt(index))),
                  ),
                )
              : Center(
                  child: RefreshIndicator(
                    onRefresh: _updateRepeatedTasks,
                    child: ListView(
                      children: [
                        const Center(child: Text('No Tasks Yet')),
                        Layout.gap(10.0),
                        const Icon(Icons.note_alt_rounded)
                      ],
                    ),
                  ),
                );
        });
  }
}
