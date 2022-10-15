// ignore_for_file: unnecessary_this

part of 'theme_cubit.dart';

enum TodoemTheme {
  lightOxfordBlue,
  darkOxfordBlue,
  lightOrangeWeb,
  darkOrangeWeb,
  black
}

class AppTheme extends Equatable {
  final TodoemTheme theme;
  final bool elegant;

  const AppTheme({required this.theme, this.elegant = false});
  @override
  List<Object?> get props => [theme, elegant];
}

extension Stringify on TodoemTheme {
  String get string => this.toString().split('.').last;
}
