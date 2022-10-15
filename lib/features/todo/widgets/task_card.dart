// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todoem/features/todo/logic/task_logic.dart';
import '../models/task_model.dart';
import 'package:intl/intl.dart' show DateFormat;

enum TaskMenu { edit, delete }

class TaskCard extends StatefulWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  List<Widget> _getChildren(Task t) {
    List<Widget> l = [
      Row(
        children: [
          const Text(
            'Created:   ',
          ),
          Text(
            t.createdAt.formatIt,
          ),
        ],
      )
    ];
    if (t.due != null) {
      l.add(Row(
        children: [
          const Text(
            'Due:          ',
          ),
          Text(
            t.due!.formatIt,
          ),
        ],
      ));
    }
    if (t.repeat && t.repeatTime != null) {
      l.add(Row(
        children: [
          const Text(
            'Repeat:     ',
          ),
          Text(
            t.repeatTime!,
          ),
        ],
      ));
    }
    if (t.description != null) {
      l.addAll([
        const Divider(),
        Text(
          t.description!,
        )
      ]);
    }
    return l;
  }

  String? dueTime;
  @override
  Widget build(BuildContext context) {
    final Task task = widget.task;
    dueTime = task.due?.dueIn;
    return Card(
      child: ExpansionTile(
        onExpansionChanged: (_) {
          setState(() {
            dueTime = task.due?.dueIn;
          });
        },
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.all(10),
        leading:
            Checkbox(value: task.completed, onChanged: onChangedCompleteness),
        title: task.completed ? Text(task.task) : Text(task.task),
        subtitle: task.due != null
            ? Text(
                'Due $dueTime',
                style: dueTime!.contains('ago')
                    ? TextStyle(color: Theme.of(context).colorScheme.error)
                    : null,
              )
            : null,
        trailing: PopupMenuButton(
            itemBuilder: (context) => const <PopupMenuEntry<TaskMenu>>[
                  PopupMenuItem(value: TaskMenu.edit, child: Text('Edit')),
                  PopupMenuDivider(),
                  PopupMenuItem(value: TaskMenu.delete, child: Text('Delete')),
                ]),
        children: _getChildren(task),
      ),
    );
  }
}

extension TimeLeft on DateTime {
  String get dueIn => Jiffy(this).fromNow();
  String get formatIt => DateFormat('LLL d, y @').add_jm().format(this);
}
