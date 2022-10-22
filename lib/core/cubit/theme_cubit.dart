import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<AppTheme> {
  final Box _settingsBox;
  ThemeCubit(this._settingsBox)
      : super(AppTheme(
            theme: _settingsBox.get('theme'),
            elegant: _settingsBox.get('elegant') ?? false));

  void changeTheme(String? theme, bool elegant) {
    emit(AppTheme(theme: theme, elegant: elegant));
    _settingsBox.putAll({'theme': theme, 'elegant': elegant});
  }
}
