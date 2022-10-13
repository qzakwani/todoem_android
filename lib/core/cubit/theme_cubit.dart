import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<TodoemTheme> {
  final String theme;
  ThemeCubit(this.theme) : super(TodoemTheme.light) {
    switch (theme) {
      case 'todoemLight':
        changeTheme(TodoemTheme.light);
        break;
    }
  }

  void changeTheme(TodoemTheme theme) => emit(theme);
}
