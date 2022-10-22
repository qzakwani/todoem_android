// ignore_for_file: unnecessary_this

part of 'theme_cubit.dart';

class AppTheme extends Equatable {
  final String? theme;
  final bool elegant;

  const AppTheme({required this.theme, this.elegant = false});
  @override
  List<Object?> get props => [theme, elegant];
}

