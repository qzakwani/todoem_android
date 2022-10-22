// ignore_for_file: depend_on_referenced_packages, unused_element

import 'package:flutter/material.dart';
import 'package:todoem/core/style/style.dart';
import 'package:todoem/features/todo/pages/edit_task.dart';
import 'package:workmanager/workmanager.dart';

import '../models/task_model.dart';
import '../../../core/extensions.dart' show TimeLeft;
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  List<Widget> _getChildren() {
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
    if (t.repeat != null && t.repeat == true && t.repeatTime != null) {
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
  late final Task t;
  @override
  void initState() {
    t = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dueTime = t.due?.dueIn;
    return Card(
      child: Slidable(
        key: ValueKey(t.key),
        startActionPane: ActionPane(
            motion: const DrawerMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              t.changeStatus();
            }),
            children: [
              SlidableAction(
                onPressed: (context) {
                  t.changeStatus();
                },
                backgroundColor: Styles.green,
                foregroundColor: Colors.white,
                label: 'Done',
              )
            ]),
        endActionPane: ActionPane(
            motion: const DrawerMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              if (t.repeat == true) {
                try {
                  Workmanager().cancelByUniqueName(t.key.toString());
                } catch (e) {}
              }
              t.delete();
            }),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditTask(task: t)));
                },
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: (context) {
                  if (t.repeat == true) {
                    try {
                      Workmanager().cancelByUniqueName(t.key.toString());
                    } catch (e) {}
                  }
                  t.delete();
                },
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
                label: 'Delete',
              ),
            ]),
        child: ExpansionTile(
          onExpansionChanged: (_) {
            if (t.due != null) {
              setState(() {
                dueTime = t.due!.dueIn;
              });
            }
          },
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.all(10),
          leading: Checkbox(
              value: t.completed,
              onChanged: (v) {
                if (v != null && v != t.completed) {
                  t.changeStatus();
                  setState(() {});
                }
              }),
          title: Text(t.task),
          subtitle: t.due != null
              ? Text(
                  'Due $dueTime',
                  style: dueTime!.contains('ago')
                      ? TextStyle(color: Theme.of(context).colorScheme.error)
                      : null,
                )
              : null,
          trailing: _TaskOptions(task: t),
          children: _getChildren(),
        ),
      ),
    );
  }
}

enum TaskMenu { edit, delete }

class _TaskOptions extends StatefulWidget {
  final Task task;
  const _TaskOptions({super.key, required this.task});

  @override
  State<_TaskOptions> createState() => _TaskOptionsState();
}

class _TaskOptionsState extends State<_TaskOptions> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          switch (value) {
            case TaskMenu.edit:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditTask(task: widget.task)));
              setState(() {});
              break;
            case TaskMenu.delete:
              if (widget.task.repeat == true) {
                try {
                  Workmanager().cancelByUniqueName(widget.task.key.toString());
                } catch (e) {}
              }
              widget.task.delete();
              setState(() {});
              break;
            default:
          }
        },
        itemBuilder: (context) => const <PopupMenuEntry<TaskMenu>>[
              PopupMenuItem(value: TaskMenu.edit, child: Text('Edit')),
              PopupMenuDivider(),
              PopupMenuItem(value: TaskMenu.delete, child: Text('Delete')),
            ]);
  }
}
