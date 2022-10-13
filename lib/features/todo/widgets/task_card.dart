import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todoem/features/todo/logic/task_logic.dart';
import '../models/task_model.dart';

enum TaskMenu { edit, delete }

Widget taskCard(Task task) => Card(
      child: ExpansionTile(
        leading:
            Checkbox(value: task.completed, onChanged: onChangedCompleteness),
        title: task.completed ? Text(task.task) : Text(task.task),
        subtitle: task.due != null ? Text('Due ${task.due!.dueIn}') : null,
        trailing: PopupMenuButton(
            itemBuilder: (context) => const <PopupMenuEntry<TaskMenu>>[
                  PopupMenuItem(value: TaskMenu.edit, child: Text('Edit')),
                  PopupMenuDivider(),
                  PopupMenuItem(value: TaskMenu.delete, child: Text('Delete')),
                ]),
        children: getChildren(task),
      ),
    );

List<Widget> getChildren(Task t) {
  List<Widget> l = [Text('Created: ${t.createdAt}')];
  if (t.due != null) {
    l.add(Text('Due: ${t.due}'));
  }
  if (t.repeat && t.repeatTime != null) {
    l.add(Text('On repeat every ${t.repeatTime!.time}'));
  }
  if (t.description != null) {
    l.addAll([const Divider(), Text(t.description!)]);
  }
  return l;
}

extension TimeLeft on DateTime {
  String get dueIn => Jiffy(this).fromNow();
}

