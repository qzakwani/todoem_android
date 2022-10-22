// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:todoem/core/extensions.dart';
import 'package:todoem/features/todo/models/task_model.dart';
import 'package:todoem/core/layout.dart';
import 'package:workmanager/workmanager.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key, required this.task});

  final Task task;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();
  late Task task;
  TextDirection? txtDir;
  TextDirection? txtDirDes;
  final taskController = TextEditingController();
  final descController = TextEditingController();
  late String rt;
  bool? isRepeat;

  @override
  void initState() {
    task = widget.task;

    taskController.text = task.task;
    if (task.description != null) {
      descController.text = task.description!;
    }
    rt = task.repeatTime ?? 'daily';
    isRepeat = task.repeat;
    super.initState();
  }

  TextDirection _changeDir(String value) =>
      RegExp(r'[\u0600-\u06FF]', unicode: true).hasMatch(value)
          ? TextDirection.rtl
          : TextDirection.ltr;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      task.task = taskController.text;
      task.description =
          descController.text.isNotEmpty ? descController.text : null;
      task.repeat == true ? task.repeatTime = rt : task.repeatTime = null;
      task.save();
      if (isRepeat != task.repeat) {
        if (task.repeat!) {
          Duration? d;
          switch (task.repeatTime) {
            case 'daily':
              d = const Duration(days: 1);
              break;
            case 'weekly':
              d = const Duration(days: 7);
              break;
            case 'monthly':
              d = const Duration(days: 30);
              break;
            default:
              return;
          }
          Workmanager().registerPeriodicTask(
              task.key.toString(), task.key.toString(),
              frequency: d,
              initialDelay: d,
              existingWorkPolicy: ExistingWorkPolicy.keep,
              inputData: {
                'task': task.task,
                'period': task.repeatTime,
                'desc': task.description
              });
        } else {
          try {
            Workmanager().cancelByUniqueName(task.key.toString());
          } catch (e) {}
        }
      }
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    taskController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Task'),
          actions: [
            TextButton(
                onPressed: submitForm,
                child: Text(
                  'Done',
                  style: scheme.brightness == Brightness.light &&
                          Theme.of(context).useMaterial3 == false
                      ? TextStyle(color: scheme.onPrimary)
                      : null,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: taskController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      if (_changeDir(value) != txtDir) {
                        setState(() {
                          txtDir = _changeDir(value);
                        });
                      }
                    },
                    textDirection: txtDir,
                    decoration: const InputDecoration(hintText: 'Edit Task'),
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your task!';
                      }
                      return null;
                    },
                  ),
                  Layout.gap(18.0),
                  Row(
                    children: [
                      const Text('Due: '),
                      Visibility(
                          visible: task.due != null,
                          child: Row(
                            children: [
                              Text(task.due != null ? task.due!.formatIt : ''),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error),
                                  onPressed: () {
                                    setState(() {
                                      task.due = null;
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color:
                                        Theme.of(context).colorScheme.onError,
                                  ))
                            ],
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder()),
                          onPressed: (() async {
                            var date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2999));
                            if (date != null) {
                              var time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (time != null) {
                                setState(() {
                                  task.due = DateTime(date.year, date.month,
                                      date.day, time.hour, time.minute);
                                });
                              }
                            }
                          }),
                          child: const Icon(Icons.calendar_month)),
                    ],
                  ),
                  Layout.gap(10.0),
                  Row(
                    children: [
                      const Text('Repeat: '),
                      Checkbox(
                          value: task.repeat,
                          onChanged: (v) {
                            if (v != null) {
                              setState(() {
                                task.repeat = v;
                              });
                            }
                          }),
                      Visibility(
                          visible: task.repeat ?? false,
                          child: Expanded(
                            child: DropdownButtonFormField(
                              value: rt,
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'daily',
                                  child: Text('Daily'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'weekly',
                                  child: Text('Weekly'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Monthly',
                                  child: Text('monthly'),
                                ),
                              ],
                              onChanged: ((value) {
                                if (value != null) {
                                  setState(() {
                                    rt = value;
                                  });
                                }
                              }),
                            ),
                          )),
                    ],
                  ),
                  Layout.gap(10.0),
                  TextFormField(
                    controller: descController,
                    textDirection: txtDirDes,
                    decoration: const InputDecoration(
                        hintText: 'Description (Optional)'),
                    maxLines: null,
                    onChanged: (value) {
                      if (_changeDir(value) != txtDir) {
                        setState(() {
                          txtDirDes = _changeDir(value);
                        });
                      }
                    },
                  ),
                  Layout.gap(18.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.error),
                                foregroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.onError)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        Layout.gap(20.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: submitForm,
                            child: const Text('Save Task'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
