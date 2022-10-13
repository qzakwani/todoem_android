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
  List<Widget> _getChildren(Task t, ColorScheme scheme) {
    TextStyle right =
        TextStyle(color: scheme.onSecondary, fontWeight: FontWeight.w500);
    TextStyle left = TextStyle(color: scheme.onSecondary);

    List<Widget> l = [
      Row(
        children: [
          Text(
            'Created:   ',
            style: left,
          ),
          Text(
            t.createdAt.formatIt,
            style: right,
          ),
        ],
      )
    ];
    if (t.due != null) {
      l.add(Row(
        children: [
          Text(
            'Due:          ',
            style: left,
          ),
          Text(
            t.due!.formatIt,
            style: right,
          ),
        ],
      ));
    }
    if (t.repeat && t.repeatTime != null) {
      l.add(Row(
        children: [
          Text(
            'Repeat:     ',
            style: left,
          ),
          Text(
            t.repeatTime!.time,
            style: right,
          ),
        ],
      ));
    }
    if (t.description != null) {
      l.addAll([
        const Divider(),
        Text(
          t.description!,
          style: right,
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
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: ExpansionTile(
        onExpansionChanged: (_) {
          setState(() {
            dueTime = task.due?.dueIn;
          });
        },
        backgroundColor: scheme.secondary,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.all(10),
        leading:
            Checkbox(value: task.completed, onChanged: onChangedCompleteness),
        title: task.completed ? Text(task.task) : Text(task.task),
        subtitle: task.due != null
            ? Text(
                'Due $dueTime',
                style: dueTime!.contains('ago')
                    ? TextStyle(color: scheme.error)
                    : null,
              )
            : null,
        trailing: PopupMenuButton(
            itemBuilder: (context) => const <PopupMenuEntry<TaskMenu>>[
                  PopupMenuItem(value: TaskMenu.edit, child: Text('Edit')),
                  PopupMenuDivider(),
                  PopupMenuItem(value: TaskMenu.delete, child: Text('Delete')),
                ]),
        children: _getChildren(task, scheme),
      ),
    );
  }
}

extension TimeLeft on DateTime {
  String get dueIn => Jiffy(this).fromNow();
  String get formatIt => DateFormat('LLL d, y @').add_jm().format(this);
}
