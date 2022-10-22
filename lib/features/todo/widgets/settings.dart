import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoem/core/cubit/theme_cubit.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key});

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  String? theme;
  late bool isElegant;

  @override
  void initState() {
    var s = Hive.box('settings');
    theme = s.get('theme');
    isElegant = s.get('elegant') ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              value: 'lightOxfordBlue',
              groupValue: theme,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    theme = value;
                    context.read<ThemeCubit>().changeTheme(theme, isElegant);
                  });
                }
              }),
          RadioListTile(
              title: const Text('Oxford Blue Dark'),
              value: 'darkOxfordBlue',
              groupValue: theme,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    theme = value;
                    context.read<ThemeCubit>().changeTheme(theme, isElegant);
                  });
                }
              }),
          RadioListTile(
              title: const Text('Orange Web'),
              value: 'lightOrangeWeb',
              groupValue: theme,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    theme = value;
                    context.read<ThemeCubit>().changeTheme(theme, isElegant);
                  });
                }
              }),
          RadioListTile(
              title: const Text('Orange Web Dark'),
              value: 'darkOrangeWeb',
              groupValue: theme,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    theme = value;
                    context.read<ThemeCubit>().changeTheme(theme, isElegant);
                  });
                }
              }),
        ],
      ),
    );
  }
}
