// ignore_for_file: depend_on_referenced_packages, unused_element

import 'package:flutter/material.dart';
import 'package:todoem/core/style/style.dart';
import '../models/task_model.dart';
import '../../../core/extensions.dart' show TimeLeft;
import 'package:flutter_slidable/flutter_slidable.dart';

class CompletedTaskCard extends StatefulWidget {
  final Task task;
  const CompletedTaskCard({super.key, required this.task});

  @override
  State<CompletedTaskCard> createState() => _CompletedTaskCardState();
}

class _CompletedTaskCardState extends State<CompletedTaskCard> {
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
                label: 'Undone',
              )
            ]),
        endActionPane: ActionPane(
            motion: const DrawerMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              t.delete();
            }),
            children: [
              SlidableAction(
                onPressed: (context) {
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
          title: Text(
            t.task,
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
            ),
          ),
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
            case TaskMenu.delete:
              widget.task.delete();
              setState(() {});
              break;
            default:
          }
        },
        itemBuilder: (context) => const <PopupMenuEntry<TaskMenu>>[
              PopupMenuItem(value: TaskMenu.delete, child: Text('Delete')),
            ]);
  }
}
