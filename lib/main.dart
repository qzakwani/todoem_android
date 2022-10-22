import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoem/features/todo/models/task_model.dart';
import 'package:workmanager/workmanager.dart';

import 'core/cubit/theme_cubit.dart';
import 'core/router.dart';
import 'core/style/style.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  String? taskId;
  try {
    Workmanager().executeTask((task, inputData) async {
      taskId = task;
      DateTime c = DateTime.now();
      late DateTime d;

      switch (inputData!['period']) {
        case 'daily':
          d = c.add(const Duration(days: 1));
          break;
        case 'weekly':
          d = c.add(const Duration(days: 7));
          break;
        case 'monthly':
          d = c.add(const Duration(days: 30));
          break;
        default:
          Workmanager().cancelByUniqueName(task);
          throw ('');
      }

      await Hive.box<Task>('tasks').add(Task(
          task: inputData['task'],
          completed: false,
          createdAt: c,
          due: d,
          repeat: true,
          repeatTime: inputData['period'],
          description: inputData['desc']));
      return Future.value(true);
    });
  } catch (e) {
    if (taskId != null) {
      Workmanager().cancelByUniqueName(taskId!);
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final fb =
  //     await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await Workmanager().initialize(callbackDispatcher);
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  var settingsBox = await Hive.openBox('settings');
  await Hive.openBox<Task>('tasks');
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ThemeCubit(settingsBox),
      ),
      // BlocProvider(create: (context) => TaskBloc(pref)..add(FetchAllTasks())),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, AppTheme>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Styles.getTheme(state.theme, state.elegant),
          initialRoute: 'todo',
          onGenerateRoute: appRouter,
          home: const Root(),
        );
      },
    );
  }
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
