import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoem/features/todo/models/task_model.dart';

import 'core/cubit/theme_cubit.dart';
import 'core/router.dart';
import 'core/style/style.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final fb =
  //     await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
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
