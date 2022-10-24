import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/layout.dart';
import '../models/task_model.dart';
import '../widgets/completed_task_card.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({super.key});

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Completed Tasks'),
        ),
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
                  Navigator.of(context).pop(context);
                }),
                enableFeedback: true,
                child: const Icon(Icons.list),
              ),
              FloatingActionButton(
                heroTag: 0,
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
                onPressed: (() async {
                  var res = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete ALL Completed Tasks?'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context, 0),
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () => Navigator.pop(context, 1),
                            child: Text('Delete',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                )))
                      ],
                    ),
                  );

                  if (res == 1) {
                    var t = Hive.box<Task>('tasks')
                        .values
                        .where((element) => element.completed);
                    for (var element in t) {
                      element.delete();
                    }
                  }
                }),
                enableFeedback: true,
                child: const Icon(Icons.delete_forever),
              ),
            ],
          ),
        ),
        body: ValueListenableBuilder(
            valueListenable: Hive.box<Task>('tasks').listenable(),
            builder: (context, box, child) {
              final tasks = box.values.where((element) => element.completed);
              return tasks.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 80.0),
                      child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) => CompletedTaskCard(
                              key: ValueKey(tasks.elementAt(index).key),
                              task: tasks.elementAt(index))),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No Completed Tasks Yet'),
                          Layout.gap(10.0),
                          const Icon(Icons.note_alt_rounded)
                        ],
                      ),
                    );
            }));
  }
}
