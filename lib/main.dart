import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoem/core/style.dart';
import 'package:todoem/firebase_options.dart';
import './core/router.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final fb =
  //     await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  // final pref = await SharedPreferences.getInstance();
  // final bool? darkMode = pref.getBool('darkMode');
  runApp(App(isDarkMode: false,));
}

class App extends StatelessWidget {
  final bool? isDarkMode;
  const App({super.key, required this.isDarkMode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Styles.lightMode,
      // themeMode:  isDarkMode ?? false ? ThemeMode.dark : ThemeMode.light,
      initialRoute: 'todo',
      onGenerateRoute: appRouter,
      home: const Root(),
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
