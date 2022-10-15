import 'package:flutter/material.dart';
import '../../../core/cubit/theme_cubit.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Todo extends StatelessWidget {
  Todo({super.key});

  final tasks = [task1, task2, task1, task2];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const _Drawer(),
        appBar: AppBar(
          leading: const Icon(Icons.person),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskCard(task: tasks[index]);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.of(context).pushNamed('todo/add_task');
          }),
          enableFeedback: true,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _Drawer extends StatefulWidget {
  const _Drawer();

  @override
  State<_Drawer> createState() => __DrawerState();
}

class __DrawerState extends State<_Drawer> {
  late TodoemTheme theme;
  late bool isElegant;

  @override
  Widget build(BuildContext context) {
    theme = context.read<ThemeCubit>().state.theme;
    isElegant = context.read<ThemeCubit>().state.elegant;
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(margin: null, child: Text('Settings')),
          const Text('Theme'),
          CheckboxListTile(
              title: const Text('Elegant'),
              value: isElegant,
              onChanged: ((value) {
                if (value != null) {
                  setState(() {
                    isElegant = value;
                    context.read<ThemeCubit>().changeTheme(theme, isElegant);
                  });
                }
              })),
          const Divider(),
          RadioListTile(
              title: const Text('Oxford Blue'),
              value: TodoemTheme.lightOxfordBlue,
              groupValue: theme,
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    theme = value;
                    context.read<ThemeCubit>().changeTheme(theme, isElegant);
                  }
                });
              }),
          RadioListTile(
              title: const Text('Oxford Blue Dark'),
              value: TodoemTheme.darkOxfordBlue,
              groupValue: theme,
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    theme = value;
                    context.read<ThemeCubit>().changeTheme(theme, isElegant);
                  }
                });
              }),
          RadioListTile(
              title: const Text('Orange Web'),
              value: TodoemTheme.lightOrangeWeb,
              groupValue: theme,
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    theme = value;
                    context.read<ThemeCubit>().changeTheme(theme, isElegant);
                  }
                });
              }),
          RadioListTile(
              title: const Text('Orange Web Dark'),
              value: TodoemTheme.darkOrangeWeb,
              groupValue: theme,
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    theme = value;
                    context.read<ThemeCubit>().changeTheme(theme, isElegant);
                  }
                });
              }),
        ],
      ),
    );
  }
}

var task1 = Task(
    id: 'ubb',
    task: 'Call her',
    completed: false,
    createdAt: DateTime.now(),
    repeat: false);

var task2 = Task(
    id: 'seed',
    task: 'Kill myself',
    completed: false,
    createdAt: DateTime.now(),
    repeat: true,
    repeatTime: 'weekly',
    due: DateTime(2022, 10, 14),
    description: 'Do it when I can hopefully soon.');
