import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoem/core/cubit/theme_cubit.dart';
import 'package:todoem/core/style/style.dart';
import 'package:todoem/firebase_options.dart';
import './core/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final fb =
  //     await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  final pref = await SharedPreferences.getInstance();
  final String? theme = pref.getString('theme');
  final bool? elegant = pref.getBool('elegant');
  runApp(BlocProvider(
    create: (context) => ThemeCubit(_getThemeEnum(theme), elegant ?? false, pref),
    child: const App(),
  ));
}

TodoemTheme _getThemeEnum(String? t) {
  switch (t) {
    case 'lightOxfordBlue':
      return TodoemTheme.lightOxfordBlue;
    case 'darkOxfordBlue':
      return TodoemTheme.darkOxfordBlue;
    case 'lightOrangeWeb':
      return TodoemTheme.lightOrangeWeb;
    case 'darkOrangeWeb':
      return TodoemTheme.darkOrangeWeb;
    default:
      return TodoemTheme.lightOxfordBlue;
  }
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
