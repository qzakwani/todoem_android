import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<AppTheme> {
  final TodoemTheme theme;
  final bool elegant;
  final SharedPreferences _preferences;
  ThemeCubit(this.theme, this.elegant, this._preferences)
      : super(AppTheme(theme: theme, elegant: elegant));

  void changeTheme(TodoemTheme theme, bool elegant) {
    _preferences.setString('theme', theme.string);
    _preferences.setBool('elegant', elegant);
    emit(AppTheme(theme: theme, elegant: elegant));
  }
}
