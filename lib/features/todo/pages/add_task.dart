// ignore_for_file: unused_element, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:todoem/core/layout.dart';
import 'package:intl/intl.dart' show DateFormat;

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Task'),
          actions: [TextButton(onPressed: () {}, child: const Text('Done'))],
        ),
        body: const _TaskForm(),
      ),
    );
  }
}

class _TaskForm extends StatefulWidget {
  const _TaskForm({super.key});

  @override
  State<_TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<_TaskForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? due;
  TextDirection? txtDir;
  TextDirection? txtDirDes;
  bool isRepeat = false;
  String repeatTime = 'daily';

  TextDirection _changeDir(String value) =>
      RegExp(r'[\u0600-\u06FF]', unicode: true).hasMatch(value)
          ? TextDirection.rtl
          : TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                onChanged: (value) {
                  if (_changeDir(value) != txtDir) {
                    setState(() {
                      txtDir = _changeDir(value);
                    });
                  }
                },
                textDirection: txtDir,
                decoration: const InputDecoration(hintText: 'New Task'),
                autofocus: true,
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
                      visible: due != null,
                      child: Row(
                        children: [
                          Text(due != null ? due!.formatIt : ''),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error),
                              onPressed: () {
                                setState(() {
                                  due = null;
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: Theme.of(context).colorScheme.onError,
                              ))
                        ],
                      )),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(shape: const CircleBorder()),
                      onPressed: (() async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2999));
                        if (date != null) {
                          var time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (time != null) {
                            setState(() {
                              due = DateTime(date.year, date.month, date.day,
                                  time.hour, time.minute);
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
                      value: isRepeat,
                      onChanged: (v) {
                        if (v != null) {
                          setState(() {
                            isRepeat = v;
                          });
                        }
                      }),
                  Visibility(
                      visible: isRepeat,
                      child: Expanded(
                        child: DropdownButtonFormField(
                          value: repeatTime,
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
                            DropdownMenuItem<String>(
                              value: 'annually',
                              child: Text('Annually'),
                            )
                          ],
                          onChanged: ((value) {
                            if (value != null) {
                              setState(() {
                                repeatTime = value;
                              });
                            }
                          }),
                        ),
                      )),
                ],
              ),
              Layout.gap(10.0),
              TextFormField(
                textDirection: txtDirDes,
                decoration:
                    const InputDecoration(hintText: 'Description (Optional)'),
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Add Task'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

extension TimeLeft on DateTime {
  String get formatIt => DateFormat('LLL d, y @').add_jm().format(this);
}
